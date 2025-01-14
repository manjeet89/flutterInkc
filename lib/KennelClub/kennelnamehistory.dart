import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkc/model/kennelNames/kennel_history.dart';
import 'package:inkc/model/kennelNames/kennel_second_owner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// class MyKennelNameHistory extends StatelessWidget {
//   const MyKennelNameHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: const KennelNameHistre(),
//         );
//       },
//     );
//   }
// }

class KennelNameHistre extends StatefulWidget {
  const KennelNameHistre({super.key});

  @override
  State<KennelNameHistre> createState() => _KennelNameHistreState();
}

class _KennelNameHistreState extends State<KennelNameHistre> {
  @override
  void initState() {
    super.initState();
    FetchData();
  }

  List<KennelHistory> history = [];
  List<KennelSecondOwner> secondowner = [];

  var notsecondowneravailable;
  var nothistoryavailable;
  int i = 0;
  String ifDataisnotavailavle = 'FalseData';
  late bool texthide = true;

  FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/user/kennel_details";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
    );
    var data = json.decode(responce.body);
    var second = data['data']['kennel_second_owner'];
    var historykennel = data['data']['kennel_history'];
    var message = data['message'];
    var code = data['code'];
    var status = data['status'];
    notsecondowneravailable = second;
    nothistoryavailable = historykennel;

    if (historykennel == false) {
      ifDataisnotavailavle = 'False';
      setState(() {
        texthide = false;
      });
    }

    history.clear();

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in historykennel) {
        history.add(KennelHistory.fromJson(index));
      }
      return history;
    } else {
      return history;
    }

    // if (responce.statusCode == 200) {
    //   for (Map<String, dynamic> index in second) {
    //     secondowner.add(KennelSecondOwner.fromJson(index));
    //   }

    //   return secondowner;
    // } else {
    //   return secondowner;
    // }
    // if (second == false && historykennel == false) {
    //   return Scaffold(body: Center(child: Text('No Kennel Name')));
    // } else if (second == false) {
    //   if (responce.statusCode == 200) {
    //     for (Map<String, dynamic> index in historykennel) {
    //       history.add(KennelHistory.fromJson(index));
    //     }
    //     return history;
    //   } else {
    //     return history;
    //   }
    // } else {
    //   if (responce.statusCode == 200) {
    //     for (Map<String, dynamic> index in second) {
    //       secondowner.add(KennelSecondOwner.fromJson(index));
    //     }
    //     return secondowner;
    //   } else {
    //     return secondowner;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (notsecondowneravailable == "false") {
      return const Scaffold(
        body: Center(child: Text('Nothing')),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          // Handle Android hardware back button press
          Navigator.pop(context);
          return false; // Prevent default behavior
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back,
            //       color: Color.fromARGB(255, 32, 22, 22)),
            //   onPressed: () => Navigator.of(context, rootNavigator: true)
            //       .push(MaterialPageRoute(builder: (_) => KennelClubName())),
            // ),
            title: Text(
              'Kennel Name history ',
              style: TextStyle(
                  fontSize: 18.sp,
                  decorationColor: Colors.red,
                  color: const Color.fromARGB(255, 17, 11, 7),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15, right: 15, bottom: 10),
            child: Column(
              children: [
                Visibility(
                  visible: texthide,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SN.",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      Text(
                        "Kennel Name.",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      Text(
                        "Action.",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: FetchData(),
                    builder: (context, snapshot) {
                      if (ifDataisnotavailavle == 'False') {
                        // setState(() {
                        //   texthide = false;
                        // });
                        return Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 100.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "You don't have History.",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 177, 43, 10),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: InkWell(
                                //     child: ElevatedButton(
                                //         onPressed: () {
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) => INKCStore()),
                                //           );
                                //         },
                                //         child: Text('Go to INKC Store')),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          itemCount: history.length,
                          itemBuilder: (context, position) {
                            i++;
                            return Card(
                              // elevation: 5,
                              // color: Color.fromARGB(255, 255, 255, 255),
                              margin: EdgeInsets.all(3.sp),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        i.toString(),
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 94, 18, 18),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                      Text(
                                        history[position]
                                            .kennelClubName
                                            .toString(),
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 95, 14, 14),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                      Text(
                                        "Certificate",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 63, 2, 2),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                  // constraints: BoxConstraints.tightFor(),

                                  // decoration: BoxDecoration(
                                  //   boxShadow: [
                                  //     BoxShadow(
                                  //       blurRadius: 7,
                                  //       offset: Offset(
                                  //         5,
                                  //         5,
                                  //       ),
                                  //     )
                                  //   ],
                                  //   border: Border.all(
                                  //     color: Colors.black,
                                  //     width: 0.3,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   color: Colors.white,
                                  // ),
                                  // margin: EdgeInsets.all(5),
                                  // child: Text(
                                  //     history[position].kennelClubName.toString()),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }
}
