import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:inkc/Updated_pages_litter_registration/INKC_registered/inkc_registered_forrm.dart';
import 'package:inkc/Updated_pages_litter_registration/INKC_registered/other_club_registration_from.dart';
import 'package:inkc/Updated_pages_litter_registration/INKC_registered/unknow_registration_from.dart';
import 'package:inkc/Updated_pages_litter_registration/Other_club_registration/inkc_registered_from.dart';
import 'package:inkc/Updated_pages_litter_registration/Other_club_registration/other_club_registered_from.dart';
import 'package:inkc/Updated_pages_litter_registration/Other_club_registration/unknown_form.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';

// class Barpage extends StatelessWidget {
//   const Barpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return const MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: Barpagewidegt(),
//         );
//       },
//     );
//   }
// }

class LitterRegistrationHomePage extends StatefulWidget {
  const LitterRegistrationHomePage({super.key});

  @override
  State<LitterRegistrationHomePage> createState() =>
      _LitterRegistrationHomePageState();
}

class _LitterRegistrationHomePageState
    extends State<LitterRegistrationHomePage> {
  bool parentregistrationhide = false;
  bool sixmonthold = false;

  String? gender;
  String? inkcregistraionradio;
  String? otherclubregistrationradio;

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
              'Litter Registration Process',
              style: TextStyle(
                  fontSize: 11.sp,
                  decorationColor: Colors.red,
                  color: const Color.fromARGB(255, 22, 22, 21),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Please select Registration Process",
                      style: TextStyle(shadows: const [
                        Shadow(
                          // blurRadius: 5.0, // shadow blur
                          color:
                              Color.fromARGB(255, 85, 70, 218), // shadow color
                          // offset: Offset(2.0,
                          //     2.0), // how much shadow will be shown
                        ),
                      ], fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Status of Dam Registration:",
                      style: TextStyle(shadows: const [
                        Shadow(
                          // blurRadius: 5.0, // shadow blur
                          color:
                              Color.fromARGB(255, 85, 70, 218), // shadow color
                          // offset: Offset(2.0,
                          //     2.0), // how much shadow will be shown
                        ),
                      ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                  ),
                  Card(
                    color: const ui.Color.fromARGB(255, 226, 69, 69),
                    elevation: 5,
                    child: Container(
                      color: const ui.Color.fromARGB(255, 226, 69, 69),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.white,
                                    hoverColor: Colors.white,
                                    value: "1",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  Text(
                                    'INKC Registered',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                  Card(
                    color: const ui.Color.fromARGB(255, 39, 112, 223),
                    elevation: 5,
                    child: Container(
                      color: const ui.Color.fromARGB(255, 39, 112, 223),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.white,
                                    hoverColor: Colors.white,
                                    value: "2",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  Text(
                                    'Other Club Registered',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: "3",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please register the Dam before proceeding further')));
                                      });
                                    },
                                  ),
                                  Text(
                                    'Unknown',
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
                  const Divider(),
                  if (gender == "1")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Status of Sire Registration:",
                            style: TextStyle(shadows: const [
                              Shadow(
                                // blurRadius: 5.0, // shadow blur
                                color: Color.fromARGB(
                                    255, 85, 70, 218), // shadow color
                                // offset: Offset(2.0,
                                //     2.0), // how much shadow will be shown
                              ),
                            ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                        ),
                        Card(
                          color: const ui.Color.fromARGB(255, 226, 69, 69),
                          elevation: 5,
                          child: Container(
                            color: const ui.Color.fromARGB(255, 226, 69, 69),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: "1",
                                          groupValue: inkcregistraionradio,
                                          activeColor: Colors.white,
                                          hoverColor: Colors.white,
                                          onChanged: (value) {
                                            setState(() {
                                              inkcregistraionradio =
                                                  value.toString();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const InkcRegisteredForrm()));
                                            });
                                          },
                                        ),
                                        Text(
                                          'INKC Registered',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
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
                        Card(
                          color: const ui.Color.fromARGB(255, 226, 69, 69),
                          elevation: 5,
                          child: Container(
                            color: const ui.Color.fromARGB(255, 226, 69, 69),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: "2",
                                          activeColor: Colors.white,
                                          hoverColor: Colors.white,
                                          groupValue: inkcregistraionradio,
                                          onChanged: (value) {
                                            setState(() {
                                              inkcregistraionradio =
                                                  value.toString();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const OtherClubRegistrationFrom()));
                                            });
                                          },
                                        ),
                                        Text(
                                          'Other Club Registered',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
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
                        Card(
                          color: const ui.Color.fromARGB(255, 226, 69, 69),
                          elevation: 5,
                          child: Container(
                            color: const ui.Color.fromARGB(255, 226, 69, 69),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: "3",
                                          activeColor: Colors.white,
                                          hoverColor: Colors.white,
                                          groupValue: inkcregistraionradio,
                                          onChanged: (value) {
                                            setState(() {
                                              inkcregistraionradio =
                                                  value.toString();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const UnknowRegistrationFrom()));
                                            });
                                          },
                                        ),
                                        Text(
                                          'Unknown',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
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
                      ],
                    ),
                  if (gender == "2")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Status of Sire Registration:",
                            style: TextStyle(shadows: const [
                              Shadow(
                                // blurRadius: 5.0, // shadow blur
                                color: Color.fromARGB(
                                    255, 85, 70, 218), // shadow color
                                // offset: Offset(2.0,
                                //     2.0), // how much shadow will be shown
                              ),
                            ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                        ),
                        Card(
                          color: const ui.Color.fromARGB(255, 39, 112, 223),
                          elevation: 5,
                          child: Container(
                            color: const ui.Color.fromARGB(255, 39, 112, 223),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          activeColor: Colors.white,
                                          hoverColor: Colors.white,
                                          value: "4",
                                          groupValue:
                                              otherclubregistrationradio,
                                          onChanged: (value) {
                                            setState(() {
                                              otherclubregistrationradio =
                                                  value.toString();

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const InkcRegisteredFromOtherclub()));
                                            });
                                          },
                                        ),
                                        Text(
                                          'INKC Registered',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
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
                        Card(
                          color: const ui.Color.fromARGB(255, 39, 112, 223),
                          elevation: 5,
                          child: Container(
                            color: const ui.Color.fromARGB(255, 39, 112, 223),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          activeColor: Colors.white,
                                          hoverColor: Colors.white,
                                          value: "5",
                                          groupValue:
                                              otherclubregistrationradio,
                                          onChanged: (value) {
                                            setState(() {
                                              otherclubregistrationradio =
                                                  value.toString();

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const OtherClubRegisteredFromOtherClub()));
                                            });
                                          },
                                        ),
                                        Text(
                                          'Other Club Registered',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
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
                        Card(
                          color: const ui.Color.fromARGB(255, 39, 112, 223),
                          elevation: 5,
                          child: Container(
                            color: const ui.Color.fromARGB(255, 39, 112, 223),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          activeColor: Colors.white,
                                          hoverColor: Colors.white,
                                          value: "6",
                                          groupValue:
                                              otherclubregistrationradio,
                                          onChanged: (value) {
                                            setState(() {
                                              otherclubregistrationradio =
                                                  value.toString();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const UnknownFormOtherClub()));
                                            });
                                          },
                                        ),
                                        Text(
                                          'Unknown',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
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
