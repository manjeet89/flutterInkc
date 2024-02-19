import 'dart:convert';

import 'package:curved_container/curved_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/model/profilemodel.dart';
import 'package:inkc/verification.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class SignUP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "profile UI",
      home: SignUpHere(),
    );
  }
}

class SignUpHere extends StatefulWidget {
  @override
  _SignUpHereState createState() => _SignUpHereState();
}

class _SignUpHereState extends State<SignUpHere> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  TextEditingController lastname = new TextEditingController();
  TextEditingController First = new TextEditingController();
  TextEditingController phonenumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController dateofbirth = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController personalid = new TextEditingController();
  TextEditingController password = new TextEditingController();

  FocusNode focusNode = FocusNode();

  bool showPassword = true;

  String? gender = "1";

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
            text: date.day.toString() +
                "-" +
                date.month.toString() +
                "-" +
                date.year.toString());
      });
    }
  }

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
          return Scaffold(
            body: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      // child: ClipRRect(
                      //   child: Container(
                      //     color: Colors.black,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(24),
                      //       child: SizedBox.fromSize(
                      //         size: const Size.fromRadius(144),
                      //         child: Image.asset(
                      //           'assets/doggylocker.png',
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // child: CurvedContainer(
                      //   defaultMargin: false,
                      //   containerHeight: 100.sp,
                      //   curvedRadius: 2.sp,
                      //   color: Colors.yellow,
                      // ),

                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 8, 8, 8),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        // color: Colors.black,
                        height: 110.sp,
                        width: 110.sp,
                        child: Image.asset('assets/doggylocker.png'),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: First,
                                enabled: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'First Name',
                                  hintText: '',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                controller: lastname,
                                enabled: true,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Last Name',
                                  hintText: '',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                boxShadow: [],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4.sp),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          'Gender',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
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
                              padding: EdgeInsets.all(10),
                              child: IntlPhoneField(
                                enabled: true,
                                controller: phonenumber,
                                focusNode: focusNode,
                                decoration: InputDecoration(
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
                                  print('Country changed to: ' + country.name);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: email,
                                enabled: true,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Email Address',
                                  hintText: 'example@gmail.com',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 150.sp,
                                    child: TextField(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
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
                                        prefixIcon: Icon(Icons.date_range),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.sp)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.green),
                                        ),
                                        labelText: 'Date of Birth',
                                        hintText: '1-1-2000',
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        selectDatePicker();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: Text(
                                        'Pick date',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: TextField(
                                controller: password,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  hintText: "Password",
                                  labelText: "Password",
                                  helperText:
                                      "Password must contain special character",
                                  helperStyle: TextStyle(color: Colors.green),
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
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 50.sp),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 63, 23, 23),
                                  minimumSize: const Size.fromHeight(40), // NEW
                                ),
                                onPressed: () async {
                                  // print(First.text);
                                  // print(lastname.text);
                                  // print(gender);
                                  // print(phonenumber.text);
                                  // print(email.text);
                                  // print(dateofbirth.text);
                                  // print(password.text);

                                  EasyLoading.showToast('Please Wait...');

                                  final uri =
                                      "https://www.inkc.in/api/login/signup";

                                  final responce = await http.post(
                                    Uri.parse(uri),
                                    body: {
                                      "user_password": password.text,
                                      "first_name": First.text,
                                      "user_phone_number": phonenumber.text,
                                      "last_name": lastname.text,
                                      "user_birth_date": dateofbirth.text,
                                      "gender": gender,
                                      "user_email_id": email.text
                                    },
                                  );
                                  var data = json.decode(responce.body);
                                  print(data);

                                  if (data['code'] == 200) {
                                    print(data['message']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Please verify user')));
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

                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (_) => VerificationOtp(
                                                userid: data['data']['user_id'],
                                                number: data['data']
                                                    ['user_phone_number'])));

                                    // Navigator.of(context, rootNavigator: true).push(
                                    //     MaterialPageRoute(builder: (_) => MyApp()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Something went wrong')));
                                  }
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
