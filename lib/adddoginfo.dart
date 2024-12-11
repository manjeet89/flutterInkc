import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkc/form/non_inkc_register_form.dart';
import 'package:inkc/form/pedigree_dog_registration.dart';
import 'package:inkc/form/unknow_pedigree_registration_form.dart';
import 'package:sizer/sizer.dart';

class AddDogInfo extends StatefulWidget {
  const AddDogInfo({super.key});

  //const AddDogInfo(JsonCodec json, {super.key});

  @override
  State<AddDogInfo> createState() => _AddDogInfoState();
}

class _AddDogInfoState extends State<AddDogInfo> {
  bool _isShow = true;
  bool _isShowOff = false;

  @override
  Widget build(BuildContext context) {
    print(json);
    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back,
              //       color: Color.fromARGB(255, 223, 39, 39)),
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
              title: const Text(
                'Add Dogs',
                style: TextStyle(
                    fontSize: 20,
                    // decorationColor: Colors.red,
                    color: Color.fromARGB(255, 61, 58, 55),
                    // color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        height: 140.sp,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
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
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // PopCard(context);
                                setState(() {
                                  _isShow = !_isShow;
                                  _isShowOff = !_isShowOff;
                                });

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         AddDogInfo()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 12, left: 12, bottom: 12),
                                height: 130.0.sp,
                                width: 120.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),

                                  //set border radius to 50% of square height and width
                                  // image: DecorationImage(
                                  //   image: NetworkImage(
                                  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9YYbsgfuFMdNL1qCz-dAQbF5Y3zgVwwpaUEr-B5dglUiZhQemtfJRysL2XVAsCAhB-EA&usqp=CAU"),
                                  //   fit: BoxFit.fill, //change image fill type
                                  // ),
                                ),
                                child: Image.asset(
                                    "assets/registerdogwithinkc.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 15, right: 20),
                              child: Text(
                                'Register Dog  with \nINKC',
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 14, 13, 13),
                                    fontWeight: FontWeight.bold,
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

                      // Second dog

                      Visibility(
                        visible: _isShow,
                        child: Container(
                          height: 140.sp,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
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
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const NonInkcRegistrationForm()));

                                  // PopCard(context);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         AddDogInfo()));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 12, left: 12, bottom: 12),
                                  height: 130.0.sp,
                                  width: 120.0.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

                                    //set border radius to 50% of square height and width
                                    // image: DecorationImage(
                                    //   image: NetworkImage(
                                    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqKkgY-r9T6CJfXlX-2lxKG_82r_4E3A0XCQ&usqp=CAU"),
                                    //   fit: BoxFit.fill, //change image fill type
                                    // ),
                                  ),
                                  child: Image.asset("assets/noninkcdogs.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, left: 15, right: 20),
                                child: Text(
                                  'Non-INKC Dog \nRegistration',
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 10, 10, 10),
                                      fontWeight: FontWeight.bold,
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
                      ),

