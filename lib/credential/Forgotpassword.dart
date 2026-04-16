import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
import 'package:inkc/credential/signup.dart';
import 'package:inkc/verification.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ForgotPasswordChange(),
    );
  }
}

class ForgotPasswordChange extends StatefulWidget {
  const ForgotPasswordChange({super.key});

  @override
  State<ForgotPasswordChange> createState() => _ForgotPasswordChange();
}

class _ForgotPasswordChange extends State<ForgotPasswordChange> {
  Future<void> _requestSMSPermission() async {
    await Permission.sms.request();
  }

  final tenDigitsOnly = RegExp(r'^\d{0,10}$');
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
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
                    'Forgot Password',
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
                    child: TextField(
                      controller: password,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                          borderSide: const BorderSide(width: 1, color: Colors.green),
                        ),
                        hintText: "new password",
                        labelText: "New Password",
                        //helperText: "Password must contain special character",
                        //helperStyle: TextStyle(color: Colors.green),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20, bottom: 0),
                    child: TextField(
                      controller: cpassword,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                          borderSide: const BorderSide(width: 1, color: Colors.green),
                        ),
                        hintText: "confirm password",
                        labelText: "Confirm Password",
                        //helperText: "Password must contain special character",
                        //helperStyle: TextStyle(color: Colors.green),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
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
                  ),
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
                            } else if (password.text.toString().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please enter password ')));
                            } else if (cpassword.text.toString().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please enter confirm password ')));
                            } else {
                              // _requestSMSPermission();
                              // Navigator.of(context, rootNavigator: true).push(
                              //     MaterialPageRoute(
                              //         builder: (_) => VerificationOtp(
                              //             userid: " data['data']['user_id']",
                              //             number:
                              //                 "data['data']['user_phone_number']")));
                              // print(First.text);
                              // print(lastname.text);
                              // print(gender);
                              // print(phonenumber.text);
                              // print(email.text);
                              // print(dateofbirth.text);
                              // print(password.text);

                              EasyLoading.showToast('Please Wait...');

                              const uri = "https://new-demo.inkcdogs.org/api/login/forgotpassword";

                              final responce = await http.post(
                                Uri.parse(uri),
                                body: {
                                  "user_phone_number": number.text.toString(),
                                  "user_password": password.text.toString(),
                                  "confirm_password": cpassword.text.toString(),
                                },
                              );
                              var data = json.decode(responce.body);
                              print(data);

                              if (data['code'] == 200) {
                                print(data['message']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please verify user')));
                                // print(data['data']['user_id']);

                                EasyLoading.dismiss();

                                // Get.to(MyApp());
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => VerificationOtp(
                                //               data['data']['user_id'],
                                //               data['data']
                                //                   ['user_phone_number:'],
                                //             )));

                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                    builder: (_) => VerificationOtp(
                                        userid: data['data']['user_id'],
                                        number: data['data']['user_phone_number'])));

                                // Navigator.of(context, rootNavigator: true).push(
                                //     MaterialPageRoute(builder: (_) => MyApp()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text(
                                        'Please check number is currect.\n password or confrim password same ')));
                              }
                            }
                          },
                          child: const Text(
                            'Submit',
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
