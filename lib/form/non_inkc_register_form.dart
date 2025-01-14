import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/drop_down_breed_list.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/dropdownmodel/drop_down_model_kennel_name.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class NonInkcRegistrationForm extends StatelessWidget {
  const NonInkcRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "profile UI",
      home: _NonInkcRegisterFormState(),
    );
  }
}

String userid = "";
String token = "";
String image = "";

class _NonInkcRegisterFormState extends StatefulWidget {
  @override
  __NonInkcRegisterFormStateState createState() =>
      __NonInkcRegisterFormStateState();
}

class __NonInkcRegisterFormStateState extends State<_NonInkcRegisterFormState> {
  TextEditingController Registornumber = TextEditingController();
  TextEditingController Dogname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController personalid = TextEditingController();

  FocusNode focusNode = FocusNode();

  File? firstimages;
  final _firstpickers = ImagePicker();

  File? secondimages;
  final _secondpickers = ImagePicker();

  File? thiredimages;
  final _thiredpickers = ImagePicker();

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

  String? gender = "1";

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

  // drop - down list
  // kennel name
  List data = [];
  final int _value = 1;
  var selectedvalue;
  var selectedid;

  // Dog Breed
  List breedlist = [];
  var selectebreedvalue;
  var selectedbreedid;

  Future<List<DropDownKennelName>> getkennelclub() async {
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
              "https://new-demo.inkcdogs.org/api/dog/kennel_list_for_non_inkc"),
          headers: requestHeaders);
      // var data = json.decode(res.body);
      // var dataarray = data['data'];
      // print(dataarray);

      final body = json.decode(res.body);
      final list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownKennelName(
            kennelClubId: map['kennel_club_id'],
            kennelClubName: map['kennel_club_name'],
            kennelClubPrefix: map['kennel_club_prefix'],
            kennelClubStatus: map['kennel_club_status'],
            kennelClubUpdatedOn: map['kennel_club_updated_on'],
            kennelClubCreatedOn: map['kennel_club_created_on'],
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

  // validator
  bool regisvalidate = false;
  bool kennelvalidate = false;
  bool dogvalidate = false;
  bool datevalidate = false;
  bool breedvalidate = false;
  bool gendervalidator = false;

  uploadData() async {
    setState(() {
      showSpinner = true;
    });

    String ResNum = Registornumber.text.toString();
    String KennelId = selectedid.toString();
    String DogName = Dogname.text.toString();
    String DOB = dateofbirth.text.toString();
    String Breed = selectedbreedid.toString();
    String Gender = gender.toString();
    String color = selectcolormakingid.toString();

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(firstImage!.path,
            filename: "${now.second}.jpg"),
        'front_side_certificate': await MultipartFile.fromFile(
            secondImage!.path,
            filename: "${now.second}.jpg"),
        'back_side_certificate': await MultipartFile.fromFile(thiredImage!.path,
            filename: "${now.second}.jpg"),
        'pet_sub_category_id': Breed,
        'kennel_club_prefix': KennelId,
        'pet_gender': Gender,
        'color_marking': color,
        'birth_date': DOB,
        'pet_name': DogName,
        'pet_registration_number': ResNum,
        'breded_country': counrty.text.toString(),
      });

      Response response = await dio.post(
          'https://new-demo.inkcdogs.org/api/dog/non_inkc_registration',
          data: formData,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Usertoken': token,
            'Userid': userid
          }));

      if (response.statusCode == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success...',
          text: 'SuccessFully Registered',
        );

        print(response.toString());
        setState(() {
          RefreshCart();
          showSpinner = false;
        });

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
      setState(() {
        showSpinner = false;
      });
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

  // Color and making

  List colorandmakingList = [];
  var selectcolormarkingvalue;
  var selectcolormakingid;

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

