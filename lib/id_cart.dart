// import 'package:aff/advertiserpage.dart';
// import 'package:flutter/material.dart';

// import 'package:full_screen_image/full_screen_image.dart';

// class IdCard extends StatefulWidget {
//   String firstname,
//       lastname,
//       email,
//       number,
//       gender,
//       dob,
//       country,
//       state,
//       city,
//       Fulladdress,
//       Countrygetdata,
//       Stategetdata,
//       Districtgetdata,
//       pincode,
//       countryid,
//       stateid,
//       district,
//       userid;
//   IdCard({
//     super.key,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.number,
//     required this.gender,
//     required this.dob,
//     required this.country,
//     required this.state,
//     required this.city,
//     required this.Fulladdress,
//     required this.Countrygetdata,
//     required this.Stategetdata,
//     required this.Districtgetdata,
//     required this.pincode,
//     required this.countryid,
//     required this.stateid,
//     required this.district,
//     required this.userid,
//   });

//   @override
//   State<IdCard> createState() => _IdCardState();
// }

// class _IdCardState extends State<IdCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: const Color(0xEBA020F0),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//               icon: const Icon(Icons.arrow_back,
//                   color: Color.fromARGB(255, 255, 255, 255)),
//               onPressed: () => Navigator.pop(context)),
//           title: Text(
//             widget.firstname + " " + "ID Card",
//             style: const TextStyle(
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18),
//           )),
//       body: Container(
//         color: Colors.black12,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/adv.png'),
//                 radius: 50,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               widget.firstname + " " + widget.lastname,
//               style: TextStyle(
//                   fontSize: 18,
//                   letterSpacing: 2.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: FittedBox(
//             //     fit: BoxFit.fill,
//             //     child: FullScreenWidget(
//             //       disposeLevel: DisposeLevel.High,
//             //       child: Container(
//             //         decoration: const BoxDecoration(
//             //           // border: Border.all(
//             //           //   color: Color.fromARGB(255, 24, 22, 26),
//             //           // ),
//             //           borderRadius: BorderRadius.all(Radius.circular(10)),
//             //           image: DecorationImage(
//             //               image: AssetImage('assets/images/qrcode.png')),
//             //         ),
//             //         margin: const EdgeInsets.all(12),
//             //         width: 150,
//             //         height: 70,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             FullScreenWidget(
//               disposeLevel: DisposeLevel.High,
//               child: Container(
//                 decoration: BoxDecoration(
//                   // border: Border.all(
//                   //   color: const Color.fromARGB(255, 24, 22, 26),
//                   // ),
//                   // borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   image: DecorationImage(
//                       image: AssetImage(
//                     "assets/images/qrcode.png",
//                   )),
//                 ),
//                 margin: const EdgeInsets.all(12),
//                 height: 50,
//                 width: 50,
//               ),
//             ),
//             Text(
//               "click to QR code to expand",
//               style: TextStyle(fontSize: 8),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "Personal ID :",
//                     style: TextStyle(
//                         color: Colors.black54, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: 50,
//                   ),
//                   Text(
//                     widget.userid,
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "E-mail ID :",
//                     style: TextStyle(
//                         color: Colors.black54, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: 65,
//                   ),
//                   Text(
//                     widget.email,
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "Mobile Number :",
//                     style: TextStyle(
//                         color: Colors.black54, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: 25,
//                   ),
//                   Text(
//                     widget.number,
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     cellWidget("I", "89"),
//                     cellWidget("N", "63"),
//                     cellWidget("K", "79"),
//                     cellWidget("C", "99"),
//                     cellWidget("D", "41"),
//                     cellWidget("O", "58"),
//                     cellWidget("G", "39"),
//                     cellWidget("S", "58"),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget cellWidget(String letter, String number) {
//     return Container(
//       width: 30, // Adjust width as needed
//       height: 60, // Adjust height as needed
//       decoration: BoxDecoration(
//         border: Border(
//           right: BorderSide(
//             color: Colors.black,
//             width: 1.5,
//           ),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             letter,
//             style: TextStyle(fontSize: 20, color: Colors.blue),
//           ),
//           Text(
//             number,
//             style: TextStyle(fontSize: 20, color: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:inkc/adddoginfo.dart';
import 'package:sizer/sizer.dart';

