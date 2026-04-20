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

class Newlogin extends StatelessWidget {
  const Newlogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeNewlogin(),
    );
  }
}

class HomeNewlogin extends StatefulWidget {
  const HomeNewlogin({super.key});

  @override
  State<HomeNewlogin> createState() => _HomeNewlogin();
}

class _HomeNewlogin extends State<HomeNewlogin> {
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
                    'Login/Signup',
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
                                'Phone Number',
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please enter number ')));
                            } else {
                              String Number = number.text;

                              EasyLoading.showToast('Please Wait...');

                              const uri = "https://inkc.in/api/login/new_login";

                              final responce = await http.post(
                                Uri.parse(uri),
                                body: {"user_phone_number": Number},
                              );
                              var data = json.decode(responce.body);
                              if (data['code'] == 200) {
                                String userId = getUserId(data);
                                navigatorKey.currentState?.pushNamed(
                                  '/HomeVerification',
                                  arguments: userId,
                                );

                                print("USER ID: $userId");
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
