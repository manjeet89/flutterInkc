import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inkc/KennelClub/kennelclubname.dart';
import 'package:inkc/Staticpages/doglittertransferoverview.dart';
import 'package:inkc/Staticpages/puppiesavailable.dart';
import 'package:inkc/Staticpages/studsavailable.dart';
import 'package:inkc/adddoginfo.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/events/events.dart';
import 'package:inkc/inkcstore.dart';
import 'package:inkc/KennelClub/kennelnamehistory.dart';
import 'package:inkc/litternumber.dart';
import 'package:inkc/main.dart';
import 'package:inkc/model/cartlist.dart';
import 'package:inkc/mydoginfo.dart';
import 'package:inkc/other/contactus.dart';
import 'package:inkc/other/overview.dart';
import 'package:inkc/other/refunds.dart';
import 'package:inkc/other/social.dart';
import 'package:inkc/other/terms.dart';
import 'package:inkc/verification.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Staticpages/assosicatememberoverview.dart';
import '../Staticpages/kennelnameregistrationoverview.dart';
import '../Staticpages/litterregistrationoverview.dart';
import '../Staticpages/singledogregistrationoverview.dart';
import '../Staticpages/unknowpadigreeoverview.dart';
import '../profile.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

void main() {
  runApp(const HomePages());
}

var finalToken;

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Home(),
        );
      },
    );
  }
}

// onWillPop: () async {
//         final value = await showDialog<bool>(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text("DoggyLocker"),
//                 content: Text("Do you want to Exit"),
//                 actions: [
//                   ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(false),
//                       child: const Text("No")),
//                   ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(true),
//                       child: const Text("Exit"))
//                 ],
//               );
//             });

//         if (value != null) {
//           return Future.value(value);
//         } else {
//           return Future.value(false);
//         }
//       },
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final List<String> imgList = [
  'https://new-demo.inkcdogs.org/assets/front/img/inkc/puli.jpg',
  'https://new-demo.inkcdogs.org/assets/front/img/inkc/bi.jpg',
  'https://new-demo.inkcdogs.org/assets/front/img/inkc/52.webp',
  'https://new-demo.inkcdogs.org/assets/front/img/inkc/53.webp',
];

final myItems = [
  Image.network('https://new-demo.inkcdogs.org/assets/front/img/inkc/puli.jpg'),
  Image.network('https://new-demo.inkcdogs.org/assets/front/img/inkc/bi.jpg'),
  Image.network('https://new-demo.inkcdogs.org/assets/front/img/inkc/52.webp'),
  Image.network('https://new-demo.inkcdogs.org/assets/front/img/inkc/53.webp'),
];

List mydogname = [
  "Ch. Puli",
  "Ch. Bianca Casa Frizzled Life X-Cell",
  "Ch. Bianca Casa Frizzled Life X-Cell",
  "Ch. Bianca Casa Frizzled Life X-Cell",
];
int mycurrentindex = 0;

class _HomeState extends State<Home> {
  bool _isShow = false;
  bool _isShowoff = false;
  bool _storeshow = false;
  bool _storehide = true;

  List cup = [];
  List toona = [];

  bool istrue = false;

  @override
  void initState() {
    // TODO: implement initState
    Checklogin();
    getValidationData();
    checkstore();
    //EventsCheck();

    super.initState();
    // if (_isShow == true) {
    //   _isShow = false;
    //   _isShowoff = true;
    // }
  }

  // EventsCheck() async {
  //   if (istrue == false) {
  //     final uri = "https://new-demo.inkcdogs.org/api/home/event";
  //     final responce = await http.post(Uri.parse(uri));
  //     var data = json.decode(responce.body);
  //     List dataarray = data['data'];
  //     for (int i = 0; i < dataarray.length; i++) {
  //       // print(data['data'][i]['event_image'].toString());
  //       toona.add(
  //           "https://new-demo.inkcdogs.org/" + data['data'][i]['event_image'].toString());
  //     }
  //     setState(() {
  //       cup = toona;
  //       istrue = true;
  //     });
  //   }
  // }

