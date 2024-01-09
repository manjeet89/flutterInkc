import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/model/notificationmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       child: Text("Notification"),
//     );
//   }
// }

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

String userid = "";
String token = "";
String image = "";

String dateset = "";

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Check();
    //FetchData();
  }

  var ifDataisnotavailavle;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose works");
  }

  Check() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("Token");
    if (check != null) {
      print("object with not back");
    } else {
      setState(() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => Login()));
      });
    }
  }

  List<NotificationModel> dataload = [];

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Notifications',
            style: TextStyle(
                shadows: [
                  Shadow(
                    blurRadius: 10.0, // shadow blur
                    color: Color.fromARGB(255, 223, 71, 45), // shadow color
                    offset: Offset(2.0, 2.0), // how much shadow will be shown
                  ),
                ],
                fontSize: 20.sp,
                decorationColor: Colors.red,
                color: Color.fromARGB(255, 194, 97, 33),
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
                if (ifDataisnotavailavle.toString() == "False")
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No Data",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 177, 43, 10),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: dataload.length,
                    itemBuilder: (context, position) {
                      if (dataload[position].notiCreatedOn != null) {
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
                            DateTime.parse(dataload[position].notiCreatedOn);

                        // date format
                        String fdate =
                            "${days[dateTimeObj.weekday - 1].substring(0, 3)}, ${months[dateTimeObj.month - 1].substring(0, 3)}-${dateTimeObj.day}";
                        // time format
                        dateset = fdate;
                        String time =
                            "${(dateTimeObj.hour > 12 ? dateTimeObj.hour - 12 : dateTimeObj.hour).abs()}:${dateTimeObj.minute} ${dateTimeObj.hour >= 12 ? "PM" : "AM"}";
                        print("$fdate $time");
                      } else {
                        navigator?.pop(context);
                      }
                      return Card(
                        elevation: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                        margin: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  dateset,
                                  style: TextStyle(
                                    // color: Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = ui.Gradient.linear(
                                        const Offset(100, 140),
                                        const Offset(150, 20),
                                        <Color>[
                                          Color.fromARGB(255, 235, 15, 15),
                                          Color.fromARGB(255, 22, 26, 226),
                                        ],
                                      ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  dataload[position].notiMessage,
                                  style: TextStyle(
                                      foreground: Paint()
                                        ..shader = ui.Gradient.linear(
                                          const Offset(50, 100),
                                          const Offset(150, 20),
                                          <Color>[
                                            Color.fromARGB(255, 235, 15, 15),
                                            Color.fromARGB(255, 22, 26, 226),
                                          ],
                                        ),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      );
    });
  }

  Future<List<NotificationModel>> FetchData() async {
    print("market");
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    print('${userid} / ${token}');

    final uri = "https://new-demo.inkcdogs.org/api/notifications";

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    var dataarray = data['data']['noti_record'];
    print(dataarray.toString());

    if (dataarray.toString() == "false") {
      ifDataisnotavailavle = 'False';
      // print("bats");
    }

    dataload.clear();
    if (data['code'] == 200) {
      if (responce.statusCode == 200) {
        for (Map<String, dynamic> index in dataarray) {
          dataload.add(NotificationModel.fromJson(index));
        }
        return dataload;
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => Login()));
        return dataload;
      }
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => Login()));
      return dataload;
    }
  }
}
