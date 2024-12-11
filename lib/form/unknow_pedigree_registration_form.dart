import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/drop_down_breed_list.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class UnknowPedigreeDogRegistrationForm extends StatelessWidget {
  const UnknowPedigreeDogRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "profile UI",
      home: _UnknowPedigreeDogRegistrationForm(),
    );
  }
}

String userid = "";
String token = "";
String image = "";

class _UnknowPedigreeDogRegistrationForm extends StatefulWidget {
  @override
  __UnknowPedigreeDogRegistrationFormState createState() =>
      __UnknowPedigreeDogRegistrationFormState();
}

class __UnknowPedigreeDogRegistrationFormState
    extends State<_UnknowPedigreeDogRegistrationForm> {
  TextEditingController sire = TextEditingController();
  TextEditingController dam = TextEditingController();
  TextEditingController Dogname = TextEditingController();
  TextEditingController Dognamehight = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController cowner = TextEditingController();

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
        dateofbirth.value = TextEditingValue(
            text: "${date.day}-${date.month}-${date.year}");
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

  File? secondImage;
  final _secondpicker = ImagePicker();

  Future getsecondImage() async {
    final pickedFilesecond = await _secondpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFilesecond != null) {
      secondImage = File(pickedFilesecond.path);
      print(secondImage);

      setState(() {});
    } else {
      print('no image  selected');
    }
  }

  File? thiredImage;
  final _thiredpicker = ImagePicker();
  Future getthardImage() async {
    final pickedFilethired = await _thiredpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFilethired != null) {
      thiredImage = File(pickedFilethired.path);
      print(thiredImage);

      setState(() {});
    } else {
      print('no image  selected');
    }
  }

  // color and making
  List colorandmakingList = [];
  var selectcolormarkingvalue;
  var selectcolormakingid;
  bool _isShowOff = false;

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
          Uri.parse("https://new-demo.inkcdogs.org/api/dog/dog_color_marking_list"),
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
  bool dogvalidatehight = false;
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
    String Breed = selectedbreedid.toString();
    String hight = Dognamehight.text.toString();

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(firstImage!.path,
            filename: "${now.second}.jpg"),
        'pet_height_image': await MultipartFile.fromFile(secondImage!.path,
            filename: "${now.second}.jpg"),
        'pet_side_image': await MultipartFile.fromFile(thiredImage!.path,
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
        'pet_sub_category_id': Breed,
        'pet_height_inches': hight,
      });
      print("${"$Gender-$DOB-$DogName-${cowner.text}-$AddCoowner-$MICRO-" +
          selectcolormakingid}-$DAM-$SIRE");

      Response response = await dio.post(
          'https://new-demo.inkcdogs.org/api/dog/unknown_pedigree_dog_registration',
          data: formData,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Usertoken': token,
            'Userid': userid
          }));

      if (response.statusCode == 200) {
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

  //breed

  // Dog Breed
  List breedlist = [];
  var selectebreedvalue;
  var selectedbreedid;

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
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
                //   onPressed: () => Navigator.of(context).pop(),
                // ),
                title: const Text(
                  'Unknown Pedigree Dog Registration',
                  style: TextStyle(
                      fontSize: 17,
                      decorationColor: Color.fromARGB(255, 66, 47, 45),
                      color: Color.fromARGB(255, 48, 40, 35),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 16, top: 5, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Sire's INKC Registration Number",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            // Text(
                            //   "*",
                            //   style: TextStyle(
                            //       color: Color.fromARGB(255, 231, 11, 11),
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 15.sp),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  onChanged: (value) {
                                    GetAllSire(sire.text.toString());
                                  },
                                  controller: sire,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText:
                                        "Sire's INKC Registration Number",
                                    hintText: "Sire's INKC Registration Number",
                                    errorText: regisvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: sirevalide,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    sireString.toString(),
                                    style: const TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Dam's INKC Registration Number",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    // Text(
                                    //   "*",
                                    //   style: TextStyle(
                                    //       color: Color.fromARGB(255, 231, 11, 11),
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15.sp),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  onChanged: (value) {
                                    GetAllDam(dam.text.toString());
                                  },
                                  controller: dam,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: "Dam's INKC Registration Number",
                                    hintText: "Dam's INKC Registration Number",
                                    errorText: regisvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: damvalide,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DamString.toString(),
                                    style: const TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Add Co Owner ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                // decoration: BoxDecoration(
                                //   boxShadow: [],
                                //   border: Border.all(
                                //     color: Colors.black,
                                //     width: 0.5,
                                //   ),
                                //   borderRadius: BorderRadius.circular(4.sp),
                                //   color: Colors.white,
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: "0",
                                                groupValue: AddCoOwner,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isShowOff = false;
                                                    AddCoOwner =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "1",
                                                groupValue: AddCoOwner,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isShowOff = true;
                                                    AddCoOwner =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: _isShowOff,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 12),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Co Owner ID ",
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
                                        child: TextField(
                                          controller: cowner,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.sp)),
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.green),
                                            ),
                                            labelText: 'Co Owner ID',
                                            hintText: 'Co Owner ID',
                                            errorText: dogvalidate
                                                ? "Value Can't Be Empty"
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name of the dog ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: Dogname,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Name of the dog',
                                    hintText: 'Eg.Bruno',
                                    errorText: dogvalidate
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
                                      "Date of Birth ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
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
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        onTap: () {},
                                        controller: dateofbirth,
                                        enabled: false,
                                        // obscureText: true,
                                        decoration: InputDecoration(
                                          // suffixIcon: IconButton(
                                          //   icon: Icon(Icons.date_range),
                                          //   onPressed: () {
                                          //     setState(
                                          //       () {},
                                          //     );
                                          //   },
                                          // ),
                                          prefixIcon: const Icon(Icons.date_range),
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
                                            backgroundColor: const Color.fromARGB(
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
                                      "Breed ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.all(8),
                              //   child: TextField(
                              //     maxLines: null,
                              //     controller: address,
                              //     // obscureText: true,
                              //     decoration: InputDecoration(
                              //       border: OutlineInputBorder(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(4.sp)),
                              //         borderSide:
                              //             BorderSide(width: 1, color: Colors.green),
                              //       ),
                              //       labelText: 'Breed',
                              //     ),
                              //   ),
                              // ),

                              FutureBuilder<List<DogBreedList>>(
                                  future: getbreedlist(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectebreedvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectebreedvalue = value;
                                                  selectedbreedid = value;
                                                });
                                              },
                                              hint: const Text('Select value'),
                                              items: snapshot.data!.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.subCatId.toString(),
                                                  child: SizedBox(
                                                    width: double
                                                        .infinity, // Auto size based on content
                                                    child: Text(
                                                      e.subCategoryName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: const Color.fromARGB(
                                                              255, 95, 46, 46),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        //  DropdownButtonFormField(
                                        //     decoration: InputDecoration(
                                        //       contentPadding:
                                        //           const EdgeInsets.only(
                                        //               left: 10, right: 10),
                                        //       border: OutlineInputBorder(
                                        //           borderRadius: BorderRadius.all(
                                        //               Radius.circular(10))),
                                        //     ),
                                        //     hint: Text('Select value'),
                                        //     isExpanded: true,
                                        //     value: selectebreedvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e.subCatId.toString(),
                                        //           child: Text(
                                        //             e.subCategoryName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       selectebreedvalue = value;
                                        //       selectedbreedid = value;
                                        //       setState(() {});
                                        //     }),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  }),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Color and Marking ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              FutureBuilder<List<ColorAndMaking>>(
                                  future: getColorAndMaking(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectcolormarkingvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectcolormarkingvalue =
                                                      value;
                                                  selectcolormakingid = value;
                                                });
                                              },
                                              hint: const Text('Select value'),
                                              items: snapshot.data!.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.colourId.toString(),
                                                  child: SizedBox(
                                                    width: double
                                                        .infinity, // Auto size based on content
                                                    child: Text(
                                                      e.colourName.toString(),
                                                      style: TextStyle(
                                                          color: const Color.fromARGB(
                                                              255, 95, 46, 46),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        //  DropdownButtonFormField(
                                        //     decoration: InputDecoration(
                                        //       contentPadding:
                                        //           const EdgeInsets.only(
                                        //               left: 30, right: 10),
                                        //       border: OutlineInputBorder(
                                        //           borderRadius: BorderRadius.all(
                                        //               Radius.circular(10))),
                                        //     ),
                                        //     hint: Text('Select value'),
                                        //     isExpanded: true,
                                        //     value: selectcolormarkingvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e.colourId.toString(),
                                        //           child: Text(
                                        //             e.colourName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 11.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       selectcolormarkingvalue = value;
                                        //       selectcolormakingid = value;
                                        //       setState(() {});
                                        //     }),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  }),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sex of the dog ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  boxShadow: const [],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: "1",
                                                groupValue: gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Male',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "0",
                                                groupValue: gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Female',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Country Bred In ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  controller: counrty,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Country Bred in',
                                    hintText: 'Eg.India',
                                    errorText: countryvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Upload your dog’s best photograph ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: firstImage == null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 60.sp, right: 60.sp),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(255, 199, 5, 5),
                                          ),
                                          onPressed: () async {
                                            getfirstImage();
                                          },
                                          child: const Text(
                                            'Pick Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          getfirstImage();
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 130.sp,
                                              height: 130.sp,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset: const Offset(0, 10))
                                                  ],
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        File(firstImage!.path)
                                                            .absolute),
                                                    fit: BoxFit.cover,
                                                  )
                                                  // image: DecorationImage(
                                                  //   image: NetworkImage(
                                                  //       "https://new-demo.inkcdogs.org/${image}"),
                                                  //   fit: BoxFit.cover, //change image fill type
                                                  // ),
                                                  ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(
                                                    255, 179, 3, 3),
                                              ),
                                              onPressed: () async {
                                                getfirstImage();
                                              },
                                              child: const Text(
                                                'Change Image',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Height (in inches) ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: Dognamehight,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Height (in inches)',
                                    hintText: '',
                                    errorText: dogvalidatehight
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Photograph of the dog's height ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 73, 72, 72),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: secondImage == null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 60.sp, right: 60.sp),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(255, 182, 5, 5),
                                          ),
                                          onPressed: () async {
                                            getsecondImage();
                                          },
                                          child: const Text(
                                            'Pick Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          getsecondImage();
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 130.sp,
                                              height: 130.sp,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset: const Offset(0, 10))
                                                  ],
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        File(secondImage!.path)
                                                            .absolute),
                                                    fit: BoxFit.cover,
                                                  )
                                                  // image: DecorationImage(
                                                  //   image: NetworkImage(
                                                  //       "https://new-demo.inkcdogs.org/${image}"),
                                                  //   fit: BoxFit.cover, //change image fill type
                                                  // ),
                                                  ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(
                                                    255, 180, 5, 5),
                                              ),
                                              onPressed: () async {
                                                getsecondImage();
                                              },
                                              child: const Text(
                                                'Change Image',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Photograph of the dog from one side ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: thiredImage == null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 60.sp, right: 60.sp),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(255, 168, 3, 3),
                                          ),
                                          onPressed: () async {
                                            getthardImage();
                                          },
                                          child: const Text(
                                            'Pick Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          getthardImage();
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 130.sp,
                                              height: 130.sp,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset: const Offset(0, 10))
                                                  ],
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        File(thiredImage!.path)
                                                            .absolute),
                                                    fit: BoxFit.cover,
                                                  )
                                                  // image: DecorationImage(
                                                  //   image: NetworkImage(
                                                  //       "https://new-demo.inkcdogs.org/${image}"),
                                                  //   fit: BoxFit.cover, //change image fill type
                                                  // ),
                                                  ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(
                                                    255, 153, 2, 2),
                                              ),
                                              onPressed: () async {
                                                getthardImage();
                                              },
                                              child: const Text(
                                                'Change Image',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Microchip required ",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              const Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  boxShadow: const [],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: "1",
                                                groupValue: MicroRequired,
                                                onChanged: (value) {
                                                  setState(() {
                                                    MicroRequired =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes, I require a microchip for my dog',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "0",
                                                groupValue: MicroRequired,
                                                onChanged: (value) {
                                                  setState(() {
                                                    MicroRequired =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No, I don’t require a microchip for my dog',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color.fromARGB(255, 20, 10, 151),
                                        textStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromARGB(
                                                255, 241, 236, 236),
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      if (firstImage.toString() == "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please Select Dog best photograph',
                                        );
                                      } else {
                                        if (secondImage.toString() == "null") {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text:
                                                'Please Select dog hight photograph',
                                          );
                                        } else {
                                          if (thiredImage.toString() ==
                                              "null") {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Oops...',
                                              text:
                                                  'Please Select dog one  side photograph',
                                            );
                                          } else {
                                            {
                                              if (Dogname.text.toString() ==
                                                  "") {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.error,
                                                  title: 'Oops...',
                                                  text: 'Please Enter Dog Name',
                                                );
                                              } else {
                                                if (dateofbirth.text
                                                        .toString() ==
                                                    "") {
                                                  QuickAlert.show(
                                                    context: context,
                                                    type: QuickAlertType.error,
                                                    title: 'Oops...',
                                                    text: 'Please Select date',
                                                  );
                                                } else {
                                                  if (selectedbreedid
                                                          .toString() ==
                                                      "null") {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type:
                                                          QuickAlertType.error,
                                                      title: 'Oops...',
                                                      text:
                                                          'Please Select Breed',
                                                    );
                                                  } else {
                                                    if (selectcolormakingid
                                                            .toString() ==
                                                        "null") {
                                                      QuickAlert.show(
                                                        context: context,
                                                        type: QuickAlertType
                                                            .error,
                                                        title: 'Oops...',
                                                        text:
                                                            'Please Select Color and making',
                                                      );
                                                    } else {
                                                      if (counrty.text
                                                              .toString() ==
                                                          "") {
                                                        QuickAlert.show(
                                                          context: context,
                                                          type: QuickAlertType
                                                              .error,
                                                          title: 'Oops...',
                                                          text:
                                                              'Please Enter Country',
                                                        );
                                                      } else {
                                                        if (AddCoOwner
                                                                .toString() ==
                                                            "0") {
                                                          uploadData();
                                                        } else {
                                                          if (cowner.text
                                                                  .toString() ==
                                                              "") {
                                                            QuickAlert.show(
                                                              context: context,
                                                              type:
                                                                  QuickAlertType
                                                                      .error,
                                                              title: 'Oops...',
                                                              text:
                                                                  'Please Enter Cower Id',
                                                            );
                                                          } else {
                                                            uploadData();
                                                          }
                                                        }
                                                      }
                                                      //uploadData();
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                      // if (dog.toString().isEmpty) {
                                      //   setState(() {
                                      //     dogvalidate = Dogname.text.isEmpty;
                                      //   });
                                      // } else if (registernum.toString().isEmpty) {
                                      //   setState(() {
                                      //     regisvalidate =
                                      //         Registornumber.text.isEmpty;
                                      //   });
                                      // } else if (kenel.toString().isEmpty) {
                                      //   setState(() {
                                      //     kennelvalidate = selectedid.text.isEmpty;
                                      //   });
                                      // } else if (breed.toString().isEmpty) {
                                      //   setState(() {
                                      //     breedvalidate =
                                      //         selectedbreedid.text.isEmpty;
                                      //   });
                                      // } else if (date.toString().isEmpty) {
                                      //   setState(() {
                                      //     datevalidate = dateofbirth.text.isEmpty;
                                      //   });
                                      // } else if (genders.toString().isEmpty) {
                                      //   setState(() {
                                      //     gendervalidator =
                                      //         gender.toString().isEmpty;
                                      //   });
                                      // } else {}
                                      // String kennelname = selectedid;
                                      // String dogid = selectedbreedid;
                                      print(gender.toString());

                                      // uploadData();
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
