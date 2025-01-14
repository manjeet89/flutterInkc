import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/id_cart.dart';
import 'package:inkc/model/profilemodel.dart';
import 'package:inkc/profile_update.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "profile UI",
      home: EditProfilePage(),
    );
  }
}

String userid = "";
String token = "";
String image = "";

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController MyController = TextEditingController();
  TextEditingController First = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController personalid = TextEditingController();

  FocusNode focusNode = FocusNode();

  File? images;
  bool showSpinner = false;
  String? gender;
  String? DOB;

  // Future getImage() async {
  //   final pickedFile = await _firstpicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 80);

  //   if (pickedFile != null) {
  //     images = File(pickedFile.path);

  //     setState(() {
  //       uploadImage();
  //     });
  //   } else {
  //     print('no image  selected');
  //   }
  // }

  // Future<void> uploadImage() async {
  //   setState(() {
  //     showSpinner = true;
  //   });

  //   var stream = new http.ByteStream(images!.openRead());
  //   stream.cast();

  //   var length = await images!.length();

  //   var uri = Uri.parse("https://new-demo.inkcdogs.org/api/user/update_profile_image");

  //   var request = new http.MultipartRequest("POST", uri);

  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   userid = sharedprefrence.getString("Userid")!;
  //   token = sharedprefrence.getString("Token")!;

  //   request.headers['Usertoken'] = token;
  //   request.headers['Userid'] = token;

  //   var multipart =
  //       new http.MultipartFile('user_profile_image', stream, length);
  //   request.files.add(multipart);

  //   var response = await request.send();

  //   print(response.toString());

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       showSpinner = false;
  //     });
  //     print('Image Uploaded');
  //   } else {
  //     print('Image failed');
  //   }
  // }

  // final List<ProfileModel> profileadd = [];

  // Future<List<ProfileModel>> fetchjson() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   userid = sharedprefrence.getString("Userid")!;
  //   token = sharedprefrence.getString("Token")!;

  //   // print('${userid} / ${token}');

  //   final uri = "https://new-demo.inkcdogs.org/api/user/user_profile";

  XFile? pickerFiles;
  final _firstpicker = ImagePicker();

  Future getImagedata() async {
    final pickedFile = await _firstpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      showSpinner = true;
    });
    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      if (pickedFile != null) {
        FormData formData = FormData.fromMap({
          'user_profile_image': await MultipartFile.fromFile(pickedFile.path,
              filename: "${now.second}.jpg"),
        });

        Response response = await dio.post(
            'https://new-demo.inkcdogs.org/api/user/update_profile_image',
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
            showSpinner = false;
          });
        } else {
          setState(() {
            showSpinner = false;
          });
          print('something worng');
        }

        // images = File(pickedFile.path);
      } else {
        print('no image  selected');

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'No Image Seleced',
            style: TextStyle(color: Color.fromARGB(255, 12, 2, 2)),
          ),
          backgroundColor: Color.fromARGB(255, 236, 234, 241),
        ));

        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      print('no image  selected false');
    }
  }
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Usertoken': token,
  //     'Userid': userid
  //   };

  //   final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
  //   var data = json.decode(responce.body);

  //   List<ProfileModel> promodel = [];

  //   if (data['code'] == 200) {
  //     var datas = data['data'];
  //     print(data['data']);

  //     for (var jsondata in datas) {
  //       promodel.add(ProfileModel.fromJson(jsondata));
  //     }
  //   }

  //   return promodel;
  // }

  Future<List<ProfileModel>> getalldata() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print('${userid} / ${token}');

    const uri = "https://new-demo.inkcdogs.org/api/user/user_profile";

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    var dataarray = data['data'];

    List<ProfileModel> dataload = [];

    print(data['message']);

    if (data['code'].toString() == "200") {
      for (var jsondata in dataarray) {
        ProfileModel profileModel = ProfileModel(
            firstname: jsondata['first_name'], lastname: jsondata['last_name']);
        dataload.add(profileModel);

        print(token);
        print(userid);
        gender = jsondata['gender'].toString();
        DOB = jsondata['user_birth_date'].toString();

        First.value = TextEditingValue(text: jsondata['first_name']);
        MyController.value = TextEditingValue(text: jsondata['last_name']);
        phonenumber.value =
            TextEditingValue(text: jsondata['user_phone_number']);
        email.value = TextEditingValue(text: jsondata['user_email_id']);
        dateofbirth.value = TextEditingValue(text: jsondata['user_birth_date']);
        if (jsondata['user_address'].toString() == "null") {
          address.value = const TextEditingValue(text: "null");
        } else {
          address.value = TextEditingValue(
              text: jsondata['user_address'] +
                  ", " +
                  jsondata['user_local'] +
                  ", " +
                  jsondata['user_district'] +
                  ", " +
                  jsondata['user_state'] +
                  ", " +
                  jsondata['user_pincode']);
        }
        personalid.value = TextEditingValue(text: jsondata['user_id']);

        image = jsondata['user_profile_image'];
        SharedPreferences UserProfileImage =
            await SharedPreferences.getInstance();
        await UserProfileImage.setString("UserProfileImage", image);
        print(image);
      }
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (_) => const Login()));
    }
    return dataload;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // First.value = TextEditingValue(text: );
    // MyController.value = TextEditingValue(text: "Rajbhar");
    // phonenumber.value = TextEditingValue(text: "9630296544");
    // email.value = TextEditingValue(text: "manjeetrajbhar89@gmail.com");
    // dateofbirth.value = TextEditingValue(text: "25/07/2001");
    // address.value =
    //     TextEditingValue(text: "Suman Colony Mhow Indore Madhay Pradesh");
    // personalid.value = TextEditingValue(text: "24825");

    // fetchjson().then((value) {
    //   setState(() {
    //     profileadd.addAll(value);
    //   });
    // });
    future:
    getalldata();
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Scaffold(
              // body:
              // FutureBuilder<List<ProfileModel>>(
              //   builder: (context, snapshot) {
              //     if (snapshot.data == null)
              //       return const Center(
              //         child: Text("null value print "),
              //       );
              //     else {}
              //     return Center(
              //       child: Text(snapshot.data!.length.toString()),
              //     );
              //   },
              // ),

              body: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "My Profile",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (address.text.toString() == "null")
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 20),
                          height: 100.0.sp,
                          width: 100.0.sp,
                          child: Icon(
                            Icons.person,
                            size: 45.0.sp,
                            color: const ui.Color.fromARGB(255, 141, 35, 35),
                          ),
                        )
                      else
                        Center(
                          child: Stack(
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
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://new-demo.inkcdogs.org/$image"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0.sp,
                                  right: 0.sp,
                                  child: GestureDetector(
                                    onTap: () {
                                      // getImage();
                                      getImagedata();
                                    },
                                    child: Container(
                                      height: 40.sp,
                                      width: 40.sp,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: Colors.black,
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Container(
                                  height: 40.sp,
                                  width: 40.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 148, 145, 145),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ProfileUpdate(
                                                    names:
                                                        First.text.toString(),
                                                    lastnames: MyController.text
                                                        .toString(),
                                                    genders: gender,
                                                    dobs: DOB,
                                                    phones: phonenumber.text,
                                                    emails: email.text,
                                                    addresss: address.text,
                                                  )));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: ElevatedButton(
                                  // height: 40.sp,
                                  // width: 40.sp,
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   border: Border.all(
                                  //     width: 4,
                                  //     color: Theme.of(context)
                                  //         .scaffoldBackgroundColor,
                                  //   ),
                                  //   color: const Color.fromARGB(
                                  //       255, 148, 145, 145),
                                  // ),

                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 223, 71, 45),
                                      textStyle: const TextStyle(
                                          fontSize: 10,
                                          color:
                                              Color.fromARGB(255, 223, 71, 45),
                                          fontWeight: FontWeight.bold)),

                                  onPressed: () async {
                                    SharedPreferences sharedprefrence =
                                        await SharedPreferences.getInstance();
                                    String card_code =
                                        sharedprefrence.getString("card_code")!;

                                    // print(card_code
                                    //     .replaceAll("{", "")
                                    //     .replaceAll("\"", "")
                                    //     .replaceAll("}", "")
                                    //     .replaceAll(",", ":"));

                                    String value = card_code
                                        .replaceAll("{", "")
                                        .replaceAll("\"", "")
                                        .replaceAll("}", "")
                                        .replaceAll(",", ":");

                                    List<String> parts = value.split(':');

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                IdCard(
                                                  firstname:
                                                      First.text.toString(),
                                                  lastname: MyController.text
                                                      .toString(),
                                                  number: phonenumber.text,
                                                  email: email.text,
                                                  Fulladdress: address.text,
                                                  gender: gender.toString(),
                                                  dob: DOB.toString(),
                                                  image: image,
                                                  country: '',
                                                  city: '',
                                                  state: '',
                                                  Countrygetdata: '',
                                                  Stategetdata: '',
                                                  Districtgetdata: '',
                                                  pincode: '',
                                                  countryid: '',
                                                  stateid: '',
                                                  district: '',
                                                  userid: personalid.text,
                                                  card_code: parts,
                                                  card_expiry_date: '',
                                                )));
                                  },
                                  child: Text(
                                    "ID Card",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (BuildContext context) => ProfileUpdate(
                      //                 phone: phonenumber.text,
                      //                 email: email.text,
                      //                 address: address.text,
                      //               )));
                      //     },
                      //     child: Text('Profile')),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  controller: First,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'First Name',
                                    hintText: 'Manjeet',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  controller: MyController,
                                  enabled: false,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Last Name',
                                    hintText: 'Rajbhar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IntlPhoneField(
                                  enabled: false,
                                  controller: phonenumber,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  initialCountryCode: 'IN',
                                  onChanged: (phone) {
                                    print(
                                      phone.completeNumber,
                                    );
                                  },
                                  onCountryChanged: (country) {
                                    print(
                                        'Country changed to: ${country.name}');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  controller: email,
                                  enabled: false,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Email Address',
                                    hintText: 'Rajbhar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  controller: dateofbirth,
                                  enabled: false,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.date_range),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Date of Birth',
                                    hintText: 'Rajbhar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  maxLines: null,
                                  controller: address,
                                  enabled: false,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Address',
                                    hintText: 'Rajbhar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  maxLines: null,
                                  controller: personalid,
                                  enabled: false,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Personal ID',
                                    hintText: 'Rajbhar',
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
