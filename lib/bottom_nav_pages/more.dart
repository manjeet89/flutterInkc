import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/main.dart';
import 'package:inkc/myhomepage.dart';
import 'package:inkc/other/contactus.dart';
import 'package:inkc/other/overview.dart';
import 'package:inkc/other/privacy_policies.dart';
import 'package:inkc/other/refunds.dart';
import 'package:inkc/other/social.dart';
import 'package:inkc/other/terms.dart';
import 'package:inkc/profile_update.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../profile.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: MorePage(),
      );
      // return Container(
      //   margin: EdgeInsets.all(30),
      //   child: Text(
      //     'More',
      //     style: TextStyle(
      //         color: Colors.black, fontSize: 30, ),
      //   ),
      // );
    });
  }
}

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool _isShow = false;
  bool _isShowoff = false;
  @override
  void initState() {
    // TODO: implement initState
    Checklogin();
    getValidationData();

    super.initState();
    // if (_isShow == true) {
    //   _isShow = false;
    //   _isShowoff = true;
    // }
  }

  String? First;
  String? Last;
  String? phone;
  String? UserprofileImage;

  Future getValidationData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    setState(() {
      First = sharedprefrence.getString("First");
      Last = sharedprefrence.getString("LastName");
      phone = sharedprefrence.getString("phoneNumber");
      UserprofileImage = sharedprefrence.getString("UserProfileImage");
    });
    // print(obtained);
  }

  Checklogin() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("Token");
    if (check != null) {
      setState(() {
        _isShow = true;
      });
    } else {
      setState(() {
        _isShowoff = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(UserprofileImage.toString());
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
    // );
    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(
        // title: Title(
        //   color: Colors.black,
        //   child: Text(
        //     'More',
        //     style: TextStyle(
        //       fontSize: 35,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        // actions: [
        //   Padding(padding: EdgeInsets.all(16)),
        //   IconButton(
        //     icon: const Icon(Icons.person),
        //     tooltip: 'Show Snackbar',
        //     onPressed: () {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(content: Text('This is a snackbar')));
        //     },
        //   ),
        // ],
        //   backgroundColor: Colors.white,
        // ),
        body: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50.0, left: 30),
                    child: Text(
                      'More',
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // margin: EdgeInsets.only(top: 30.0),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 20.0),
                    //       child: Text(
                    //         'More',
                    //         style: TextStyle(
                    //             fontSize: 30,
                    //             color: Colors.black,
                    //             ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),

              Visibility(
                visible: _isShow,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (UserprofileImage == "null")
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 20),
                          height: 70.0.sp,
                          width: 70.0.sp,
                          child: Icon(
                            Icons.person,
                            size: 25.0.sp,
                            color: ui.Color.fromARGB(255, 141, 35, 35),
                          ),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(50.sp),
                          //   //set border radius to 50% of square height and width
                          //   image: DecorationImage(
                          //     image: AssetImage("assets/INKCLogo.jpg"),
                          //     fit: BoxFit.cover, //change image fill type
                          //   ),
                          // ),
                        )
                      else
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 20),
                          height: 70.0.sp,
                          width: 70.0.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.sp),
                            //set border radius to 50% of square height and width
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.inkc.in/${UserprofileImage}"),
                              fit: BoxFit.cover, //change image fill type
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SettingsUI()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${First}${" "}${Last} ',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${phone}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0.sp),
                            child: Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.grey, width: 1),
                                //     color: Colors.white,
                                //     borderRadius:
                                //         BorderRadius.circular(50.0)), //<-- SEE HERE
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0.sp),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SettingsUI()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0.sp),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.0.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: _isShowoff,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20),
                      height: 70.0.sp,
                      width: 70.0.sp,
                      child: Icon(
                        Icons.person,
                        size: 25.0.sp,
                        color: ui.Color.fromARGB(255, 141, 35, 35),
                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(50.sp),
                      //   //set border radius to 50% of square height and width
                      //   image: DecorationImage(
                      //     image: AssetImage("assets/INKCLogo.png"),
                      //     fit: BoxFit.cover, //change image fill type
                      //   ),
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(builder: (_) => Login()));
                            },
                            child: new Text(
                              "Hi there!",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  decorationColor: Colors.black,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Text(
                          //   'Hi there!',
                          //   style: TextStyle(
                          //       fontSize: 20.sp,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(builder: (_) => Login()));
                            },
                            child: new Text(
                              "Log In",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Text(
                          //   'Log In',
                          //   style: TextStyle(
                          //       fontSize: 15.sp,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // order and booking

              // Padding(
              //   padding: const EdgeInsets.only(left: 48.0, right: 44, top: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton(
              //         child: Text('Profile Update'),
              //         style: ElevatedButton.styleFrom(
              //           primary: Color.fromARGB(255, 223, 57, 6),
              //         ),
              //         onPressed: () async {
              //           SharedPreferences sharedprefrence =
              //               await SharedPreferences.getInstance();
              //           String Phone_number =
              //               sharedprefrence.getString("phoneNumber")!;
              //           String Font_user_email_id =
              //               sharedprefrence.getString("FontUserEmailId")!;
              //           String fulladdress =
              //               sharedprefrence.getString("fulladdress")!;
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (BuildContext context) => ProfileUpdate(
              //                     address: fulladdress,
              //                     email: Font_user_email_id,
              //                     phone: Phone_number,
              //                   )));
              //         },
              //       ),

              //       ElevatedButton(
              //         child: Text(' View Profile'),
              //         style: ElevatedButton.styleFrom(
              //           primary: const Color.fromARGB(255, 76, 91, 175),
              //         ),
              //         onPressed: () {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (BuildContext context) => SettingsUI()));
              //         },
              //       ),
              //       //     Container(
              //       //       width: 60.sp,
              //       //       height: 80.sp,
              //       //       child: Icon(
              //       //         Icons.online_prediction_rounded,
              //       //         size: 25.0.sp,
              //       //       ),
              //       //     ),
              //       //     InkWell(
              //       //       onTap: () {
              //       //         ScaffoldMessenger.of(context).showSnackBar(
              //       //             const SnackBar(content: Text('This is a snackbar')));
              //       //       },
              //       //       child: Container(
              //       //         child: Column(
              //       //           mainAxisAlignment: MainAxisAlignment.start,
              //       //           crossAxisAlignment: CrossAxisAlignment.start,
              //       //           children: [
              //       //             Padding(padding: EdgeInsets.all(5.sp)),
              //       //             Text(
              //       //               'Order & Bookings',
              //       //               style: TextStyle(
              //       //                 fontSize: 15.sp,
              //       //                 color: Colors.black,
              //       //               ),
              //       //             ),
              //       //             FittedBox(
              //       //               fit: BoxFit.cover,
              //       //               child: Text(
              //       //                 'check the status of your ordera and \nbookings',
              //       //                 style: TextStyle(
              //       //                   fontSize: 12.sp,
              //       //                   color: Colors.black,
              //       //                 ),
              //       //               ),
              //       //             ),
              //       //           ],
              //       //         ),
              //       //       ),
              //       //     )
              //       //   ],
              //       // ),

              //       // // offer and discount
              //       // Row(
              //       //   children: [
              //       //     Container(
              //       //       width: 60.sp,
              //       //       height: 80.sp,
              //       //       child: Icon(
              //       //         Icons.discount,
              //       //         size: 25.0.sp,
              //       //       ),
              //       //     ),
              //       //     InkWell(
              //       //       onTap: () {
              //       //         ScaffoldMessenger.of(context).showSnackBar(
              //       //             const SnackBar(content: Text('This is a snackbar')));
              //       //       },
              //       //       child: Container(
              //       //         child: Column(
              //       //           mainAxisAlignment: MainAxisAlignment.start,
              //       //           crossAxisAlignment: CrossAxisAlignment.start,
              //       //           children: [
              //       //             Padding(padding: EdgeInsets.all(5.sp)),
              //       //             Text(
              //       //               'Offer & Discounts',
              //       //               style: TextStyle(
              //       //                 fontSize: 15.sp,
              //       //                 color: Colors.black,
              //       //               ),
              //       //             ),
              //       //             FittedBox(
              //       //               child: Text(
              //       //                 'Get latest updates on exciting deals \n and offers',
              //       //                 style: TextStyle(
              //       //                   fontSize: 12.sp,
              //       //                   color: Colors.black,
              //       //                 ),
              //       //               ),
              //       //             ),
              //       //           ],
              //       //         ),
              //       //       ),
              //       //     )
              //       //   ],
              //       // ),

              //       // // Help & support
              //       // Row(
              //       //   children: [
              //       //     Container(
              //       //       width: 60.sp,
              //       //       height: 80.sp,
              //       //       child: Icon(
              //       //         Icons.add_circle_outline_outlined,
              //       //         size: 25.sp,
              //       //       ),
              //       //     ),
              //       //     InkWell(
              //       //       onTap: () {
              //       //         ScaffoldMessenger.of(context).showSnackBar(
              //       //             const SnackBar(content: Text('This is a snackbar')));
              //       //       },
              //       //       child: Container(
              //       //         child: Column(
              //       //           mainAxisAlignment: MainAxisAlignment.start,
              //       //           crossAxisAlignment: CrossAxisAlignment.start,
              //       //           children: [
              //       //             Padding(padding: EdgeInsets.all(5.sp)),
              //       //             Text(
              //       //               'Help & Support',
              //       //               style: TextStyle(
              //       //                 fontSize: 15.sp,
              //       //                 color: Colors.black,
              //       //               ),
              //       //             ),
              //       //             Text(
              //       //               'Contact us for any queries ,lost',
              //       //               style: TextStyle(
              //       //                 fontSize: 12.sp,
              //       //                 color: Colors.black,
              //       //               ),
              //       //             ),
              //       //           ],
              //       //         ),
              //       //       ),
              //       //     )
              //     ],
              //   ),
              // ),

              Divider(),

              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30.sp),
                    width: 150.sp,
                    height: 30.sp,
                    child: Text(
                      'Browser Links',
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: const Color.fromARGB(255, 139, 3, 3),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),

              // About
              Row(
                children: [
                  Container(
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.admin_panel_settings_sharp),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => OverView()));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            top: 0.sp,
                            right: 5,
                            left: 5,
                          )),
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Digital Presence
              Row(
                children: [
                  Container(
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.perm_media_rounded),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => SocialMedia()));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            top: 0.sp,
                            right: 5,
                            left: 5,
                          )),
                          Text(
                            'Digital Presence',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Contact
              Row(
                children: [
                  Container(
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.admin_panel_settings_sharp),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => ContactUS()));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            top: 0.sp,
                            right: 5,
                            left: 5,
                          )),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Privacy Policy
              Row(
                children: [
                  Container(
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.admin_panel_settings_sharp),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (_) => PrivacyAndPolicies()));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            top: 0.sp,
                            right: 5,
                            left: 5,
                          )),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Terms and conditions
              Row(
                children: [
                  Container(
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.terminal_sharp),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => Terms()));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 0.sp, right: 5, left: 5, bottom: 5)),
                          Text(
                            'Terms and Conditions',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Refund
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.cancel_presentation_outlined),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => Refunds()));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            top: 0.sp,
                            right: 5,
                            left: 5,
                          )),
                          Text(
                            'Refunds and Cancellation',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //Share
              Row(
                children: [
                  Container(
                    width: 60.sp,
                    height: 40.sp,
                    child: Icon(Icons.ios_share),
                  ),
                  InkWell(
                    onTap: () {
                      Share.share(
                        'https://play.google.com/store/apps/details?id=in.inkc.doggylocker',
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('This is a snackbar')));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 0.sp, right: 5, left: 5, bottom: 5)),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 1, 6, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              Visibility(
                visible: _isShow,
                child: Row(
                  children: [
                    Container(
                      width: 60.sp,
                      height: 60.sp,
                      child: Icon(Icons.logout),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();

                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(builder: (_) => MyApp()));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0.sp, right: 5, left: 5, bottom: 5)),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Color.fromARGB(255, 1, 6, 83),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
