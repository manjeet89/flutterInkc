import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:inkc/Updated_pages_dogs_registered/pedigree_dog_registration_registration_with_other_club.dart';
import 'package:inkc/Updated_pages_dogs_registered/single_dog_regisration_either_paraents_knows.dart';
import 'package:inkc/Updated_pages_dogs_registered/unknown_dog_registration_more_than_six_month.dart';
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

class SingleDogRegistrationProcess extends StatefulWidget {
  const SingleDogRegistrationProcess({super.key});

  @override
  State<SingleDogRegistrationProcess> createState() =>
      _SingleDogRegistrationProcessState();
}

class _SingleDogRegistrationProcessState
    extends State<SingleDogRegistrationProcess> {
  bool parentregistrationhide = false;
  bool sixmonthold = false;
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
              'Single Dog Registration Process',
              style: TextStyle(
                  fontSize: 12.sp,
                  decorationColor: Colors.red,
                  color: const Color.fromARGB(255, 22, 22, 21),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Please select ",
                            style: TextStyle(shadows: const [
                              Shadow(
                                color: Color.fromARGB(
                                    255, 85, 70, 218), // shadow color
                              ),
                            ], fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                          Text(
                            "Registration Process",
                            style: TextStyle(shadows: const [
                              Shadow(
                                color: ui.Color.fromARGB(
                                    255, 21, 20, 22), // shadow color
                              ),
                            ], fontWeight: FontWeight.w400, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox.fromSize(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Is your dog registered with any other club?",
                          style: TextStyle(shadows: const [
                            Shadow(
                              color: Color.fromARGB(
                                  255, 85, 70, 218), // shadow color
                            ),
                          ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 100.sp,
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
                                    // SharedPreferences sharedprefrence =
                                    //     await SharedPreferences.getInstance();
                                    // String? check =
                                    //     sharedprefrence.getString("Token");
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext context) =>
                                    //             const MyDogInfo()));
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 12),
                                    height: 50.0.sp,
                                    width: 80.0.sp,
                                    child: Image.asset('assets/right.png'),
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
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 10),
                                  child: Text(
                                    'YES',
                                    style: TextStyle(
                                        shadows: const [
                                          Shadow(
                                            // blurRadius: 5.0, // shadow blur
                                            color: Color.fromARGB(255, 85, 70,
                                                218), // shadow color
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
                            height: 100.sp,
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
                                    setState(() {
                                      parentregistrationhide = true;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 12),
                                    height: 50.sp,
                                    width: 70.0.sp,
                                    child: Image.asset('assets/wrong.png'),
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
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 10),
                                  child: Text(
                                    'NO',
                                    style: TextStyle(
                                        shadows: const [
                                          Shadow(
                                            // blurRadius: 5.0, // shadow blur
                                            color: ui.Color.fromARGB(
                                                255, 3, 2, 5), // shadow color
                                            // offset: Offset(2.0,
                                            //     2.0), // how much shadow will be shown
                                          ),
                                        ],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: parentregistrationhide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Is either parent registered?",
                            style: TextStyle(shadows: const [
                              Shadow(
                                color: Color.fromARGB(
                                    255, 85, 70, 218), // shadow color
                              ),
                            ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 100.sp,
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
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const SingleDogRegisrationEitherParaentsKnows()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 50.0.sp,
                                      width: 80.0.sp,
                                      child: Image.asset('assets/right.png'),
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
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 10),
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color: Color.fromARGB(255, 85, 70,
                                                  218), // shadow color
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
                              height: 100.sp,
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
                                      setState(() {
                                        sixmonthold = true;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 50.sp,
                                      width: 70.0.sp,
                                      child: Image.asset('assets/wrong.png'),
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
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 10),
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color: ui.Color.fromARGB(
                                                  255, 3, 2, 5), // shadow color
                                              // offset: Offset(2.0,
                                              //     2.0), // how much shadow will be shown
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: sixmonthold,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Is your dog more than 6 months old?",
                            style: TextStyle(shadows: const [
                              Shadow(
                                color: Color.fromARGB(
                                    255, 85, 70, 218), // shadow color
                              ),
                            ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 100.sp,
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
                                      // SharedPreferences sharedprefrence =
                                      //     await SharedPreferences.getInstance();
                                      // String? check =
                                      //     sharedprefrence.getString("Token");
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const UnknownDogRegistrationMoreThanSixMonth()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 50.0.sp,
                                      width: 80.0.sp,
                                      child: Image.asset('assets/right.png'),
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
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 10),
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color: Color.fromARGB(255, 85, 70,
                                                  218), // shadow color
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
                              height: 100.sp,
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please initiate the registration process when your dog is more than 6 months old.')));
                                      // SharedPreferences sharedprefrence =
                                      //     await SharedPreferences.getInstance();
                                      // String? check =
                                      //     sharedprefrence.getString("Token");
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) =>
                                      //             AddDogInfo()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 50.sp,
                                      width: 70.0.sp,
                                      child: Image.asset('assets/wrong.png'),
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
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 10),
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              // blurRadius: 5.0, // shadow blur
                                              color: ui.Color.fromARGB(
                                                  255, 3, 2, 5), // shadow color
                                              // offset: Offset(2.0,
                                              //     2.0), // how much shadow will be shown
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