class IdCard extends StatefulWidget {
  String image,
      firstname,
      lastname,
      email,
      number,
      gender,
      dob,
      country,
      state,
      city,
      Fulladdress,
      Countrygetdata,
      Stategetdata,
      Districtgetdata,
      pincode,
      countryid,
      stateid,
      district,
      userid,
      card_expiry_date;
  List<String> card_code;

  IdCard({
    super.key,
    required this.image,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.number,
    required this.gender,
    required this.dob,
    required this.country,
    required this.state,
    required this.city,
    required this.Fulladdress,
    required this.Countrygetdata,
    required this.Stategetdata,
    required this.Districtgetdata,
    required this.pincode,
    required this.countryid,
    required this.stateid,
    required this.district,
    required this.userid,
    required this.card_code,
    required this.card_expiry_date,
  });

  @override
  State<IdCard> createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon:
        //       Icon(Icons.arrow_back, color: Color.fromARGB(255, 223, 39, 39)),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ID Card',
              style: TextStyle(
                  shadows: const [
                    Shadow(
                      blurRadius: 10.0, // shadow blur
                      color: Color.fromARGB(255, 223, 71, 45), // shadow color
                      offset: Offset(2.0, 2.0), // how much shadow will be shown
                    ),
                  ],
                  fontSize: 20.sp,
                  decorationColor: Colors.red,
                  color: const Color.fromARGB(255, 194, 97, 33),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Sizer(builder: (context, orientation, deviceType) {
        return SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10,top: 10),
              width: double.infinity,
              height: 550,
              // decoration: BoxDecoration(
              //   color: Colors.yellow,
              //   borderRadius: BorderRadius.circular(16),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black, // Black border color
                  width: 4, // Border thickness
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  if (widget.image == "null")
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/adv.png'),
                      radius: 50,
                    )
                  else
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://new-demo.inkcdogs.org/' + widget.image),
                      radius: 50,
                    ),
                  const SizedBox(height: 8),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FullScreenWidget(
                        disposeLevel: DisposeLevel.High,
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: const Color.fromARGB(255, 24, 22, 26),
                            // ),
                            // borderRadius: const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/qrcode.png",
                            )),
                          ),
                          margin: const EdgeInsets.all(12),
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Text(
                        "click to QR code to expand",
                        style: TextStyle(fontSize: 7),
                      ),
                    ],
                  ),
          
                  //  Text(
                  //   widget.firstname,
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'Cursive',
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.firstname + " " + widget.lastname,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                "Member ID :",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                widget.userid,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         "Card Valid  :",
                        //         style: TextStyle(
                        //             color: Colors.black54,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //       SizedBox(
                        //         width: 15,
                        //       ),
                        //       Text(
                        //         widget.card_expiry_date,
                        //         style: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "E-mail ID :",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: Text(
                                  widget.email,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                "Mobile :",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: Text(
                                  widget.number,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address :",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Text(
                                  widget.Fulladdress,
                                  // ", " +
                                  // widget.district +
                                  // ", " +
                                  // widget.Countrygetdata +
                                  // ", " +
                                  // widget.Stategetdata +
                                  // "\nPin Code / Zip Code " +
                                  // widget.pincode,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < widget.card_code.length; i++)
                          if ((i % 2) == 0)
                            buildBox(widget.card_code[i], widget.card_code[i + 1])
          
                        //  else
                        //  buildBox(widget.card_code[i], widget.card_code[i])
                        // print(widget.card_code[i].toString());
          
                        // Each box
          
                        // buildBox('B', '37'),
                        // buildBox('S', '83'),
                        // buildBox('O', '16'),
                        // buildBox('L', '20'),
                        // buildBox('U', '70'),
                        // buildBox('T', '70'),
                        // buildBox('E', '56'),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // Image.network(
                  //   'https://via.placeholder.com/80', // Placeholder for QR Code
                  //   height: 80,
                  //   width: 80,
                  // ),
                  // const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Function to build each box
  Widget buildBox(String letter, String number) {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            letter,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            // margin: EdgeInsets.only(top: 10, left: 3),
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 70, 9, 9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      // Center(
      //   child: RichText(
      //     textAlign: TextAlign.center,
      //     text: TextSpan(
      //       children: [
      //         TextSpan(
      //           text: "$letter\n",
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 12,
      //             color: Colors.black,
      //           ),
      //         ),
      //         TextSpan(
      //           text: number,
      //           style: const TextStyle(
      //             fontSize: 10,
      //             color: Colors.black,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