                      Visibility(
                        visible: _isShowOff,
                        child: Container(
                          height: 150.sp,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
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
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const PedigreeDogRegistrationForm()));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 12, left: 12, bottom: 12),
                                  height: 150.0.sp,
                                  width: 120.0.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

                                    //set border radius to 50% of square height and width
                                    // image: DecorationImage(
                                    //   image: NetworkImage(
                                    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmbCAFop9yHBNy3oyZpSbaAssDONlhbCdi8w&usqp=CAU"),
                                    //   fit: BoxFit.fill, //change image fill type
                                    // ),
                                  ),
                                  child: Image.asset(
                                      "assets/registeredinkcdogs.png"),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 15, right: 20),
                                    child: Text(
                                      'Pedigree Dog \n Registration',
                                      style: TextStyle(
                                          color: const Color.fromARGB(255, 105, 2, 2),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, left: 15, right: 5),
                                    child: Text(
                                      maxLines: null,
                                      '(Both parents are  \nregistered with INKC \nor any reputed or\n affilated international \nKennel Club)',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 13, 14),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              // Text(
                              //   "Show All Dogs",
                              //   style: TextStyle(color: Colors.black),
                              // )
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: _isShowOff,
                        child: Container(
                          height: 140.sp,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
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
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  // PopCard(context);
                                  setState(() {
                                    _isShow = !_isShow;
                                  });

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const UnknowPedigreeDogRegistrationForm()));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 12, left: 12, bottom: 12),
                                  height: 130.0.sp,
                                  width: 120.0.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

                                    //set border radius to 50% of square height and width
                                    // image: DecorationImage(
                                    //   image: NetworkImage(
                                    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjzfyB4eh-vCo9qtX5jdrxNIPlWQBeG91gvQ&usqp=CAU"),
                                    //   fit: BoxFit.fill, //change image fill type
                                    // ),
                                  ),
                                  child: Image.asset(
                                      "assets/unknownpedigreeregistration.png"),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 15, right: 20),
                                    child: Text(
                                      'Unknown Pedigree \n Registration',
                                      style: TextStyle(
                                          color: const Color.fromARGB(255, 105, 2, 2),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0, left: 5),
                                    child: Text(
                                      maxLines: null,
                                      '(One or both  parents not \n registered)',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 13, 14),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              // Text(
                              //   "Show All Dogs",
                              //   style: TextStyle(color: Colors.black),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Future<dynamic> PopCard(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         Future.delayed(Duration(seconds: 1000), () {
  //           Navigator.of(context).pop(true);
  //         });
  //         return AlertDialog(
  //           insetPadding: EdgeInsets.all(10.0),
  //           content: Container(
  //             width: MediaQuery.of(context).size.width,
  //             child: Container(
  //               // decoration: BoxDecoration(
  //               //     gradient: LinearGradient(
  //               //   begin: Alignment.topRight,
  //               //   end: Alignment.bottomLeft,
  //               //   colors: [
  //               //     Color.fromARGB(255, 177, 209, 235),
  //               //     Color.fromARGB(255, 202, 142, 138),
  //               //   ],
  //               // )),
  //               child: SingleChildScrollView(
  //                 scrollDirection: Axis.horizontal,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       height: 380,
  //                       decoration: BoxDecoration(
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Color.fromARGB(255, 178, 177, 189),
  //                             blurRadius: 10,
  //                             offset: Offset(
  //                               5,
  //                               5,
  //                             ),
  //                           )
  //                         ],
  //                         border: Border.all(
  //                           color: Colors.black,
  //                           width: 0.5,
  //                         ),
  //                         borderRadius: BorderRadius.circular(20),
  //                         color: Colors.white,
  //                       ),
  //                       margin: EdgeInsets.all(5),
  //                       child: Row(
  //                         // crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           InkWell(
  //                             onTap: () {
  //                               Navigator.of(context).push(MaterialPageRoute(
  //                                   builder: (BuildContext context) =>
  //                                       AddDogInfo()));
  //                             },
  //                             child: Container(
  //                               margin:
  //                                   EdgeInsets.only(top: 8, right: 8, left: 8),
  //                               height: 200.0,
  //                               width: 200.0,
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 //set border radius to 50% of square height and width
  //                                 image: DecorationImage(
  //                                   image: NetworkImage(
  //                                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmbCAFop9yHBNy3oyZpSbaAssDONlhbCdi8w&usqp=CAU"),
  //                                   fit: BoxFit.fill, //change image fill type
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: 10.0, left: 5),
  //                             child: Text(
  //                               'Pedigree Dog \n Registration',
  //                               style: TextStyle(
  //                                   shadows: [
  //                                     Shadow(
  //                                       blurRadius: 5.0, // shadow blur
  //                                       color: Color.fromARGB(
  //                                           255, 233, 69, 27), // shadow color
  //                                       offset: Offset(1.0,
  //                                           1.0), // how much shadow will be shown
  //                                     ),
  //                                   ],
  //                                   color: Color.fromARGB(255, 233, 69, 27),
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 18),
  //                             ),
  //                           ),

  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: 15.0, left: 5),
  //                             child: Text(
  //                               maxLines: null,
  //                               '(Both parents are  \nregistered with INKC \nor any reputed or\n affilated international \nKennel Club)',
  //                               style: TextStyle(
  //                                   shadows: [
  //                                     Shadow(
  //                                       blurRadius: 1.0, // shadow blur
  //                                       color: Color.fromARGB(
  //                                           255, 163, 154, 243), // shadow color
  //                                       offset: Offset(1.0,
  //                                           1.0), // how much shadow will be shown
  //                                     ),
  //                                   ],
  //                                   color: Color.fromARGB(255, 10, 13, 14),
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 13),
  //                             ),
  //                           ),
  //                           // Text(
  //                           //   "Show All Dogs",
  //                           //   style: TextStyle(color: Colors.black),
  //                           // )
  //                         ],
  //                       ),
  //                     ),
  //                     //Thired dog

  //                     Container(
  //                       height: 380,
  //                       decoration: BoxDecoration(
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Color.fromARGB(255, 178, 177, 189),
  //                             blurRadius: 10,
  //                             offset: Offset(
  //                               5,
  //                               5,
  //                             ),
  //                           )
  //                         ],
  //                         border: Border.all(
  //                           color: Colors.black,
  //                           width: 0.5,
  //                         ),
  //                         borderRadius: BorderRadius.circular(20),
  //                         color: Colors.white,
  //                       ),
  //                       margin: EdgeInsets.all(15),
  //                       child: Row(
  //                         children: [
  //                           InkWell(
  //                             onTap: () {},
  //                             child: Container(
  //                               margin:
  //                                   EdgeInsets.only(top: 8, right: 8, left: 8),
  //                               height: 200.0,
  //                               width: 200.0,
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 //set border radius to 50% of square height and width
  //                                 image: DecorationImage(
  //                                   image: NetworkImage(
  //                                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjzfyB4eh-vCo9qtX5jdrxNIPlWQBeG91gvQ&usqp=CAU"),
  //                                   fit: BoxFit.cover, //change image fill type
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: 10.0, left: 25),
  //                             child: Text(
  //                               'Unknow Pedigree \n Registration',
  //                               style: TextStyle(
  //                                   shadows: [
  //                                     Shadow(
  //                                       blurRadius: 5.0, // shadow blur
  //                                       color: Color.fromARGB(
  //                                           255, 233, 69, 27), // shadow color
  //                                       offset: Offset(1.0,
  //                                           1.0), // how much shadow will be shown
  //                                     ),
  //                                   ],
  //                                   color: Color.fromARGB(255, 233, 69, 27),
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 18),
  //                             ),
  //                           ),

  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: 15.0, left: 5),
  //                             child: Text(
  //                               maxLines: null,
  //                               '(One or both  parents not \n registered)',
  //                               style: TextStyle(
  //                                   shadows: [
  //                                     Shadow(
  //                                       blurRadius: 1.0, // shadow blur
  //                                       color: Color.fromARGB(
  //                                           255, 163, 154, 243), // shadow color
  //                                       offset: Offset(1.0,
  //                                           1.0), // how much shadow will be shown
  //                                     ),
  //                                   ],
  //                                   color: Color.fromARGB(255, 10, 13, 14),
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 13),
  //                             ),
  //                           ),
  //                           // Text(
  //                           //   "Show All Dogs",
  //                           //   style: TextStyle(color: Colors.black),
  //                           // )
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });

  // }
}
