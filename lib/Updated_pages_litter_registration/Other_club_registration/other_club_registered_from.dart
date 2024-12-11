import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/Updated_pages_litter_registration/litter_puppy_registration.dart';
import 'package:inkc/dropdownmodel/drop_down_breed_list.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/image_helper.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final imagehelper = ImageHelper();

// class PedigreeDogRegistration extends StatelessWidget {
//   const PedigreeDogRegistration({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "profile UI",
//       home: _Pedigree_Dog_registration(),
//     );
//   }
// }

String userid = "";
String token = "";
String image = "";

class OtherClubRegisteredFromOtherClub extends StatefulWidget {
  const OtherClubRegisteredFromOtherClub({super.key});

  @override
  _OtherClubRegisteredFromOtherClubState createState() =>
      _OtherClubRegisteredFromOtherClubState();
}

class _OtherClubRegisteredFromOtherClubState
    extends State<OtherClubRegisteredFromOtherClub> {
  File? _image;
  File? _sirefrontside;
  File? _sirebackside;
  File? _damfrontside;
  File? _dambackside;

  TextEditingController sire = TextEditingController();
  TextEditingController dam = TextEditingController();
  TextEditingController Dogname = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController cowner = TextEditingController();
  TextEditingController numbers = TextEditingController();

  FocusNode focusNode = FocusNode();

  bool showSpinner = false;

  DateTime date = DateTime.now();
  void selectDatePicker() async {
    DateTime? datepicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));

    if (datepicker != null && datepicker != date) {
      setState(() {
        date = datepicker;
        dateofbirth.value =
            TextEditingValue(text: "${date.day}-${date.month}-${date.year}");
      });
    }
  }

  String? gender = "0";
  String? AddCoOwner = "0";
  String? MicroRequired = "0";

  File? firstImage;
  final _firstpicker = ImagePicker();

  Future getfirstImage() async {
    final pickedFilefirst = await _firstpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFilefirst != null) {
      firstImage = File(pickedFilefirst.path);
      print(firstImage);

      setState(() {});
    } else {
      print('no image  selected');
    }
  }

  // color and making
  List colorandmakingList = [];
  var selectcolormarkingvalue;
  var selectcolormakingid;
  final bool _isShowOff = false;

  Future<List<ColorAndMaking>> getColorAndMaking() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    try {
      final res = await http.post(
          Uri.parse(
              "https://new-demo.inkcdogs.org/api/dog/dog_color_marking_list"),
          headers: requestHeaders);

      final body = json.decode(res.body);
      final list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return ColorAndMaking(
            colourId: map['colour_id'],
            colourCode: map['colour_code'],
            colourName: map['colour_name'],
            colourStatus: map['colour_status'],
            colourUpdatedOn: map['colour_updated_on'],
            colourCreatedOn: map['colour_created_on'],
          );
        }).toList();
      }

      // var datas = jsonDecode(res.body.toString());
      // data = datas['data'];
      setState(() {});
      //print(values.toString());
    } catch (e) {}

    throw Exception('Error fetch data');
  }

  // validator
  bool regisvalidate = false;
  bool kennelvalidate = false;
  bool dogvalidate = false;
  bool datevalidate = false;
  bool breedvalidate = false;
  bool gendervalidator = false;

  bool sirevalide = false;
  String? sireString;
  bool damvalide = false;
  String? DamString;

  uploadData() async {
    setState(() {
      showSpinner = true;
    });

    String SIRE = sire.text.toString();
    String DAM = dam.text.toString();
    String DogName = Dogname.text.toString();
    String DOB = dateofbirth.text.toString();
    String Gender = gender.toString();
    String AddCoowner = AddCoOwner.toString();
    String MICRO = MicroRequired.toString();

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(firstImage!.path,
            filename: "${now.second}.jpg"),
        'pet_gender': Gender,
        'birth_date': DOB,
        'pet_name': DogName,
        'second_owner_id': cowner.text,
        'is_second_owner': AddCoOwner.toString(),
        'is_microchip_require': MICRO,
        'color_marking': selectcolormakingid,
        'dam_reg_number': DAM,
        'sire_reg_number': SIRE,
        'breded_country': counrty.text.toString(),
      });
      print(
          "${"$Gender-$DOB-$DogName-${cowner.text}-$AddCoowner-$MICRO-" + selectcolormakingid}-$DAM-$SIRE");

      Response response = await dio.post(
          'https://new-demo.inkcdogs.org/api/dog/pedigree_dog_registration',
          data: formData,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Usertoken': token,
            'Userid': userid
          }));

      if (response.statusCode == 200) {
        print(response.toString());
        print(response.toString());
        setState(() {
          RefreshCart();
          showSpinner = false;
        });
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success...',
          text: 'SuccessFully Registered',
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SuccessFully Registered')));
      } else {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')));
        print('something worng');
      }

      // images = File(pickedFile.path);
    } catch (e) {
      print('no image  selected false');
    }

    // print(ResNum +
    //     "-" +
    //     KennelId +
    //     "-" +
    //     DogName +
    //     "-" +
    //     DOB +
    //     "-" +
    //     Breed +
    //     "-" +
    //     Gender);

    // var first = new http.ByteStream(firstimages!.openRead());
    // first.cast();

    // var second = new http.ByteStream(secondimages!.openRead());
    // second.cast();

    // var thired = new http.ByteStream(thiredimages!.openRead());
    // thired.cast();

    // var lengthfirst = await firstimages!.length();
    // var lengthsecond = await secondimages!.length();
    // var lengththired = await thiredimages!.length();

    // var uri = Uri.parse("https://new-demo.inkcdogs.org/api/dog/non_inkc_registration");

    // var request = new http.MultipartRequest("POST", uri);

    // SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    // userid = sharedprefrence.getString("Userid")!;
    // token = sharedprefrence.getString("Token")!;

    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   'Usertoken': token,
    //   'Userid': userid
    // };

    // var multipartfirst =
    //     new http.MultipartFile('pet_image', first, lengthfirst);

    // var multipartsecond =
    //     new http.MultipartFile('front_side_certificate', second, lengthsecond);

    // var multiparthired =
    //     new http.MultipartFile('back_side_certificate', thired, lengththired);

    // request.headers.addAll(requestHeaders);
    // request.files.add(multipartfirst);
    // request.files.add(multipartsecond);
    // request.files.add(multiparthired);
    // request.fields["pet_name"] = "Dogname.text";
    // request.fields["pet_registration_number"] = '123';
    // request.fields["kennel_club_prefix"] = selectedid.toString();
    // request.fields["birth_date"] = "16-10-2023";
    // request.fields["pet_gender"] = gender.toString();
    // request.fields["pet_sub_category_id"] = selectedbreedid.toString();
    // add(multipart);
    // request.fields.add(multipart);
    // request.fields.add(multipart);
    // request.fields.add(multipart);

    //  var response = await request.send();

    // print(response.toString());

    // if (response.statusCode == 200) {
    //   setState(() {
    //     showSpinner = false;
    //   });
    //   print('Image Uploaded');
    // } else {
    //   print('Image failed');
    // }
  }

  String? breedid;

  UploadImage() async {
    try {
      String SIRE = sire.text.toString();
      String DAM = dam.text.toString();
      String DogName = Dogname.text.toString();
      String DOB = dateofbirth.text.toString();
      String Gender = gender.toString();
      String AddCoowner = AddCoOwner.toString();
      String MICRO = MicroRequired.toString();
      String sirefront = "";
      String sireback = "";

      if (_image.toString() == "null") {
        SharedPreferences sharedprefrence =
            await SharedPreferences.getInstance();
        userid = sharedprefrence.getString("Userid")!;
        token = sharedprefrence.getString("Token")!;
        Dio dio = Dio();
        DateTime now = DateTime.now();

        FormData formData = FormData.fromMap({
          'dam_front_side_certificate': await MultipartFile.fromFile(
              _damfrontside!.path,
              filename: "${now.second}.jpg"),
          'dam_back_side_certificate': await MultipartFile.fromFile(
              _dambackside!.path,
              filename: "${now.second}.jpg"),
          'sire_front_side_certificate': await MultipartFile.fromFile(
              _sirefrontside!.path,
              filename: "${now.second}.jpg"),
          'sire_back_side_certificate': await MultipartFile.fromFile(
              _sirebackside!.path,
              filename: "${now.second}.jpg"),
        });

        Response response = await dio.post(
            'https://new-demo.inkcdogs.org/api/dog/litter_registration_upload',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        print(response);

        if (response.statusCode == 200) {
          // _image = response[]
          var responseData = jsonDecode(response.data);
          var damfront = responseData['data']['dam_front_side_certificate'];
          var damback = responseData['data']['dam_back_side_certificate'];
          var sirefront = responseData['data']['sire_front_side_certificate'];
          var sireback = responseData['data']['sire_back_side_certificate'];

          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LitterPuppyRegistration(
                    sire: "",
                    dam: "",
                    dob: DOB,
                    country: counrty.text.toString(),
                    puppy: numbers.text.toString(),
                    image: _image.toString(),
                    sirebackcerificate: sireback,
                    sirefrontcerificate: sirefront,
                    damfrontcerificate: damfront,
                    dambackcerificate: damback,
                    petcolordid: breedid.toString(),
                  )));
        } else {
          setState(() {
            showSpinner = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }
      } else {
        SharedPreferences sharedprefrence =
            await SharedPreferences.getInstance();
        userid = sharedprefrence.getString("Userid")!;
        token = sharedprefrence.getString("Token")!;
        Dio dio = Dio();
        DateTime now = DateTime.now();

        FormData formData = FormData.fromMap({
          'stud_agreement_form': await MultipartFile.fromFile(_image!.path,
              filename: "${now.second}.jpg"),
          'dam_front_side_certificate': await MultipartFile.fromFile(
              _damfrontside!.path,
              filename: "${now.second}.jpg"),
          'dam_back_side_certificate': await MultipartFile.fromFile(
              _dambackside!.path,
              filename: "${now.second}.jpg"),
          'sire_front_side_certificate': await MultipartFile.fromFile(
              _sirefrontside!.path,
              filename: "${now.second}.jpg"),
          'sire_back_side_certificate': await MultipartFile.fromFile(
              _sirebackside!.path,
              filename: "${now.second}.jpg"),
        });

        Response response = await dio.post(
            'https://new-demo.inkcdogs.org/api/dog/litter_registration_upload',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        print(response);

        if (response.statusCode == 200) {
          // _image = response[]
          var responseData = jsonDecode(response.data);
          var studAgreementForm = responseData['data']['stud_agreement_form'];
          var damfront = responseData['data']['dam_front_side_certificate'];
          var damback = responseData['data']['dam_back_side_certificate'];
          var sirefront = responseData['data']['sire_front_side_certificate'];
          var sireback = responseData['data']['sire_back_side_certificate'];
          print(studAgreementForm);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LitterPuppyRegistration(
                    sire: "",
                    dam: "",
                    dob: DOB, 
                    country: counrty.text.toString(),
                    puppy: numbers.text.toString(),
                    image: _image.toString(),
                    sirebackcerificate: sireback,
                    sirefrontcerificate: sirefront,
                    damfrontcerificate: damfront,
                    dambackcerificate: damback,
                    petcolordid: breedid.toString(),
                  )));
        } else {
          setState(() {
            showSpinner = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }
      }

      // images = File(pickedFile.path);
    } catch (e) {
      print('no image  selected false');
    }
  }

  // Country
  TextEditingController counrty = TextEditingController();
  bool countryvalidate = false;

  //RefreshCart
  RefreshCart() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/cart/cartready";

    Map<String, String> requestHeaders = {
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
    );
    var data = json.decode(responce.body);
    // setState(() {
    //   showSpinner = false;
    // });

    print("${responce.body} Refresh");
  }

  GetAllDam(String text) async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/dog/get_dam_details";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {
        "dam_reg_number": text.toString(),
      },
    );
    var data = json.decode(responce.body);
    setState(() {
      DamString = data['data'];
      damvalide = true;
      // sire.value = TextEditingValue(text: data['data']);
    });
  }

  GetAllSire(String text) async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/dog/get_sire_details";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {
        "sire_reg_number": text.toString(),
      },
    );
    var data = json.decode(responce.body);
    setState(() {
      sireString = data['data'];
      sirevalide = true;
      // sire.value = TextEditingValue(text: data['data']);
    });
  }

  Future<List<DogBreedList>> getbreedlist() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    try {
      final res = await http.post(
          Uri.parse("https://new-demo.inkcdogs.org/api/dog/dog_breed_list"),
          headers: requestHeaders);

      final body = json.decode(res.body);
      final list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return DogBreedList(
            subCatId: map['sub_cat_id'],
            petCategoryId: map['pet_category_id'],
            subCategoryName: map['sub_category_name'],
            subCategoryCode: map['sub_category_code'],
            subCatSlug: map['sub_cat_slug'],
            subCatStudSlug: map['sub_cat_stud_slug'],
            subCatImage: map['sub_cat_image'],
            subIsDiscounted: map['sub_is_discounted'],
            subCategoryStatus: map['sub_category_status'],
            subCategoryUpdatedOn: map['sub_category_updated_on'],
            subCategoryCreatedOn: map['sub_category_created_on'],
          );
        }).toList();
      }

      // var datas = jsonDecode(res.body.toString());
      // data = datas['data'];
      setState(() {});
      print(list);
    } catch (e) {}

    throw Exception('Error fetch data');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back,
                //       color: Color.fromARGB(255, 223, 39, 39)),
                //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: (BuildContext context) => AddDogInfo())),
                // ),
                title: const Column(
                  children: [
                    Text(
                      'Litter Registration',
                      style: TextStyle(
                          fontSize: 16,
                          decorationColor: Color.fromARGB(255, 66, 47, 45),
                          color: Color.fromARGB(255, 48, 40, 35),
                          // color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(Both Parents Registered With Other Clubs)',
                      style: TextStyle(
                          fontSize: 12,
                          decorationColor: Color.fromARGB(255, 66, 47, 45),
                          color: Color.fromARGB(255, 48, 40, 35),
                          // color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Sire's front side of the certificate",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _sirefrontside != null
                                  ? FileImage(_sirefrontside!)
                                  : null,
                              child: const Text(
                                "Select image",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 199, 7, 7),
                            ),
                            onPressed: () async {
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() =>
                                      _sirefrontside = File(cropperFile.path));
                                  print(
                                      "justcheck$_sirefrontside");
                                }
                              }
                            },
                            child: const Text(
                              'Pick Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Sire's back side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _sirebackside != null
                                  ? FileImage(_sirebackside!)
                                  : null,
                              child: const Text(
                                "Select image",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 199, 7, 7),
                            ),
                            onPressed: () async {
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() =>
                                      _sirebackside = File(cropperFile.path));
                                  print("justcheck$_sirebackside");
                                }
                              }
                            },
                            child: const Text(
                              'Pick Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Dam's front side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _damfrontside != null
                                  ? FileImage(_damfrontside!)
                                  : null,
                              child: const Text(
                                "Select image",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 199, 7, 7),
                            ),
                            onPressed: () async {
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() =>
                                      _damfrontside = File(cropperFile.path));
                                  print("justcheck$_damfrontside");
                                }
                              }
                            },
                            child: const Text(
                              'Pick Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Dam's back side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _dambackside != null
                                  ? FileImage(_dambackside!)
                                  : null,
                              child: const Text(
                                "Select image",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 199, 7, 7),
                            ),
                            onPressed: () async {
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() =>
                                      _dambackside = File(cropperFile.path));
                                  print("justcheck$_dambackside");
                                }
                              }
                            },
                            child: const Text(
                              'Pick Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Stud agreement form ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: CircleAvatar(
                                      backgroundColor: const Color(0xEBA020F0),
                                      radius: 64,
                                      foregroundImage: _image != null
                                          ? FileImage(_image!)
                                          : null,
                                      child: const Text(
                                        "Select image",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 199, 7, 7),
                                    ),
                                    onPressed: () async {
                                      final files =
                                          await imagehelper.PickImage();
                                      if (files.isNotEmpty) {
                                        final cropperFile =
                                            await imagehelper.crop(
                                                file: files.first,
                                                cropStyle: CropStyle.circle);
                                        if (cropperFile != null) {
                                          setState(() =>
                                              _image = File(cropperFile.path));
                                          print(
                                              "justcheck$_image");
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Pick Image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Date of Birth ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      width: 160.sp,
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        onTap: () {},
                                        controller: dateofbirth,
                                        enabled: false,
                                        // obscureText: true,
                                        decoration: InputDecoration(
                                          filled: true,

                                          fillColor: Colors.white,
                                          // suffixIcon: IconButton(
                                          //   icon: Icon(Icons.date_range),
                                          //   onPressed: () {
                                          //     setState(
                                          //       () {},
                                          //     );
                                          //   },
                                          // ),
                                          prefixIcon:
                                              const Icon(Icons.date_range),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.sp)),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.green),
                                          ),
                                          labelText: 'Date of Birth',
                                          errorText: datevalidate
                                              ? "Value Can't Be Empty"
                                              : null,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 231, 25, 25),
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color.fromARGB(
                                                    255, 241, 236, 236),
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          selectDatePicker();
                                        },
                                        child: const Text(
                                          'Pick date',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Breed of the dog ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              FutureBuilder<List<DogBreedList>>(
                                  future: getbreedlist(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text("Error: ${snapshot.error}"));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text("No data found"));
                                    } else {
                                      // DropDownKennelName? selectedItem =
                                      //     findItemById(snapshot.data!, selectedId);

                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 8.0,
                                            left: 8,
                                            right: 8,
                                            bottom: 8),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: DropdownSearch<DogBreedList>(
                                            items: snapshot.data!,
                                            itemAsString:
                                                (DogBreedList? model) =>
                                                    model?.subCategoryName ??
                                                    "",
                                            // selectedItem:
                                            //     snapshot.data![getcountry],
                                            onChanged:
                                                (DogBreedList? selectedItem) {
                                              setState(() {
                                                breedid =
                                                    selectedItem?.subCatId;
                                                print(breedid.toString());
                                              });
                                              // setState(() {
                                              //   countrybool = true;
                                              //   widget.Stategetdata = "";
                                              //   widget.Districtgetdata = "";
                                              //   getcountry = int.parse(
                                              //           "${selectedItem?.countryId}") -
                                              //       1;

                                              //   setState(() {
                                              //     selectebreedvalue =
                                              //         selectedItem?.countryId;
                                              //     selectedbreedid =
                                              //         selectedItem?.countryId;

                                              //     _changeId(selectedbreedid);
                                              //   });
                                              // });
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // labelText: "Select Color/Pattern",
                                                hintText: "Choose one",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              fit: FlexFit.loose,
                                              itemBuilder:
                                                  (context, item, isSelected) {
                                                return ListTile(
                                                  title: Text(
                                                    item.subCategoryName ?? "",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 95, 46, 46),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                );
                                              },
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItem) {
                                              return Text(
                                                selectedItem?.subCategoryName ??
                                                    "",
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 95, 46, 46),
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ); // Display the selected item's name
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Country Bred In ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: counrty,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    hintText: 'Eg.India',
                                    errorText: countryvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Number of puppies in the litter ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  maxLines: 1,
                                  enabled: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9,]')),
                                  ],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  controller: numbers,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    hintText: 'Number of litter',
                                    errorText: countryvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 23, 4, 190),
                                        textStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromARGB(
                                                255, 241, 236, 236),
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      String SIRE = sire.text.toString();
                                      String DAM = dam.text.toString();
                                      String DogName = Dogname.text.toString();
                                      String DOB = dateofbirth.text.toString();
                                      String Gender = gender.toString();
                                      String AddCoowner = AddCoOwner.toString();
                                      String MICRO = MicroRequired.toString();

                                      if (numbers.text.toString().isNotEmpty &&
                                          int.parse(numbers.text.toString()) <=
                                              10) {
                                        if (_damfrontside.toString() ==
                                            "null") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Please Select Dam's KCI front side of the certificate")));
                                        } else if (_dambackside.toString() ==
                                            "null") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Please Select Dam's KCI back side of the certificate")));
                                        } else if (_sirebackside.toString() ==
                                            "null") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Please Select Sire's KCI back side of the certificate")));
                                        } else if (_sirebackside.toString() ==
                                            "null") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Please Select Sire's KCI back side of the certificate")));
                                        } else {
                                          UploadImage();
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please enter puppy 0 to 10 only')));
                                      }
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

//   UploadData() async {}
}