// Country
  TextEditingController counrty = TextEditingController();
  bool countryvalidate = false;

  //RefreshCart
  RefreshCart() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

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
                //   onPressed: () => Navigator.pop(context),
                // ),
                title: const Text(
                  'Non-INKC Registration',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color:
                              Color.fromARGB(255, 223, 71, 45), // shadow color
                          offset:
                              Offset(2.0, 2.0), // how much shadow will be shown
                        ),
                      ],
                      fontSize: 25,
                      decorationColor: Colors.red,
                      color: Color.fromARGB(255, 194, 97, 33),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Your dog’s photograph ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Container(
                        child: firstImage == null
                            ? Container(
                                margin:
                                    EdgeInsets.only(left: 60.sp, right: 60.sp),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 187, 4, 4),
                                  ),
                                  onPressed: () async {
                                    getfirstImage();
                                  },
                                  child: const Text(
                                    'Pick Image',
                                    style: TextStyle(color: Colors.white),
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
                                            255, 199, 7, 7),
                                      ),
                                      onPressed: () async {
                                        getfirstImage();
                                      },
                                      child: const Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
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
                              "Front side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 73, 72, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Container(
                        child: secondImage == null
                            ? Container(
                                margin:
                                    EdgeInsets.only(left: 60.sp, right: 60.sp),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 197, 4, 4),
                                  ),
                                  onPressed: () async {
                                    getsecondImage();
                                  },
                                  child: const Text(
                                    'Pick Image',
                                    style: TextStyle(color: Colors.white),
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
                                            255, 199, 13, 13),
                                      ),
                                      onPressed: () async {
                                        getsecondImage();
                                      },
                                      child: const Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
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
                              "Back side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Container(
                        child: thiredImage == null
                            ? Container(
                                margin:
                                    EdgeInsets.only(left: 60.sp, right: 60.sp),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 199, 13, 13),
                                  ),
                                  onPressed: () async {
                                    getthardImage();
                                  },
                                  child: const Text(
                                    'Pick Image',
                                    style: TextStyle(color: Colors.white),
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
                                            255, 187, 9, 9),
                                      ),
                                      onPressed: () async {
                                        getthardImage();
                                      },
                                      child: const Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Registration Number ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: Registornumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Registration Number',
                                    hintText: 'Non INKC registration number',
                                    errorText: regisvalidate
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
                                      "Kennel Club ",
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
                              FutureBuilder<List<DropDownKennelName>>(
                                  future: getkennelclub(),
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
                                              value: selectedvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedvalue = value;
                                                  selectedid = value;
                                                });
                                              },
                                              hint: const Text('Select value'),
                                              items: snapshot.data!.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value:
                                                      e.kennelClubId.toString(),
                                                  child: SizedBox(
                                                    width: double
                                                        .infinity, // Auto size based on content
                                                    child: Text(
                                                      e.kennelClubName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
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
                                        // DropdownButtonFormField(
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
                                        //     value: selectedvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value:
                                        //               e.kennelClubId.toString(),
                                        //           child: Text(
                                        //             e.kennelClubName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       selectedvalue = value;
                                        //       selectedid = value;
                                        //       setState(() {});
                                        //     }),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  }),
                              // Padding(
                              //   padding: EdgeInsets.all(18),
                              //   child: DropdownButton(
                              //     items: data.map((e) {
                              //       print(e["kennel_club_name"]);

                              //       return DropdownMenuItem(
                              //           child: Text(
                              //             e["kennel_club_name"],
                              //             style: TextStyle(color: Colors.black),
                              //           ),
                              //           value: e["kennel_club_id"]);
                              //     }).toList(),
                              //     onChanged: (value) {
                              //       _value = value as int;
                              //       setState(() {});
                              //     },
                              //     // obscureText: true,
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name of the dog ",
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
                                      "Breed ",
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
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
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
                                                          color: const Color
                                                              .fromARGB(
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
                                        // DropdownButtonFormField(
                                        //     decoration: InputDecoration(
                                        //       contentPadding:
                                        //           const EdgeInsets.only(
                                        //               left: 10, right: 5),
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
                              FutureBuilder<List<ColorAndMaking>>(
                                  future: getColorAndMaking(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
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
                                                          color: const Color
                                                              .fromARGB(
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
                                        // DropdownButtonFormField(
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
                                        //     value: selectcolormarkingvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e.colourId.toString(),
                                        //           child: Text(
                                        //             e.colourName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 12.sp,
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
                                      "Gender ",
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
                                                    fontSize: 13.sp),
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
                                                    fontSize: 13.sp),
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
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (firstImage.toString() == "null") {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: 'Oops...',
                                        text: 'Please Select Dog photograph',
                                      );
                                    } else {
                                      if (secondImage.toString() == "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please Select front side certificate',
                                        );
                                      } else {
                                        if (thiredImage.toString() == "null") {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text:
                                                'Please Select back side certificate',
                                          );
                                        } else {
                                          if (Registornumber.text.toString() ==
                                              "") {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Oops...',
                                              text:
                                                  'Please Enter registration number',
                                            );
                                          } else {
                                            if (selectedid.toString() ==
                                                "null") {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: 'Oops...',
                                                text:
                                                    'Please Select Kennel club',
                                              );
                                            } else {
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
                                                              'Please Enter country',
                                                        );
                                                      } else {
                                                        uploadData();
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }

                                    // String ResNum = Registornumber.text;
                                    // String KennelId = selectedid;
                                    // String DogName = Dogname.text;
                                    // String DOB = dateofbirth.text;
                                    // String Breed = selectedbreedid;
                                    // String Gender = gender.toString();
                                    // String color = selectcolormakingid.toString();

                                    print(
                                        "${Registornumber.text} - $selectedid - ${Dogname.text} - ${dateofbirth.text} - $selectedbreedid - $gender - $selectcolormakingid");

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

                                    //uploadData();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 46, 6, 155),
                                      textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: const Color.fromARGB(
                                              255, 241, 236, 236),
                                          fontWeight: FontWeight.bold)),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
