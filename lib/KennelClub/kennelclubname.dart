import 'dart:convert';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:inkc/KennelClub/addkennelname.dart';
import 'package:inkc/KennelClub/kennelnamehistory.dart';
import 'package:inkc/model/kennelNames/kennel_history.dart';
import 'package:inkc/model/kennelNames/kennel_second_owner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// class MyKennelClubName extends StatelessWidget {
//   const MyKennelClubName({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: const KennelClubName(),
//         );
//       },
//     );
//   }
// }

class KennelClubName extends StatefulWidget {
  const KennelClubName({super.key});

  @override
  State<KennelClubName> createState() => _KennelClubNameState();
}

class _KennelClubNameState extends State<KennelClubName> {
  List<KennelHistory> history = [];
  List<KennelSecondOwner> secondowner = [];

  var notsecondowneravailable;
  var nothistoryavailable;
  int i = 1;

  var kennel_name;
  var kennel_status;
  String? Certificare;

  bool _isSetStateCalled = false;
  bool _isSetKennelNameHistory = false;
  bool _onlyonetime = false;
  final bool _last = false;
  int j = 0;

  @override
  void initState() {
    super.initState();
    if (_onlyonetime == false) {
      FetchData();
    }

    insertvalue();
  }

  FetchData() async {
    print("first");

    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;
    print("$token- $userid");

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

    if (!_isSetStateCalled) {
      setState(() {
        // Your state changes here
        kennel_name = data['data']['kennel_info']['kennel_name'].toString();
        kennel_status = "1";
        Certificare = data['data']['kennel_info']['kennel_id'].toString();
        _onlyonetime = true;
      });
      _isSetStateCalled = true;
    }

    var historykennel = data['data']['kennel_history'];
    if (historykennel != 'false') {
      setState(() {
        _isSetKennelNameHistory = true;
        _onlyonetime = true;
      });
    }

    var message = data['message'];
    var code = data['code'];
    var status = data['status'];
    notsecondowneravailable = second;
    nothistoryavailable = historykennel;

    secondowner.clear();

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in second) {
        secondowner.add(KennelSecondOwner.fromJson(index));
      }

      return secondowner;
    } else {
      return secondowner;
    }
  }

  insertvalue() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String KennelName = sharedprefrence.getString("KennelName")!;
    //kennel_name = KennelName;
  }

  @override
  Widget build(BuildContext context) {
    // print(kennel_status.toString());
    //print("Doremon" + kennel_name.toString());

    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 223, 39, 39)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kennel Name Registration',
                  style: TextStyle(
                      fontSize: 15.sp,
                      decorationColor: Colors.red,
                      color: const Color.fromARGB(255, 17, 11, 7),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context, rootNavigator: true).push(
                //         MaterialPageRoute(builder: (_) => MyKennelNameHistory()));
                //   },
                //   child: Icon(
                //     Icons.holiday_village_outlined,
                //     color: Color.fromARGB(255, 24, 5, 235),
                //     size: 20.0.sp,
                //   ),
                // ),
              ],
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15, right: 15, bottom: 10),
            child: Column(
              children: [
                if (kennel_name.toString() == "null")
                  Center(
                    child: Text(
                      "No Kennel Name Available.",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.sp),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text(
                      //   "SN.",
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 14.sp),
                      // ),
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
                if (kennel_name.toString() == "null")
                  const Center(
                    child: Text(" "),
                  )
                else
                  Card(
                    // elevation: 5,
                    // color: Color.fromARGB(255, 255, 255, 255),
                    margin: EdgeInsets.all(3.sp),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text(
                            //   kennel_status.toString(),
                            //   style: TextStyle(
                            //       color: const Color.fromARGB(255, 94, 18, 18),
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 12.sp),
                            // ),
                            Text(
                              kennel_name.toString(),
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 95, 14, 14),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "Certificate",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 63, 2, 2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (_last == false)
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 25.0, left: 5, right: 15, bottom: 10),
                  //   child: Text(
                  //     "Second Owner Kennel Name ",
                  //     style: TextStyle(
                  //         color: const Color.fromARGB(255, 63, 2, 2),
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 12.sp),
                  //   ),
                  // ),
                  FutureBuilder(
                      future: FetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            itemCount: secondowner.length,
                            itemBuilder: (context, position) {
                              //print(secondowner.length.toString());
                              i++;
                              if (secondowner.length == j) {
                                //setState(() {
                                //_last = true;
                                //});
                              }

                              return Card(
                                // elevation: 5,
                                // color: Color.fromARGB(255, 255, 255, 255),
                                margin: EdgeInsets.all(3.sp),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Text(
                                        //   i.toString(),
                                        //   style: TextStyle(
                                        //       color: const Color.fromARGB(
                                        //           255, 94, 18, 18),
                                        //       fontWeight: FontWeight.w600,
                                        //       fontSize: 12.sp),
                                        // ),
                                        Text(
                                          secondowner[position]
                                              .kennelName
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
                            child: Text(""),
                          );
                        }
                      }),
              ],
            ),
          ),

          floatingActionButton: Visibility(
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 50, right: 8, left: 28),
                  child: DraggableFab(
                    child: FloatingActionButton.extended(
                      backgroundColor: const Color.fromARGB(255, 21, 49, 29),
                      foregroundColor: const Color.fromARGB(255, 247, 240, 240),
                      onPressed: () async {
                        // Navigator.of(context, rootNavigator: true).push(
                        //     MaterialPageRoute(builder: (_) => AddKennelName()));

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AddKennelName()));
                      },
                      label: Text(
                        'Add Kennel Name',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isSetKennelNameHistory,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50, right: 8),
                    child: DraggableFab(
                      child: FloatingActionButton.extended(
                        backgroundColor:
                            const Color.fromARGB(255, 231, 236, 233),
                        foregroundColor:
                            const Color.fromARGB(255, 247, 240, 240),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const KennelNameHistre()));
                          // Navigator.of(context, rootNavigator: true).push(
                          //     MaterialPageRoute(
                          //         builder: (_) => KennelNameHistre()));
                        },
                        label: Text(
                          'Kennel History',
                          style:
                              TextStyle(fontSize: 10.sp, color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.holiday_village_outlined,
                          color: Color.fromARGB(255, 24, 5, 235),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.of(context, rootNavigator: true)
          //         .push(MaterialPageRoute(builder: (_) => AddKennelName()));
          //   },
          //   child: Icon(Icons.add),
          // ),
        );
      }),
    );
  }
}
