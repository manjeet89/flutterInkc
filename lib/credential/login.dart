import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
import 'package:inkc/credential/signup.dart';
import 'package:inkc/firebase_messagign/fire_base_message.dart';
import 'package:inkc/myhomepage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeLogin(),
    );
  }
}

class HomeLogin extends StatefulWidget {
  const HomeLogin({super.key});

  @override
  State<HomeLogin> createState() => _HomeLogin();
}

class _HomeLogin extends State<HomeLogin> {
  final tenDigitsOnly = RegExp(r'^\d{0,10}$');
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showPassword = true;
  bool passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon:
      //         Icon(Icons.arrow_back, color: Color.fromARGB(255, 243, 242, 242)),
      //     onPressed: () => Navigator.of(context).push(
      //         MaterialPageRoute(builder: (BuildContext context) => MyApp())),
      //   ),
      //   title: Text(
      //     '',
      //     style: TextStyle(
      //         shadows: [
      //           Shadow(
      //             blurRadius: 10.0, // shadow blur
      //             color: Color.fromARGB(255, 223, 71, 45), // shadow color
      //             offset: Offset(2.0, 2.0), // how much shadow will be shown
      //           ),
      //         ],
      //         fontSize: 20.sp,
      //         decorationColor: Colors.red,
      //         color: Color.fromARGB(255, 194, 97, 33),
      //         // color: Colors.black,
      //         fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: WillPopScope(
        onWillPop: () async {
          // Navigator.pop(context);
          Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (_) => const HomePages()));
          return false; // Prevent default behavior
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
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
                    'Login',
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
                      margin: EdgeInsets.only(
                          top: 20.sp, left: 20.sp, right: 20, bottom: 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = ui.Gradient.linear(
                                        const Offset(0, 20),
                                        const Offset(150, 20),
                                        <Color>[
                                          const Color.fromARGB(
                                              255, 235, 15, 15),
                                          const Color.fromARGB(
                                              255, 22, 26, 226),
                                        ],
                                      )),
                              ),
                            ),
                          ),
                          // TextField(
                          //   controller: number,
                          //   textAlign: TextAlign.start,
                          //   keyboardType: TextInputType.number,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     hintText: 'Enter Your Number',
                          //   ),
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.allow(tenDigitsOnly)
                          //   ],
                          // ),

                          IntlPhoneField(
                            enabled: true,
                            keyboardType: TextInputType.number,
                            controller: number,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ${country.name}');
                            },
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10.sp, left: 20.sp, right: 20, bottom: 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Password',
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
                        // TextField(
                        //   controller: password,
                        //   textAlign: TextAlign.start,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     hintText: 'Enter Your Password',
                        //   ),
                        // ),

                        TextField(
                          controller: password,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.sp)),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.green),
                            ),
                            hintText: "Password",
                            labelText: "Password",
                            //helperText: "Password must contain special character",
                            //helperStyle: TextStyle(color: Colors.green),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            alignLabelWithHint: false,
                            // filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20.sp, left: 20.sp, right: 20, bottom: 0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(40), // NEW
                          ),
                          onPressed: () async {
                            String Number = number.text;
                            String Password = password.text;

                            EasyLoading.showToast('Please Wait...');

                            const uri =
                                "https://new-demo.inkcdogs.org/api/login";

                            final responce = await http.post(
                              Uri.parse(uri),
                              body: {
                                "user_phone_number": Number,
                                "user_password": Password
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
                              print(data['data']['user_token']);

                              print("1st");
                              if (data['data']['user_address'].toString() ==
                                  "null") {
                                SharedPreferences fulladdress =
                                    await SharedPreferences.getInstance();
                                await fulladdress.setString(
                                    "fulladdress", "null");
                              } else {
                                SharedPreferences fulladdress =
                                    await SharedPreferences.getInstance();
                                await fulladdress.setString(
                                    "fulladdress",
                                    data['data']['user_address'] +
                                        " " +
                                        data['data']['user_address_2'] +
                                        " " +
                                        data['data']['user_local'] +
                                        " " +
                                        data['data']['user_district'] +
                                        " " +
                                        data['data']['user_state'] +
                                        " " +
                                        data['data']['user_pincode']);
                              }
                              print("2st");

                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              await sharedPreferences.setString(
                                  "First", data['data']['first_name']);

                              SharedPreferences Token =
                                  await SharedPreferences.getInstance();
                              await Token.setString(
                                  "Token", data['user_token']);

                              SharedPreferences Userid =
                                  await SharedPreferences.getInstance();
                              await Userid.setString(
                                  "Userid", data['data']['user_id']);

                              if (data['data']['user_full_name'].toString() ==
                                  "") {
                                SharedPreferences EmpFullName =
                                    await SharedPreferences.getInstance();
                                await EmpFullName.setString(
                                    "EmpFullName", "null");
                              } else {
                                SharedPreferences EmpFullName =
                                    await SharedPreferences.getInstance();
                                await EmpFullName.setString("EmpFullName",
                                    data['data']['user_full_name']);
                              }

                              SharedPreferences EmpTypeId =
                                  await SharedPreferences.getInstance();
                              await EmpTypeId.setString(
                                  "EmpTypeId", data['data']['emp_type_id']);

                              SharedPreferences EmpTypeName =
                                  await SharedPreferences.getInstance();
                              await EmpTypeName.setString(
                                  "EmpTypeName", data['data']['emp_type_name']);

                              SharedPreferences PhoneNumber =
                                  await SharedPreferences.getInstance();
                              await PhoneNumber.setString("phoneNumber",
                                  data['data']['user_phone_number']);

                              SharedPreferences UserVerification =
                                  await SharedPreferences.getInstance();
                              await UserVerification.setString(
                                  "UserVerification",
                                  data['data']['is_verified']);

                              SharedPreferences FontUserid =
                                  await SharedPreferences.getInstance();
                              await FontUserid.setString(
                                  "FontUserid", data['data']['user_id']);

                              if (data['data']['user_address'].toString() ==
                                  "null") {
                              } else {
                                SharedPreferences FontEmpFullName =
                                    await SharedPreferences.getInstance();
                                await FontEmpFullName.setString(
                                    "FontEmpFullName",
                                    data['data']['first_name'] +
                                        " " +
                                        data['data']['last_name']);
                              }

                              SharedPreferences FontEmpTypeId =
                                  await SharedPreferences.getInstance();
                              await FontEmpTypeId.setString(
                                  "FontEmpTypeId", data['data']['emp_type_id']);

                              SharedPreferences FontUserEmailId =
                                  await SharedPreferences.getInstance();
                              await FontUserEmailId.setString("FontUserEmailId",
                                  data['data']['user_email_id']);

                              SharedPreferences FontEmpTypeName =
                                  await SharedPreferences.getInstance();
                              await FontEmpTypeName.setString("FontEmpTypeName",
                                  data['data']['emp_type_name']);

                              SharedPreferences FontPhoneNumber =
                                  await SharedPreferences.getInstance();
                              await FontPhoneNumber.setString("FontPhoneNumber",
                                  data['data']['user_phone_number']);

                              SharedPreferences FontUserVerification =
                                  await SharedPreferences.getInstance();
                              await FontUserVerification.setString(
                                  "FontUserVerification",
                                  data['data']['is_verified']);

                              SharedPreferences FontKennelClubStatus =
                                  await SharedPreferences.getInstance();
                              await FontKennelClubStatus.setString(
                                  "FontKennelClubStatus",
                                  data['data']['kennel_club_status']);

                              SharedPreferences FontMemberStatus =
                                  await SharedPreferences.getInstance();
                              await FontMemberStatus.setString(
                                  "FontMemberStatus",
                                  data['data']['member_status']);

                              if (data['data']['user_profile_image']
                                      .toString() ==
                                  "null") {
                                SharedPreferences UserProfileImage =
                                    await SharedPreferences.getInstance();
                                await UserProfileImage.setString(
                                    "UserProfileImage", "null");
                              } else {
                                SharedPreferences UserProfileImage =
                                    await SharedPreferences.getInstance();
                                await UserProfileImage.setString(
                                    "UserProfileImage",
                                    data['data']['user_profile_image']);
                              }
                              // card code with id card
                              if (data['data']['card_code'].toString() ==
                                  "null") {
                                SharedPreferences card_code =
                                    await SharedPreferences.getInstance();
                                await card_code.setString("card_code", "null");
                              } else {
                                SharedPreferences card_code =
                                    await SharedPreferences.getInstance();
                                await card_code.setString(
                                    "card_code", data['data']['card_code']);
                              }

                              SharedPreferences UserName =
                                  await SharedPreferences.getInstance();
                              await UserName.setString(
                                  "UserName", data['data']['first_name']);

                              SharedPreferences UserEmpId =
                                  await SharedPreferences.getInstance();
                              await UserEmpId.setString(
                                  "UserEmpId", data['data']['emp_type_id']);

                              SharedPreferences LastName =
                                  await SharedPreferences.getInstance();
                              await LastName.setString(
                                  "LastName", data['data']['last_name']);

                              SharedPreferences Firstname =
                                  await SharedPreferences.getInstance();
                              await Firstname.setString(
                                  "Firstname", data['data']['first_name']);

                              // Get.to(MyApp());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MyApp()));

                              WidgetsFlutterBinding.ensureInitialized();
                              await Firebase.initializeApp();
                              await FireBaseApi().initNotification();

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MyApp()));

                              // Navigator.of(context, rootNavigator: true).push(
                              //     MaterialPageRoute(builder: (_) => MyApp()));
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Sorry, something went wrong',
                              );
                              EasyLoading.dismiss();

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('InValide Credentials')));
                            }

                            // final SharedPreferences sharedPreferences =
                            //     await SharedPreferences.getInstance();
                            // sharedPreferences.setString('token', Password);
                            // Get.to(MyApp());

                            // Navigator.of(context, rootNavigator: true)
                            //     .push(MaterialPageRoute(builder: (_) => MyApp()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Row(
                              children: [
                                InkWell(
                                  child: Text(
                                    'If you do not have an account ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (_) => const SignUP()));
                                  },
                                  child: Text(
                                    'Sign up here ',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 223, 18, 18),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  ),
                                ),
                              ],
                            ),
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
