import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
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
                                SharedPreferences Token = await SharedPreferences.getInstance();
                                await Token.setString("Token", "QW7J9TAG"
                                    // data['user_token']
                                    );

                                SharedPreferences Userid = await SharedPreferences.getInstance();
                                await Userid.setString("Userid", "24835"
                                    // userId
                                    );

                                navigatorKey.currentState
                                    ?.pushNamedAndRemoveUntil('/home', (route) => false);
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
