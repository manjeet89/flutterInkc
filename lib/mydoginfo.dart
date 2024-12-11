import 'package:flutter/material.dart';
import 'package:inkc/non_inkc_registration_dog.dart';
import 'package:sizer/sizer.dart';

import 'inkcRegisterDog.dart';

class MyDogInfo extends StatefulWidget {
  const MyDogInfo({super.key});

  @override
  State<MyDogInfo> createState() => _MyDogInfoState();
}

class _MyDogInfoState extends State<MyDogInfo> {
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
            appBar: AppBar(
              backgroundColor: Colors.white,
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back,
              //       color: Color.fromARGB(255, 223, 39, 39)),
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
              title: Text(
                'My Dogs',
                style: TextStyle(
                    shadows: const [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Color.fromARGB(255, 223, 71, 45), // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                    fontSize: 20.sp,
                    decorationColor: Colors.red,
                    color: const Color.fromARGB(255, 194, 97, 33),
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
                      // Container(
                      //     margin: EdgeInsets.only(bottom: 20),
                      //     child: Text(
                      //       'Our Dogs',
                      //       style: TextStyle(
                      //           shadows: [
                      //             Shadow(
                      //               blurRadius: 10.0, // shadow blur
                      //               color: Color.fromARGB(
                      //                   255, 223, 71, 45), // shadow color
                      //               offset: Offset(
                      //                   2.0, 2.0), // how much shadow will be shown
                      //             ),
                      //           ],
                      //           fontSize: 25,
                      //           decorationColor: Colors.red,
                      //           color: Color.fromARGB(255, 194, 97, 33),
                      //           // color: Colors.black,
                      //           fontWeight: FontWeight.bold),
                      //     )),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const INKCDogRegistration()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 12, left: 12, bottom: 12),
                                height: 130.0.sp,
                                width: 120.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  //set border radius to 50% of square height and width
                                  // image: DecorationImage(
                                  //   image: NetworkImage(
                                  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMq7svXemr7fVP-3Z5Qvb-TFj5LW4zscRvEGgZnVuXe0N9J6Y7iWm6adhgcxmQJPdyqpw&usqp=CAU"),
                                  //   fit: BoxFit.fill, //change image fill type
                                  // ),
                                ),
                                child: Image.asset(
                                    "assets/registeredinkcdogs.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 15, right: 20),
                              child: Text(
                                'Registered INKC\n Dogs',
                                style: TextStyle(
                                    shadows: const [
                                      Shadow(
                                        blurRadius: 10.0, // shadow blur
                                        color: Color.fromARGB(
                                            255, 223, 71, 45), // shadow color
                                        offset: Offset(2.0,
                                            2.0), // how much shadow will be shown
                                      ),
                                    ],
                                    color: const Color.fromARGB(255, 223, 71, 45),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const NonInkcRegistrationDog()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 12, left: 12, bottom: 12),
                                height: 130.0.sp,
                                width: 120.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  //set border radius to 50% of square height and width
                                  // image: DecorationImage(
                                  //   image: NetworkImage(
                                  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfPR4l2F4nyU7e19PgC0g0Z3SkrO7ygNhfmlDP4IprpD1BWkzPKVh6MXyPIrV7xuHmhIw&usqp=CAU"),
                                  //   fit: BoxFit.fill, //change image fill type
                                  // ),
                                ),
                                child: Image.asset("assets/noninkcdogs.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 15, right: 20),
                              child: Text(
                                'Non-INKC Dogs',
                                style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 10.0, // shadow blur
                                      color: Color.fromARGB(
                                          255, 223, 71, 45), // shadow color
                                      offset: Offset(2.0,
                                          2.0), // how much shadow will be shown
                                    ),
                                  ],
                                  color: const Color.fromARGB(255, 223, 71, 45),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            // Text(
                            //   "Show All Dogs",
                            //   style: TextStyle(color: Colors.black),
                            // )
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 180,
                      //   decoration: BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(
                      //         blurRadius: 10,
                      //         offset: Offset(
                      //           5,
                      //           5,
                      //         ),
                      //       )
                      //     ],
                      //     border: Border.all(
                      //       color: Colors.black,
                      //       width: 0.5,
                      //     ),
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.white,
                      //   ),
                      //   margin: EdgeInsets.all(15),
                      //   child: Row(
                      //     // crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       InkWell(
                      //         onTap: () {},
                      //         child: Container(
                      //           margin: EdgeInsets.only(top: 12, left: 12),
                      //           height: 16s0.0,
                      //           width: 150.0,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5.sp),
                      //             //set border radius to 50% of square height and width
                      //             image: DecorationImage(
                      //               image: NetworkImage(
                      //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfPR4l2F4nyU7e19PgC0g0Z3SkrO7ygNhfmlDP4IprpD1BWkzPKVh6MXyPIrV7xuHmhIw&usqp=CAU"),
                      //               fit: BoxFit.fill, //change image fill type
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(
                      //             top: 30.0, left: 15, right: 20),
                      //         child: Text(
                      //           'Non- INKC \n Dogs',
                      //           style: TextStyle(
                      //               shadows: [
                      //                 Shadow(
                      //                   blurRadius: 10.0, // shadow blur
                      //                   color: Color.fromARGB(
                      //                       255, 223, 71, 45), // shadow color
                      //                   offset: Offset(2.0,
                      //                       2.0), // how much shadow will be shown
                      //                 ),
                      //               ],
                      //               color: Color.fromARGB(255, 230, 42, 17),
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 15.sp),
                      //         ),
                      //       ),
                      //       // Text(
                      //       //   "Show All Dogs",
                      //       //   style: TextStyle(color: Colors.black),
                      //       // )
                      //     ],
                      //   ),
                      // ),
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
}
