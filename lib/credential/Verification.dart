import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
import 'package:inkc/firebase_messagign/fire_base_message.dart';
import 'package:inkc/main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class HomeVerification extends StatefulWidget {
  HomeVerification({super.key});

  @override
  State<HomeVerification> createState() => _HomeVerification();
}

class _HomeVerification extends State<HomeVerification> {
  final tenDigitsOnly = RegExp(r'^\d{0,10}$');
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String getUserId(dynamic response) {
    if (response["data"] is Map) {
      // First API response
      return response["data"]["user_id"].toString();
    } else {
      // Second API response
      return response["data"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    print(userId);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          // Navigator.of(context, rootNavigator: true)
          //     .push(MaterialPageRoute(builder: (_) => const HomePages()));
          return false; // Prevent default behavior
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 8, 8, 8),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      // color: Colors.black,
                      height: 110.sp,
                      width: 110.sp,
                      child: Image.asset('assets/doggylocker.png'),
                    ),
                  ),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = const Color.fromARGB(255, 22, 22, 22),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20, bottom: 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'OTP',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = ui.Gradient.linear(
                                        const Offset(0, 20),
                                        const Offset(150, 20),
                                        <Color>[
                                          const Color.fromARGB(255, 235, 15, 15),
                                          const Color.fromARGB(255, 22, 26, 226),
                                        ],
                                      )),
                              ),
                            ),
                          ),
                          TextField(
                            enabled: true,
                            keyboardType: TextInputType.number,
                            controller: number,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                                borderSide: const BorderSide(width: 1, color: Colors.green),
                              ),
                              hintText: "OTP ",
                              // labelText: "OTP ",
                              //helperText: "Password must contain special character",
                              //helperStyle: TextStyle(color: Colors.green),

                              // filled: true,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20, bottom: 0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(40), // NEW
                          ),
                          onPressed: () async {
                            if (number.text.toString().isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text('OTP ')));
                            } else {
                              String Number = number.text;

                              EasyLoading.showToast('Please Wait...');

                              const uri = "https://inkc.in/api/login/verification";

                              final responce = await http.post(
                                Uri.parse(uri),
                                body: {
                                  "user_id": userId,
                                  "user_otp": Number,
                                },
                              );
                              var data = json.decode(responce.body);
                              if (data['code'] == 200) {
                                // QuickAlert.show(
                                //   context: context,
                                //   type: QuickAlertType.loading,
                                //   title: 'Loading',
                                // );

                                EasyLoading.dismiss();

                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                print("1st");
                                if (data['data'][0]['user_address'].toString() == "null") {
                                  SharedPreferences fulladdress =
                                      await SharedPreferences.getInstance();
                                  await fulladdress.setString("fulladdress", "null");
                                } else {
                                  SharedPreferences fulladdress =
                                      await SharedPreferences.getInstance();
                                  await fulladdress.setString(
                                      "fulladdress",
                                      data['data'][0]['user_address'] +
                                          " " +
                                          data['data'][0]['user_address_2'] +
                                          " " +
                                          data['data'][0]['user_local'] +
                                          " " +
                                          data['data'][0]['user_district'] +
                                          " " +
                                          data['data'][0]['user_state'] +
                                          " " +
                                          data['data'][0]['user_pincode']);
                                }
                                print("2st");

                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setString(
                                    "First", data['data'][0]['first_name']);
                                print("3st");

                                SharedPreferences Token = await SharedPreferences.getInstance();
                                await Token.setString("Token", data['user_token']);
                                print("4st");

                                SharedPreferences Userid = await SharedPreferences.getInstance();
                                await Userid.setString("Userid", data['data'][0]['user_id']);
                                print("5st");

                                if (data['data'][0]['user_full_name'].toString() == "") {
                                  SharedPreferences EmpFullName =
                                      await SharedPreferences.getInstance();
                                  await EmpFullName.setString("EmpFullName", "null");
                                } else {
                                  SharedPreferences EmpFullName =
                                      await SharedPreferences.getInstance();
                                  await EmpFullName.setString(
                                      "EmpFullName", data['data'][0]['user_full_name']);
                                }
                                print("6st");

                                SharedPreferences EmpTypeId = await SharedPreferences.getInstance();
                                await EmpTypeId.setString(
                                    "EmpTypeId", data['data'][0]['user_employee_type']);
                                print("7st");

                                SharedPreferences EmpTypeName =
                                    await SharedPreferences.getInstance();
                                await EmpTypeName.setString("EmpTypeName", 'User');
                                print("8st");
                                SharedPreferences PhoneNumber =
                                    await SharedPreferences.getInstance();
                                await PhoneNumber.setString(
                                    "phoneNumber", data['data'][0]['user_phone_number']);
                                print("9st");
                                SharedPreferences UserVerification =
                                    await SharedPreferences.getInstance();
                                await UserVerification.setString(
                                    "UserVerification", data['data'][0]['is_verified']);
                                print("10st");
                                SharedPreferences FontUserid =
                                    await SharedPreferences.getInstance();
                                await FontUserid.setString(
                                    "FontUserid", data['data'][0]['user_id']);
                                print("11st");
                                if (data['data'][0]['user_address'].toString() == "null") {
                                } else {
                                  SharedPreferences FontEmpFullName =
                                      await SharedPreferences.getInstance();
                                  await FontEmpFullName.setString(
                                      "FontEmpFullName",
                                      data['data'][0]['first_name'] +
                                          " " +
                                          data['data'][0]['last_name']);
                                }
                                print("12st");
                                SharedPreferences FontEmpTypeId =
                                    await SharedPreferences.getInstance();
                                await FontEmpTypeId.setString(
                                    "FontEmpTypeId", data['data'][0]['user_employee_type']);
                                print("13st");
                                SharedPreferences FontUserEmailId =
                                    await SharedPreferences.getInstance();
                                await FontUserEmailId.setString(
                                    "FontUserEmailId", data['data'][0]['user_email_id']);
                                print("14st");
                                SharedPreferences FontEmpTypeName =
                                    await SharedPreferences.getInstance();
                                await FontEmpTypeName.setString("FontEmpTypeName", "User");
                                print("15st");
                                SharedPreferences FontPhoneNumber =
                                    await SharedPreferences.getInstance();
                                await FontPhoneNumber.setString(
                                    "FontPhoneNumber", data['data'][0]['user_phone_number']);
                                print("16st");
                                SharedPreferences FontUserVerification =
                                    await SharedPreferences.getInstance();
                                await FontUserVerification.setString(
                                    "FontUserVerification", data['data'][0]['is_verified']);
                                print("17st");
                                SharedPreferences FontKennelClubStatus =
                                    await SharedPreferences.getInstance();
                                await FontKennelClubStatus.setString(
                                    "FontKennelClubStatus", data['data'][0]['kennel_club_status']);
                                print("18st");
                                SharedPreferences FontMemberStatus =
                                    await SharedPreferences.getInstance();
                                await FontMemberStatus.setString(
                                    "FontMemberStatus", data['data'][0]['member_status']);
                                print("19st");
                                if (data['data'][0]['user_profile_image'].toString() == "null") {
                                  SharedPreferences UserProfileImage =
                                      await SharedPreferences.getInstance();
                                  await UserProfileImage.setString("UserProfileImage", "null");
                                } else {
                                  SharedPreferences UserProfileImage =
                                      await SharedPreferences.getInstance();
                                  await UserProfileImage.setString(
                                      "UserProfileImage", data['data'][0]['user_profile_image']);
                                }
                                print("20st");
                                // card code with id card
                                if (data['data'][0]['card_code'].toString() == "null") {
                                  SharedPreferences cardCode =
                                      await SharedPreferences.getInstance();
                                  await cardCode.setString("card_code", "null");
                                } else {
                                  SharedPreferences cardCode =
                                      await SharedPreferences.getInstance();
                                  await cardCode.setString(
                                      "card_code", data['data'][0]['card_code']);
                                }
                                print("21st");
                                SharedPreferences UserName = await SharedPreferences.getInstance();
                                await UserName.setString("UserName", data['data'][0]['first_name']);
                                print("22st");
                                SharedPreferences UserEmpId = await SharedPreferences.getInstance();
                                await UserEmpId.setString(
                                    "UserEmpId", data['data'][0]['user_employee_type']);

                                SharedPreferences LastName = await SharedPreferences.getInstance();
                                await LastName.setString("LastName", data['data'][0]['last_name']);

                                SharedPreferences Firstname = await SharedPreferences.getInstance();
                                await Firstname.setString(
                                    "Firstname", data['data'][0]['first_name']);

                                await prefs.setBool('isLoggedIn', true);
                                // Get.to(MyApp());
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MyApp()));

                                WidgetsFlutterBinding.ensureInitialized();
                                await Firebase.initializeApp();
                                await FireBaseApi().initNotification();

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => const MyApp()));
                                navigatorKey.currentState
                                    ?.pushNamedAndRemoveUntil('/home', (route) => false);

                                // Navigator.of(context, rootNavigator: true).push(
                                //     MaterialPageRoute(builder: (_) => MyApp()));

                                // SharedPreferences Token = await SharedPreferences.getInstance();
                                // await Token.setString("Token", "QW7J9TAG"
                                //     // data['user_token']
                                //     );

                                // SharedPreferences Userid = await SharedPreferences.getInstance();
                                // await Userid.setString("Userid", "24835"
                                //     // userId
                                //     );

                                // navigatorKey.currentState
                                //     ?.pushNamedAndRemoveUntil('/home', (route) => false);
                              }
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
