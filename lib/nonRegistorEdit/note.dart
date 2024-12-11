import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/model/notelistmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class NonRegisterNote extends StatefulWidget {
  String id = "";
  NonRegisterNote({super.key, required this.id});

  @override
  State<NonRegisterNote> createState() => _NonRegisterNoteState();
}

String userid = "";
String token = "";
String image = "";
String dateset = "";
int j = 0;

class _NonRegisterNoteState extends State<NonRegisterNote> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Check();
    FetchData();
  }

  Check() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("Token");
    }

  List<NoteList> dataload = [];

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              'Note',
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
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 5.sp),
            child: FutureBuilder(
                future: FetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    j++;
                    return ListView.builder(
                      itemCount: dataload.length,
                      itemBuilder: (context, position) {
                        List<String> months = [
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December'
                        ];

                        List<String> days = [
                          'Monday',
                          'Tuseday',
                          'Wednesday',
                          'Thursday',
                          'Friday',
                          'Saturday',
                          'Sunday',
                        ];

                        final dateTimeObj =
                            DateTime.parse(dataload[position].noteCreatedOn);

                        // date format
                        String fdate =
                            "${days[dateTimeObj.weekday - 1].substring(0, 3)}\n${months[dateTimeObj.month - 1].substring(0, 3)}-${dateTimeObj.day}";
                        // time format
                        dateset = fdate;
                        String time =
                            "${(dateTimeObj.hour > 12 ? dateTimeObj.hour - 12 : dateTimeObj.hour).abs()}:${dateTimeObj.minute} ${dateTimeObj.hour >= 12 ? "PM" : "AM"}";
                        // print("$fdate $time");
                                              return Card(
                          elevation: 10,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          margin: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            // decoration: const BoxDecoration(
                            //   image: DecorationImage(
                            //       image: NetworkImage(
                            //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReL_kSGg4Ux5ZiwK-mIRe6_L-Ft8GxRaaT1Q&usqp=CAU"),
                            //       fit: BoxFit.cover),
                            // ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     j.toString(),
                                //     style: TextStyle(
                                //       // color: Color.fromARGB(255, 17, 17, 17),
                                //       fontSize: 12.sp,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  // height: 50.sp,
                                  // width: 180.sp,
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dataload[position].noteMessage,
                                        style: TextStyle(
                                          // color: Color.fromARGB(255, 17, 17, 17),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(18),
                                  child: Text(
                                    dateset,
                                    style: TextStyle(
                                      // color: Color.fromARGB(255, 17, 17, 17),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: Text(
                                //     dateset,
                                //     style: TextStyle(
                                //       // color: Color.fromARGB(255, 17, 17, 17),
                                //       fontSize: 12.sp,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: Expanded(
                                //     flex: 1,
                                //     child: Text(
                                //         maxLines: null,
                                //         dataload[position].noteMessage,
                                //         style: TextStyle(
                                //             fontSize: 12.sp,
                                //             fontWeight: FontWeight.bold)),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (dataload.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30, left: 20),
                            height: 170.0.sp,
                            width: 170.0.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              //set border radius to 50% of square height and width
                              image: const DecorationImage(
                                image: AssetImage("assets/dogs.png"),
                                fit: BoxFit.cover, //change image fill type
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Sorry Data is empty",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            backgroundColor: Colors.green,
            onPressed: () {
              setState(() {
                EditSlide(context);
              });
            },
            // isExtended: true,
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  Future<List<NoteList>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri = "https://new-demo.inkcdogs.org/api/dog/note_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    String boy = widget.id;

    final responce = await http.post(
      Uri.parse(uri),
      body: {"note_pet_id": boy.toString()},
      headers: requestHeaders,
    );
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    dataload.clear();

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(NoteList.fromJson(index));
      }
      return dataload;
    } else {
      return dataload;
    }
  }

  void EditSlide(BuildContext context) {
    TextEditingController note = TextEditingController();

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   gradient: LinearGradient(
            //     colors: [
            //       Color.fromARGB(255, 231, 164, 164),
            //       Color.fromARGB(255, 185, 199, 247),
            //     ],
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //   ),
            // ),
            margin: EdgeInsets.all(10.sp),
            height: MediaQuery.of(context).size.height * .600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Add Note',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: const Color.fromARGB(255, 255, 3, 3)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    maxLines: null,
                    controller: note,
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                        borderSide: const BorderSide(width: 1, color: Colors.green),
                      ),
                      labelText: 'Note',
                      hintText: '',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 20.sp, left: 20.sp, right: 20, bottom: 0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(40), // NEW
                        ),
                        onPressed: () async {
                          String Notes = note.text;

                          EasyLoading.showToast('Please Wait...');

                          const uri = "https://new-demo.inkcdogs.org/api/dog/add_note";

                          Map<String, String> requestHeaders = {
                            'Accept': 'application/json',
                            'Usertoken': token,
                            'Userid': userid
                          };

                          final responce = await http.post(
                            Uri.parse(uri),
                            headers: requestHeaders,
                            body: {
                              "note_pet_id": widget.id,
                              "note_message": Notes
                            },
                          );
                          var data = json.decode(responce.body);

                          if (data['code'] == 200) {
                            EasyLoading.dismiss();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NonRegisterNote(id: widget.id)),
                              (Route<dynamic> route) => false,
                            );

                            // Navigator.of(context, rootNavigator: true).push(
                            //     MaterialPageRoute(builder: (_) => MyApp()));
                          } else {
                            Navigator.pop(context);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text: 'Note is can not empty',
                            );
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NonRegisterNote(id: widget.id)),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'Add Note',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
