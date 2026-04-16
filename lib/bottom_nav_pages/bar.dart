import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:inkc/KennelClub/kennelclubname.dart';
import 'package:inkc/Updated_pages_dogs_registered/single_dog_registration_process.dart';
import 'package:inkc/Updated_pages_litter_registration/litter_registration_home_page.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/events/events.dart';
import 'package:inkc/inkcstore.dart';
import 'package:inkc/main.dart';
import 'package:inkc/mydoginfo.dart';
// import 'package:quantupi/quantupi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
// import 'package:upi_india/upi_india.dart';
import 'dart:async';

class Barpage extends StatelessWidget {
  const Barpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Barpagewidegt(),
        );
      },
    );
  }
}

class Barpagewidegt extends StatefulWidget {
  const Barpagewidegt({super.key});

  @override
  State<Barpagewidegt> createState() => _BarpagewidegtState();
}

class _BarpagewidegtState extends State<Barpagewidegt> {
  bool addresscheck = false;
  bool _loginCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (addresscheck == false) checkLogin();
    LoginCheck();
  }

  Future<void> LoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      setState(() {
        _loginCheck = true;
      });
    }
  }

  checkLogin() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("fulladdress");
    print(check);

    if (check != "null") {
      setState(() {
        addresscheck = true;
        print(check);
      });
    } else {
      setState(() {
        addresscheck = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Our Services',
              style: TextStyle(
                  fontSize: 20.sp,
                  decorationColor: Colors.red,
                  color: const Color.fromARGB(255, 22, 22, 21),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: _loginCheck
              ? Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => const Login()));
                      // navigatorKey.currentState?.pushNamed('/MyDogInfo');
                    },
                    child: const Text("Go to Login", style: TextStyle(color: Colors.white)),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 5.sp),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 150.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(20),
                                // color: ui.Color.fromARGB(136, 172, 220, 255),
                              ),
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      addresscheck == true
                                          ? navigatorKey.currentState?.pushNamed('/MyDogInfo')
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (BuildContext context) => const MyDogInfo()))
                                          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please update your profile - First Name, Last Name and Full Address')));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 100.0.sp,
                                      width: 105.0.sp,
                                      child: Image.asset('assets/mydogs.png'),
                                      //decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(20.sp),
                                      //color: ui.Color.fromARGB(136, 172, 220, 255),

                                      //set border radius to 50% of square height and width
                                      // image: DecorationImage(
                                      //   image: NetworkImage(
                                      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2FihNWtx6Ymf7RSAX_mD1nzIzib37pSKYcw&usqp=CAU"),
                                      //   fit: BoxFit.fill, //change image fill type
                                      // ),
                                      //  ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                                    child: Text(
                                      'My Dogs',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color:
                                                  Color.fromARGB(255, 85, 70, 218), // shadow color
                                              // offset: Offset(2.0,
                                              //     2.0), // how much shadow will be shown
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          // foreground: Paint()
                                          //   ..shader = ui.Gradient.linear(
                                          //     const Offset(0, 20),
                                          //     const Offset(150, 20),
                                          //     <Color>[
                                          //       Color.fromARGB(255, 235, 15, 15),
                                          //       Color.fromARGB(255, 22, 26, 226),
                                          //     ],
                                          //   ),
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  // Text(
                                  //   "Show All Dogs",
                                  //   style: TextStyle(color: Colors.black),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              height: 150.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      addresscheck == true
                                          ? navigatorKey.currentState?.pushNamed(
                                              '/SingleDogRegistrationProcess',
                                              arguments: {
                                                  'participate_event_id': '',
                                                  'is_participate_with_event': '',
                                                  'register_with_event': '',
                                                  'eventname': '',
                                                  'eventtype': '',
                                                  'eventstal': '',
                                                  'pariticaipate_for_event': '0',
                                                  'register_for_event': '0',
                                                })
                                                
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //         builder: (BuildContext context) =>
                                          //             SingleDogRegistrationProcess(
                                          //               participate_event_id: '',
                                          //               is_participate_with_event: '',
                                          //               register_with_event: '',
                                          //               eventname: '',
                                          //               eventtype: '',
                                          //               eventstal: '',
                                          //               pariticaipate_for_event: '0',
                                          //               register_for_event: '0',
                                          //             )))
                                          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please update your profile - First Name, Last Name and Full Address')));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         AddDogInfo()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 100.0.sp,
                                      width: 105.0.sp,
                                      child: Image.asset('assets/adddogs.png'),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(15.sp),

                                      //   //set border radius to 50% of square height and width
                                      //   image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQytMzUqacbpPtcpXLSMunUbVk3WHWwHmTEl5sk2hMjLamiws8FBrKgcX3_COxEUU9qwxA&usqp=CAU"),
                                      //     fit: BoxFit.fill, //change image fill type
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                                    child: Text(
                                      'Add Dogs',
                                      style: TextStyle(shadows: const [
                                        Shadow(
                                          // blurRadius: 5.0, // shadow blur
                                          color: ui.Color.fromARGB(255, 3, 2, 5), // shadow color
                                          // offset: Offset(2.0,
                                          //     2.0), // how much shadow will be shown
                                        ),
                                      ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 170.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // SharedPreferences sharedprefrence =
                                      //     await SharedPreferences.getInstance();
                                      // String? check =
                                      //     sharedprefrence.getString("Token");

                                      addresscheck == true
                                          ? navigatorKey.currentState?.pushNamed('/litterRegis')
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (BuildContext context) =>
                                          //         const LitterRegistrationHomePage()))

                                          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please update your profile - First Name, Last Name and Full Address')));

                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         const LitterRegistrationHomePage()));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         const KennelNumber()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 100.0.sp,
                                      width: 105.0.sp,
                                      child: Image.asset('assets/litterregistration.png'),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(15.sp),

                                      //   //set border radius to 50% of square height and width
                                      //   image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWtDCjZPdjxQFPy2fbtFWeOy_NhhFL_abZAmOaJUpZbZF_1_QTewBvSEWl_2lyiRFqBSM&usqp=CAU"),
                                      //     fit: BoxFit.fill, //change image fill type
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 5),
                                    child: Text(
                                      'Litter Registration',
                                      style: TextStyle(shadows: const [
                                        Shadow(
                                          // blurRadius: 5.0, // shadow blur
                                          color: Color.fromARGB(255, 85, 70, 218), // shadow color
                                          // offset: Offset(2.0,
                                          //     2.0), // how much shadow will be shown
                                        ),
                                      ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 170.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // SharedPreferences sharedprefrence =
                                      //     await SharedPreferences.getInstance();
                                      // String? check = sharedprefrence.getString("Token");
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) => const KennelClubName()));

                                      addresscheck == true
                                          ? navigatorKey.currentState?.pushNamed('/KennelClubName')
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (BuildContext context) => const KennelClubName()))
                                          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please update your profile - First Name, Last Name and Full Address')));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 100.0.sp,
                                      width: 105.0.sp,
                                      child: Image.asset("assets/kennelnameregistration.png"),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(15.sp),

                                      //   //set border radius to 50% of square height and width
                                      //   image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROTaejmQIPYD0y3QTuGvruNZrJvj0R2tk6rw&usqp=CAU"),
                                      //     fit: BoxFit.fill, //change image fill type
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                                    child: Text(
                                      'Kennel Name\n Registration',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color:
                                                  ui.Color.fromARGB(255, 2, 1, 15), // shadow color
                                              // offset: Offset(2.0,
                                              //     2.0), // how much shadow will be shown
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          // foreground: Paint()
                                          //   ..shader = ui.Gradient.linear(
                                          //     const Offset(0, 20),
                                          //     const Offset(150, 20),
                                          //     <Color>[
                                          //       Color.fromARGB(255, 235, 15, 15),
                                          //       Color.fromARGB(255, 22, 26, 226),
                                          //     ],
                                          //   ),
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  // Text(
                                  //   "Show All Dogs",
                                  //   style: TextStyle(color: Colors.black),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 160.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed('/INKCStore');
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) => const INKCStore()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 100.0.sp,
                                      width: 105.0.sp,
                                      child: Image.asset("assets/inkcstore.png"),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(15.sp),

                                      //   //set border radius to 50% of square height and width
                                      //   image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDjYq9BVfv-KOMjn7620qMLjlqNhnUxz2RTA&usqp=CAU"),
                                      //     fit: BoxFit.fill, //change image fill type
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                                    child: Text(
                                      'INKC Store',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color:
                                                  ui.Color.fromARGB(255, 2, 1, 10), // shadow color
                                              // offset: Offset(2.0,
                                              //     2.0), // how much shadow will be shown
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          // foreground: Paint()
                                          //   ..shader = ui.Gradient.linear(
                                          //     const Offset(0, 20),
                                          //     const Offset(150, 20),
                                          //     <Color>[
                                          //       Color.fromARGB(255, 235, 15, 15),
                                          //       Color.fromARGB(255, 22, 26, 226),
                                          //     ],
                                          //   ),
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  // Text(
                                  //   "Show All Dogs",
                                  //   style: TextStyle(color: Colors.black),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              height: 160.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed('/Events');

                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) => const Events()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 100.0.sp,
                                      width: 105.0.sp,
                                      child: Image.asset("assets/events.png"),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(15.sp),

                                      //   //set border radius to 50% of square height and width
                                      //   image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPCGEQZMM6D-fzxpK_MsKCBNnXQf5V59RcFQ&usqp=CAU"),
                                      //     fit: BoxFit.fill, //change image fill type
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                                    child: Text(
                                      'Events',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color:
                                                  ui.Color.fromARGB(255, 7, 7, 14), // shadow color
                                              // offset: Offset(2.0,
                                              //     2.0), // how much shadow will be shown
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          // foreground: Paint()
                                          //   ..shader = ui.Gradient.linear(
                                          //     const Offset(0, 20),
                                          //     const Offset(150, 20),
                                          //     <Color>[
                                          //       Color.fromARGB(255, 235, 15, 15),
                                          //       Color.fromARGB(255, 22, 26, 226),
                                          //     ],
                                          //   ),
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  // Text(
                                  //   "Show All Dogs",
                                  //   style: TextStyle(color: Colors.black),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