  checkstore() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("Token");
    if (check != null) {
      setState(() {
        _storeshow = false;
        _storehide = true;
      });
    } else {
      setState(() {
        _storeshow = true;
        _storehide = false;
      });
    }
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
  @override
  Widget build(BuildContext context) {
    print(toona);
    return Scaffold(
      // appBar: AppBar(
      //   title: Title(
      //     color: Colors.black,
      //     child: Text(
      //       'DoggyLocker',
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      //   actions: [
      //     Padding(padding: EdgeInsets.all(16)),
      //     IconButton(
      //       icon: const Icon(Icons.person),
      //       tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(content: Text('This is a snackbar')));
      //       },
      //     ),
      //   ],
      //   backgroundColor: Colors.white70,
      // ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                            ),

                            child: Container(
                              decoration: BoxDecoration(
                                color: ui.Color.fromARGB(255, 85, 70, 218),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),

                              // color: Colors.black,
                              height: 110.sp,
                              width: 110.sp,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset('assets/doggylocker.png'),
                              ),
                            ),
                            // decoration: BoxDecoration(
                            //   color: ui.Color.fromARGB(255, 27, 11, 148),
                            //   border: Border.all(
                            //       width: 1,
                            //       color: Theme.of(context)
                            //           .scaffoldBackgroundColor),
                            //   boxShadow: [
                            //     BoxShadow(
                            //         spreadRadius: 2,
                            //         blurRadius: 10,
                            //         color: Colors.black.withOpacity(0.1),
                            //         offset: Offset(0, 10))
                            //   ],
                            // shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   image: AssetImage("assets/doggylocker.png"),
                            //   fit: BoxFit.cover, //change image fill type
                            // ),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'DoggyLocker',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0, // shadow blur
                                  color: Color.fromARGB(
                                      255, 85, 70, 218), // shadow color
                                  offset: Offset(
                                      1.0, .0), // how much shadow will be shown
                                ),
                              ],
                              fontSize: 18.sp,
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(),

            Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 5.sp),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              var url =
                                  Uri.parse("https://new-demo.inkcdogs.org/studs-available");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Container(
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 119, 116, 148),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width

                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTPuz23RJGE-AprZF_jjZ1ZvaGWG2CfZ_taA&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 25, right: 5, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: null,
                                    'Studs Available',
                                    style: TextStyle(
                                      fontSize: 12,
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SingleDogRegistrationOverView()));
                            },
                            child: Container(
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 119, 116, 148),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width

                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpIfFGWNdC-ppcDZx596eACoVokhVJZ4qKeg&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 20, right: 5, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: null,
                                    'Single Dog Registration',
                                    style: TextStyle(
                                      fontSize: 12,
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(5.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          UnKnowPadigreeOverView()));
                            },
                            child: Container(
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 119, 116, 148),
                                    blurRadius: 10,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width

                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzQn73-KfRwCaN-NWF_5zNqeM2DiQ9S0LsMA&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 30, right: 5, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: null,
                                    'Unknown Pedigree',
                                    style: TextStyle(
                                      fontSize: 12,
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(8.sp),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.of(context, rootNavigator: true).push(
                    //               MaterialPageRoute(
                    //                   builder: (_) =>
                    //                       UnKnowPadigreeOverView()));
                    //         },
                    //         child: Container(
                    //           height: 45.0.sp,
                    //           width: 45.0.sp,
                    //           decoration: BoxDecoration(
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Color.fromARGB(255, 178, 177, 189),
                    //                 blurRadius: 5,
                    //                 offset: Offset(
                    //                   5,
                    //                   5,
                    //                 ),
                    //               )
                    //             ],
                    //             borderRadius: BorderRadius.circular(50.sp),
                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzQn73-KfRwCaN-NWF_5zNqeM2DiQ9S0LsMA&usqp=CAU"),
                    //               fit: BoxFit.cover, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 100,
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               top: 10.0, left: 20, right: 5, bottom: 10),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 maxLines: null,
                    //                 'Unknown Pedigree',
                    //                 style: TextStyle(
                    //                   fontSize: 11,
                    //                   fontWeight: FontWeight.bold,
                    //                   // foreground: Paint()
                    //                   //   ..shader = ui.Gradient.linear(
                    //                   //     const Offset(100, 60),
                    //                   //     const Offset(160, 20),
                    //                   //     <Color>[
                    //                   //       Color.fromARGB(255, 235, 15, 15),
                    //                   //       Color.fromARGB(255, 22, 26, 226),
                    //                   //     ],
                    //                   //   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Container(
                      margin: EdgeInsets.all(8.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          LitterRegistrationOverView()));
                            },
                            child: Container(
                              margin: EdgeInsets.all(5.sp),
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 5,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMdsRMuWI4GKCuT9mie5lCabZIAxZfCoQiDQ&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 35, right: 5, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Litter Registration',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      // foreground: Paint()
                                      //   ..shader = ui.Gradient.linear(
                                      //     const Offset(135, 60),
                                      //     const Offset(160, 20),
                                      //     <Color>[
                                      //       Color.fromARGB(255, 235, 15, 15),
                                      //       Color.fromARGB(255, 22, 26, 226),
                                      //     ],
                                      //   ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // second dog about
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () async {
                          var url =
                              Uri.parse("https://new-demo.inkcdogs.org/puppies-available");
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 45.0.sp,
                                width: 45.0.sp,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 178, 177, 189),
                                      blurRadius: 5,
                                      offset: Offset(
                                        5,
                                        5,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(50.sp),
                                  //set border radius to 50% of square height and width
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAg5Gmh4HAK04kKkgFRE4-oCfHiGBJoKU4iw&usqp=CAU"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 35,
                                      right: 5,
                                      bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: null,
                                        'Puppies Available',
                                        style: TextStyle(
                                          fontSize: 11,
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (_) =>
                                    KennelNameRegistrationOverView()));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 5,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpIfFGWNdC-ppcDZx596eACoVokhVJZ4qKeg&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 25, right: 5, bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: null,
                                      'Kennel Name Registraion',
                                      style: TextStyle(
                                        fontSize: 11,
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (_) => DogLitterTransferOverView()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 5,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgd2T4zsOQWKcxaEITpq7tO6YxFs6T00SOb2RXxThGzf9vcBWFUZLYg7CKFPF9egr1XQ&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 25, right: 5, bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: null,
                                      'Dog / Litter Transfer',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        // foreground: Paint()
                                        //   ..shader = ui.Gradient.linear(
                                        //     const Offset(110, 60),
                                        //     const Offset(160, 20),
                                        //     <Color>[
                                        //       Color.fromARGB(255, 235, 15, 15),
                                        //       Color.fromARGB(255, 22, 26, 226),
                                        //     ],
                                        //   ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (_) => AssosicateMemberOverView()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 45.0.sp,
                              width: 45.0.sp,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 178, 177, 189),
                                    blurRadius: 5,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50.sp),
                                //set border radius to 50% of square height and width
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKolzJBzeQCAWG2sfK7vee-Eb_93Okhdt5B2h3OKGHwymwbUFqhYoNYzgSqpYr7HjANPs&usqp=CAU"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 25, right: 5, bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Associate Membership',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        // foreground: Paint()
                                        //   ..shader = ui.Gradient.linear(
                                        //     const Offset(140, 60),
                                        //     const Offset(160, 20),
                                        //     <Color>[
                                        //       Color.fromARGB(255, 235, 15, 15),
                                        //       Color.fromARGB(255, 22, 26, 226),
                                        //     ],
                                        //   ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(),
            //Events

            Container(
              margin: EdgeInsets.all(5.sp),
              child: Column(
                children: [
                  Text(
                    'Dog of the Year',
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            // blurRadius: 10.0, // shadow blur
                            color: ui.Color.fromARGB(
                                255, 19, 1, 1), // shadow color
                            // offset: Offset(
                            //     2.0, 2.0), // how much shadow will be shown
                          ),
                        ],
                        fontWeight: FontWeight.w900,
                        // foreground: Paint()
                        //   ..shader = ui.Gradient.linear(
                        //     const Offset(0, 20),
                        //     const Offset(150, 20),
                        //     <Color>[
                        //       Color.fromARGB(255, 235, 15, 15),
                        //       Color.fromARGB(255, 22, 26, 226),
                        //     ],
                        //   ),
                        fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            Divider(),
            // listview
            Container(
              margin: EdgeInsets.only(top: 10.sp, bottom: 31.sp),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ui.Color.fromARGB(255, 246, 245, 252),
                            blurRadius: 1,
                          )
                        ],
                        // border: Border.all(),
                        border: Border.all(
                          color: ui.Color.fromARGB(207, 240, 234, 234),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: myItems,
                            options: CarouselOptions(
                              autoPlay: true,
                              height: 180.sp,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayInterval: Duration(seconds: 2),
                              enlargeCenterPage: true,
                              aspectRatio: 3.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  mycurrentindex = index;
                                });
                              },
                            ),
                          ),
                          CarouselSlider(
                            items: [
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text("Ch. Puli",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                    "Ch. Bianca Casa Frizzled Life X-Cell",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text("Ch. Mother Touch Yashkiran Ozone",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Ch. Westernberg’s Alex Shot",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              autoPlay: true,
                              height: 40.sp,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1000),
                              autoPlayInterval: Duration(seconds: 2),
                              enlargeCenterPage: true,
                              aspectRatio: 3.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  mycurrentindex = index;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // CarouselSlider(
                  //     items: toona
                  //         .map(
                  //           (item) => Container(
                  //             decoration: BoxDecoration(
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Color.fromARGB(255, 178, 177, 189),
                  //                   blurRadius: 10,
                  //                 )
                  //               ],
                  //               // border: Border.all(),
                  //               border: Border.all(
                  //                 color: Color.fromARGB(26, 221, 219, 219),
                  //                 width: 1.5,
                  //               ),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(15)),
                  //             ),
                  //             child: Center(
                  //               child: Image.network(
                  //                 item,
                  //                 fit: BoxFit.fill,
                  //                 width: 400.sp,
                  //                 height: 240.sp,
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //     options: CarouselOptions(
                  //         autoPlay: true,
                  //         autoPlayAnimationDuration:
                  //             Duration(milliseconds: 800),
                  //         autoPlayInterval: Duration(seconds: 2),
                  //         aspectRatio: 2.0,
                  //         enlargeCenterPage: true)),
                ],
              ),
            ),

            Divider(),
            //Events

            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    'Our Services',
                    style: TextStyle(
                        fontSize: 17.sp,
                        shadows: [
                          Shadow(
                            // blurRadius: 10.0, // shadow blur
                            color:
                                ui.Color.fromARGB(255, 7, 1, 1), // shadow color
                            // offset: Offset(
                            //     2.0, 2.0), // how much shadow will be shown
                          ),
                        ],
                        fontWeight: FontWeight.w900,
                        foreground: Paint()
                        // ..shader = ui.Gradient.linear(
                        //   const Offset(0, 20),
                        //   const Offset(150, 20),
                        //   <Color>[
                        //     Color.fromARGB(255, 235, 15, 15),
                        //     Color.fromARGB(255, 22, 26, 226),
                        //   ],
                        // ),
                        ),
                  ),
                ],
              ),
            ),
            Divider(),

            // Main Feature Card
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Visibility(
                      visible: _storeshow,
                      child: Container(
                        height: 180.sp,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
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
                        margin: EdgeInsets.all(15),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        INKCStore()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: 110.0.sp,
                                width: 110.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  //set border radius to 50% of square height and width
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDjYq9BVfv-KOMjn7620qMLjlqNhnUxz2RTA&usqp=CAU"),
                                    fit: BoxFit.fill, //change image fill type
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, left: 10),
                              child: Text(
                                'INKC Store',
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        // blurRadius: 5.0, // shadow blur
                                        color: ui.Color.fromARGB(
                                            255, 2, 1, 10), // shadow color
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
                                    fontSize: 13.sp),
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
                      visible: _storeshow,
                      child: Container(
                        height: 180.sp,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
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
                        margin: EdgeInsets.all(15),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Events()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: 110.0.sp,
                                width: 110.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  //set border radius to 50% of square height and width
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPCGEQZMM6D-fzxpK_MsKCBNnXQf5V59RcFQ&usqp=CAU"),
                                    fit: BoxFit.fill, //change image fill type
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, left: 10),
                              child: Text(
                                'Events',
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        // blurRadius: 5.0, // shadow blur
                                        color: ui.Color.fromARGB(
                                            255, 7, 7, 14), // shadow color
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
                                    fontSize: 13.sp),
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

                    // Container(
                    //   height: 180.sp,
                    //   // width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       InkWell(
                    //         onTap: () async {
                    //           SharedPreferences sharedprefrence =
                    //               await SharedPreferences.getInstance();
                    //           String? check =
                    //               sharedprefrence.getString("Token");
                    //           if (check != null) {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     MyDogInfo()));
                    //           } else {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     Login()));
                    //           }
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 110.0.sp,
                    //           width: 110.0.sp,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(15.sp),

                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2FihNWtx6Ymf7RSAX_mD1nzIzib37pSKYcw&usqp=CAU"),
                    //               fit: BoxFit.fill, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 10),
                    //         child: Text(
                    //           'My Dogs',
                    //           style: TextStyle(
                    //               shadows: [
                    //                 Shadow(
                    //                   // blurRadius: 5.0, // shadow blur
                    //                   color: Color.fromARGB(
                    //                       255, 85, 70, 218), // shadow color
                    //                   // offset: Offset(2.0,
                    //                   //     2.0), // how much shadow will be shown
                    //                 ),
                    //               ],
                    //               fontWeight: FontWeight.bold,
                    //               // foreground: Paint()
                    //               //   ..shader = ui.Gradient.linear(
                    //               //     const Offset(0, 20),
                    //               //     const Offset(150, 20),
                    //               //     <Color>[
                    //               //       Color.fromARGB(255, 235, 15, 15),
                    //               //       Color.fromARGB(255, 22, 26, 226),
                    //               //     ],
                    //               //   ),
                    //               fontSize: 13.sp),
                    //         ),
                    //       ),
                    //       // Text(
                    //       //   "Show All Dogs",
                    //       //   style: TextStyle(color: Colors.black),
                    //       // )
                    //     ],
                    //   ),
                    // ),

                    // Container(
                    //   height: 180.sp,
                    //   // width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       InkWell(
                    //         onTap: () async {
                    //           SharedPreferences sharedprefrence =
                    //               await SharedPreferences.getInstance();
                    //           String? check =
                    //               sharedprefrence.getString("Token");
                    //           if (check != null) {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     AddDogInfo()));
                    //           } else {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     Login()));
                    //           }
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 110.0.sp,
                    //           width: 110.0.sp,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(15.sp),

                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQytMzUqacbpPtcpXLSMunUbVk3WHWwHmTEl5sk2hMjLamiws8FBrKgcX3_COxEUU9qwxA&usqp=CAU"),
                    //               fit: BoxFit.fill, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 10),
                    //         child: Text(
                    //           'Add Dogs',
                    //           style: TextStyle(shadows: [
                    //             Shadow(
                    //               // blurRadius: 5.0, // shadow blur
                    //               color: ui.Color.fromARGB(
                    //                   255, 3, 2, 5), // shadow color
                    //               // offset: Offset(2.0,
                    //               //     2.0), // how much shadow will be shown
                    //             ),
                    //           ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Container(
                    //   height: 180.sp,
                    //   // width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       InkWell(
                    //         onTap: () async {
                    //           SharedPreferences sharedprefrence =
                    //               await SharedPreferences.getInstance();
                    //           String? check =
                    //               sharedprefrence.getString("Token");
                    //           if (check != null) {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     KennelNumber()));
                    //           } else {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     Login()));
                    //           }
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 110.0.sp,
                    //           width: 110.0.sp,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(15.sp),

                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWtDCjZPdjxQFPy2fbtFWeOy_NhhFL_abZAmOaJUpZbZF_1_QTewBvSEWl_2lyiRFqBSM&usqp=CAU"),
                    //               fit: BoxFit.fill, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 5),
                    //         child: Text(
                    //           'Litter Registration',
                    //           style: TextStyle(shadows: [
                    //             Shadow(
                    //               // blurRadius: 5.0, // shadow blur
                    //               color: Color.fromARGB(
                    //                   255, 85, 70, 218), // shadow color
                    //               // offset: Offset(2.0,
                    //               //     2.0), // how much shadow will be shown
                    //             ),
                    //           ], fontWeight: FontWeight.bold, fontSize: 12.sp),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Container(
                    //   height: 180.sp,
                    //   // width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       InkWell(
                    //         onTap: () async {
                    //           SharedPreferences sharedprefrence =
                    //               await SharedPreferences.getInstance();
                    //           String? check =
                    //               sharedprefrence.getString("Token");
                    //           if (check != null) {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     const MyKennelClubName()));
                    //           } else {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     Login()));
                    //           }
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 110.0.sp,
                    //           width: 110.0.sp,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(15.sp),

                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROTaejmQIPYD0y3QTuGvruNZrJvj0R2tk6rw&usqp=CAU"),
                    //               fit: BoxFit.fill, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 10),
                    //         child: Text(
                    //           'Kennel Name Registration',
                    //           style: TextStyle(
                    //               shadows: [
                    //                 Shadow(
                    //                   // blurRadius: 5.0, // shadow blur
                    //                   color: ui.Color.fromARGB(
                    //                       255, 2, 1, 15), // shadow color
                    //                   // offset: Offset(2.0,
                    //                   //     2.0), // how much shadow will be shown
                    //                 ),
                    //               ],
                    //               fontWeight: FontWeight.bold,
                    //               // foreground: Paint()
                    //               //   ..shader = ui.Gradient.linear(
                    //               //     const Offset(0, 20),
                    //               //     const Offset(150, 20),
                    //               //     <Color>[
                    //               //       Color.fromARGB(255, 235, 15, 15),
                    //               //       Color.fromARGB(255, 22, 26, 226),
                    //               //     ],
                    //               //   ),
                    //               fontSize: 13.sp),
                    //         ),
                    //       ),
                    //       // Text(
                    //       //   "Show All Dogs",
                    //       //   style: TextStyle(color: Colors.black),
                    //       // )
                    //     ],
                    //   ),
                    // ),

                    // Container(
                    //   height: 280,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 200.0,
                    //           width: 200.0,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROTaejmQIPYD0y3QTuGvruNZrJvj0R2tk6rw&usqp=CAU"),
                    //               fit: BoxFit.cover, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 25),
                    //         child: Text(
                    //           'Kennel Name',
                    //           style: TextStyle(
                    //               shadows: [
                    //                 Shadow(
                    //                   blurRadius: 5.0, // shadow blur
                    //                   color: Color.fromARGB(
                    //                       255, 85, 70, 218), // shadow color
                    //                   offset: Offset(2.0,
                    //                       2.0), // how much shadow will be shown
                    //                 ),
                    //               ],
                    //               color: Color.fromARGB(255, 33, 189, 194),
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
                    //         ),
                    //       ),
                    //       // Text(
                    //       //   "Show All Dogs",
                    //       //   style: TextStyle(color: Colors.black),
                    //       // )
                    //     ],
                    //   ),
                    // ),
                    // fifth dog

                    Visibility(
                      visible: _storehide,
                      child: Container(
                        height: 180.sp,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
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
                        margin: EdgeInsets.all(15),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        INKCStore()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: 110.0.sp,
                                width: 110.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  //set border radius to 50% of square height and width
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDjYq9BVfv-KOMjn7620qMLjlqNhnUxz2RTA&usqp=CAU"),
                                    fit: BoxFit.fill, //change image fill type
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, left: 10),
                              child: Text(
                                'INKC Store',
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        // blurRadius: 5.0, // shadow blur
                                        color: ui.Color.fromARGB(
                                            255, 2, 1, 10), // shadow color
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
                                    fontSize: 13.sp),
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
                    // Container(
                    //   height: 280,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 200.0,
                    //           width: 200.0,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDjYq9BVfv-KOMjn7620qMLjlqNhnUxz2RTA&usqp=CAU"),
                    //               fit: BoxFit.cover, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 25),
                    //         child: Text(
                    //           'INKC Store',
                    //           style: TextStyle(
                    //               shadows: [
                    //                 Shadow(
                    //                   blurRadius: 5.0, // shadow blur
                    //                   color: Color.fromARGB(
                    //                       255, 85, 70, 218), // shadow color
                    //                   offset: Offset(2.0,
                    //                       2.0), // how much shadow will be shown
                    //                 ),
                    //               ],
                    //               color: Color.fromARGB(255, 33, 189, 194),
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
                    //         ),
                    //       ),
                    //       // Text(
                    //       //   "Show All Dogs",
                    //       //   style: TextStyle(color: Colors.black),
                    //       // )
                    //     ],
                    //   ),
                    // ),
                    //sixth dog

                    Visibility(
                      visible: _storehide,
                      child: Container(
                        height: 180.sp,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
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
                        margin: EdgeInsets.all(15),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Events()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: 110.0.sp,
                                width: 110.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  //set border radius to 50% of square height and width
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPCGEQZMM6D-fzxpK_MsKCBNnXQf5V59RcFQ&usqp=CAU"),
                                    fit: BoxFit.fill, //change image fill type
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, left: 10),
                              child: Text(
                                'Events',
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        // blurRadius: 5.0, // shadow blur
                                        color: ui.Color.fromARGB(
                                            255, 7, 7, 14), // shadow color
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
                                    fontSize: 13.sp),
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
                    // Container(
                    //   height: 280,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromARGB(255, 178, 177, 189),
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
                    //   child: Column(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 12),
                    //           height: 200.0,
                    //           width: 200.0,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             //set border radius to 50% of square height and width
                    //             image: DecorationImage(
                    //               image: NetworkImage(
                    //                   "https://img.freepik.com/free-vector/cheerful-friends-celebrating-party-together-isolated-flat-illustration-cartoon-illustration_74855-14311.jpg?w=2000"),
                    //               fit: BoxFit.cover, //change image fill type
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0, left: 25),
                    //         child: Text(
                    //           'Events',
                    //           style: TextStyle(
                    //               shadows: [
                    //                 Shadow(
                    //                   blurRadius: 5.0, // shadow blur
                    //                   color: Color.fromARGB(
                    //                       255, 85, 70, 218), // shadow color
                    //                   offset: Offset(2.0,
                    //                       2.0), // how much shadow will be shown
                    //                 ),
                    //               ],
                    //               color: Color.fromARGB(255, 33, 189, 194),
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
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
          ],
        ),
      ),
    );
  }
}
