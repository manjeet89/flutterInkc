import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkc/events/participate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class EventsDetails extends StatefulWidget {
  String EventId,
      EventNumber,
      EventStuff,
      EventName,
      EventSlug,
      EventImage,
      EventDogPriceDiscound,
      EventAddress,
      EventLocation,
      EventContactPerson,
      EventStartDate,
      EventEndDate,
      EventClossEntry,
      EventTime,
      Eventjudge,
      EventType,
      Eventstall,
      event_stall;

  EventsDetails({
    super.key,
    required this.EventId,
    required this.EventNumber,
    required this.EventStuff,
    required this.EventName,
    required this.EventSlug,
    required this.EventImage,
    required this.EventDogPriceDiscound,
    required this.EventAddress,
    required this.EventLocation,
    required this.EventContactPerson,
    required this.EventStartDate,
    required this.EventEndDate,
    required this.EventClossEntry,
    required this.EventTime,
    required this.Eventjudge,
    required this.EventType,
    required this.Eventstall,
    required this.event_stall,
  });

  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  String vi = "";
  String From = "";
  String To = "";
  String Amount = "";

  String faltu = "";

  // printed value
  String Froms = "";
  String tos = "";

  String Earlyfromdate = "";
  String Earlytodate = "";
  String Earlyprice = "";

  String Regularfromdate = "";
  String Regulartodate = "";
  String Regularprice = "";

  String Latefromdate = "";
  String Latetodate = "";
  String Lateprice = "";

  bool Early = false;
  bool Regular = false;
  bool Late = false;

  String ACfirstday = "";
  String ACsecondday = "";
  String Fanfirstday = "";
  String Fanseconday = "";

  bool stalday = false;
  bool stalpage = false;
  bool hidestal = false;

  bool TrueCheck = false;
  bool judgenamechake = false;

  // new try for Event venue
  String hidedataEarly = "";
  String hidedataRegular = "";
  String hidedataLate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DogPrice();
    StallDay();
    // if (judgenamechake == false) {
    //   //EventJudge();
    // }
  }

  List Phonenumber = [];
  String judgename = "";

  StallDay() async {
    if (stalday == false) {
      if (widget.Eventstall.toString() == "null") {
        setState(() {
          hidestal = false;
        });
      } else {
        List kap = widget.Eventstall.toString().split(",");
        for (int i = 0; i < kap.length; i++) {
          if (i == 0) {
            ACfirstday = kap[i];
          }
          if (i == 1) {
            ACsecondday = kap[i];
          }
          if (i == 2) {
            Fanfirstday = kap[i];
          }
          if (i == 3) {
            Fanseconday = kap[i];
          }
        }
        setState(() {
          hidestal = true;

          ACfirstday = ACfirstday;
          ACsecondday = ACsecondday;
          Fanfirstday = Fanfirstday;
          Fanseconday = Fanseconday;
        });
      }
    }
  }

  EventJudge() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    print('$userid / $token');

    const uri = "https://new-demo.inkcdogs.org/api/user/get_second_owner_id";

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Userid': userid,
      'Usertoken': token,
    };

    final responce =
        await http.post(Uri.parse(uri), headers: requestHeaders, body: {
      'second_owner_id': widget.Eventjudge.toString(),
    });
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    String value = dataarray.toString().replaceAll("Owner Details :", "");

    setState(() {
      judgename = value;
      judgenamechake = true;
    });

    // print(value.toString());
  }

  DogPrice() {
    // print(widget.Eventstall.toString());

    if (TrueCheck == false) {
      String number = widget.EventContactPerson.toString()
          .replaceAll(", ", "")
          .replaceAll('<b>', "")
          .replaceAll('</b>', "")
          .replaceAll('</b>', "")
          .replaceAll('</a>', "")
          .replaceAll("\"", "")
          // .replaceAll(">", "")
          .replaceAll("<a href=tel:+", "");

      Phonenumber = number.split('<br>');
      // for (int i = 0; i < Phonenumber.length - 1; i++) {
      //   // print(Phonenumber[i].toString().substring(15).trim() +
      //   // "  " +
      //   // i.toString());
      //   if (i >= 1) {
      //     print(Phonenumber[i].toString().substring(15) + "  " + i.toString());
      //   } else {
      //     print(Phonenumber[i].toString().substring(13) + "  " + i.toString());
      //   }
      // }
      String dogs = widget.EventDogPriceDiscound.toString()
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAll("[", "")
          .replaceAll("]", ":")
          .replaceAll('""', "data")
          .replaceAll(":", ",")
          .replaceAll("\"", "")
          .replaceAll(",,", ",")
          .trim();

      // print("bakri" + dogs.toString());

      List kap = dogs.split(",");
      print("bakri   ${dogs}find length     ${kap.length}");

      for (int k = 0; k < kap.length - 1; k++) {
        // print("check datas " + kap[k].toString() + "   " + k.toString() + "\n");

        if (1 == k) {
          if ("data" == kap[k] && 1 == k) {
            hidedataEarly = "hireEarly";
            print("is work or not");
          } else {
            hidedataEarly = "showEarly";
            Earlyfromdate = kap[k];
          }
        }

        if (2 == k) {
          if ("data" == kap[k] && 2 == k) {
            hidedataRegular = "hireRegular";
          } else {
            // print("is work or just chill");
            hidedataRegular = "showRegular";
            Regularfromdate = kap[k];
          }
        }

        if (3 == k) {
          if ("data" == kap[k] && 3 == k) {
            hidedataLate = "hireLate";
          } else {
            hidedataLate = "showLate";
            Latefromdate = kap[k];
          }
        }

        if (5 == k) {
          if ("data" == kap[k] && 5 == k) {
            hidedataEarly = "hireEarly";
          } else {
            hidedataEarly = "showEarly";
            Earlytodate = kap[k];
          }
        }

        if (6 == k) {
          if ("data" == kap[k] && 6 == k) {
            hidedataRegular = "hireRegular";
          } else {
            hidedataRegular = "showRegular";
            Regulartodate = kap[k];
          }
        }

        if (7 == k) {
          if ("data" == kap[k] && 7 == k) {
            hidedataLate = "hireLate";
          } else {
            hidedataLate = "showLate";
            Latetodate = kap[k];
          }
        }

        if ("amount" == kap[k]) {
          Earlyprice = kap[k + 1];
          //Regularprice = kap[i + 2];
          // Lateprice = kap[i + 3];
        }
        if (10 == k) {
          Regularprice = kap[k];
        }
        if (11 == k) {
          Lateprice = kap[k];
        }
      }

      setState(() {
        // Early = true;
        // Regular = true;
        // Late = true;

        // Earlyfromdate = Earlyfromdate; //"2024-01-01";
        // // From;
        // Earlytodate = Earlytodate;
        // //"2024-03-31"; //To;
        Earlyprice = Earlyprice;
        Regularprice = Regularprice;
        Lateprice = Lateprice;
        TrueCheck = true;

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

        if (hidedataEarly == "showEarly") {
          Early = true;

          final Earlyfrom = DateTime.parse(Earlyfromdate);
          final Earlyto = DateTime.parse(Earlytodate);

          Earlytodate =
              "${Earlyto.day} ${months[Earlyto.month - 1].substring(0, 3)} ${Earlyto.year}";

          Earlyfromdate =
              "  ${Earlyfrom.day} ${months[Earlyfrom.month - 1].substring(0, 3)} ${Earlyfrom.year}";
        }

        if (hidedataRegular == "showRegular") {
          Regular = true;
          final Regularfrom = DateTime.parse(Regularfromdate);
          final Regularto = DateTime.parse(Regulartodate);

          Regulartodate =
              "${Regularto.day} ${months[Regularto.month - 1].substring(0, 3)} ${Regularto.year}";

          Regularfromdate =
              "  ${Regularfrom.day} ${months[Regularfrom.month - 1].substring(0, 3)} ${Regularfrom.year}";
        }

        if (hidedataLate == "showLate") {
          Late = true;
          final Latefrom = DateTime.parse(Latefromdate);
          final Lateto = DateTime.parse(Latetodate);

          Latetodate =
              "${Lateto.day} ${months[Lateto.month - 1].substring(0, 3)} ${Lateto.year}";

          Latefromdate =
              "  ${Latefrom.day} ${months[Latefrom.month - 1].substring(0, 3)} ${Latefrom.year}";
          // print("boofat");
        }
      });

      // print(widget.EventDogPriceDiscound.toString() +
      //     "media" +
      //     kap.length.toString());

      // if (kap.length - 1 == 16) {
      //   print("media take from early " + kap.length.toString());

      //   for (int i = 0; i < kap.length - 1; i++) {
      //     if ("from" == kap[i]) {
      //       Earlyfromdate = kap[i + 1];
      //       // Regularfromdate = kap[i + 2];
      //       // Latefromdate = kap[i + 3];
      //     }
      //     if (2 == i) {
      //       // print(kap[i]);
      //       Regularfromdate = kap[i];
      //     }
      //     if (3 == i) {
      //       Latefromdate = kap[i];
      //     }

      //     if ("to" == kap[i]) {
      //       Earlytodate = kap[i + 1];
      //       // Regulartodate = kap[i + 2];
      //       // Latetodate = kap[i + 3];
      //     }
      //     if (6 == i) {
      //       Regulartodate = kap[i];
      //     }
      //     if (7 == i) {
      //       Latetodate = kap[i];
      //     }

      //     if ("amount" == kap[i]) {
      //       Earlyprice = kap[i + 1];
      //       //Regularprice = kap[i + 2];
      //       // Lateprice = kap[i + 3];
      //     }
      //     if (10 == i) {
      //       Regularprice = kap[i];
      //     }
      //     if (11 == i) {
      //       Lateprice = kap[i];
      //     }
      //   }

      //   setState(() {
      //     Early = true;
      //     Regular = true;
      //     Late = true;
      //     Earlyfromdate = Earlyfromdate; //"2024-01-01";
      //     // From;
      //     Earlytodate = Earlytodate;
      //     //"2024-03-31"; //To;
      //     Earlyprice = Earlyprice;
      //     Regularprice = Regularprice;
      //     Lateprice = Lateprice;
      //     TrueCheck = true;

      //     List<String> months = [
      //       'January',
      //       'February',
      //       'March',
      //       'April',
      //       'May',
      //       'June',
      //       'July',
      //       'August',
      //       'September',
      //       'October',
      //       'November',
      //       'December'
      //     ];

      //     List<String> days = [
      //       'Monday',
      //       'Tuseday',
      //       'Wednesday',
      //       'Thursday',
      //       'Friday',
      //       'Saturday',
      //       'Sunday',
      //     ];

      //     final Earlyfrom = DateTime.parse(Earlyfromdate);
      //     final Earlyto = DateTime.parse(Earlytodate);

      //     Earlytodate =
      //         "${Earlyto.day} ${months[Earlyto.month - 1].substring(0, 3)} ${Earlyto.year}";

      //     Earlyfromdate =
      //         "  ${Earlyfrom.day} ${months[Earlyfrom.month - 1].substring(0, 3)} ${Earlyfrom.year}";

      //     final Regularfrom = DateTime.parse(Regularfromdate);
      //     final Regularto = DateTime.parse(Regulartodate);

      //     Regulartodate =
      //         "${Regularto.day} ${months[Regularto.month - 1].substring(0, 3)} ${Regularto.year}";

      //     Regularfromdate =
      //         "  ${Regularfrom.day} ${months[Regularfrom.month - 1].substring(0, 3)} ${Regularfrom.year}";
      //     final Latefrom = DateTime.parse(Latefromdate);
      //     final Lateto = DateTime.parse(Latetodate);

      //     Latetodate =
      //         "${Lateto.day} ${months[Lateto.month - 1].substring(0, 3)} ${Lateto.year}";

      //     Latefromdate =
      //         "  ${Latefrom.day} ${months[Latefrom.month - 1].substring(0, 3)} ${Latefrom.year}";
      //     // print("boofat");
      //   });
      // } else if (kap.length - 1 == 12) {
      //   print("media take from Regular " + kap.length.toString());

      //   for (int i = 0; i < kap.length - 1; i++) {
      //     // print("biwi  " + kap[i]);
      //     if ("from" == kap[i]) {
      //       Regularfromdate = kap[i + 1];
      //       // Regularfromdate = kap[i + 2];
      //       // Latefromdate = kap[i + 3];
      //     }
      //     if (2 == i) {
      //       Latefromdate = kap[i];
      //     }

      //     if ("to" == kap[i]) {
      //       // Earlytodate = kap[i + 1];
      //       Regulartodate = kap[i + 1];
      //       // Latetodate = kap[i + 3];
      //     }
      //     if (5 == i) {
      //       Latetodate = kap[i];
      //     }

      //     if ("amount" == kap[i]) {
      //       Regularprice = kap[i + 1];
      //       //Regularprice = kap[i + 2];
      //       // Lateprice = kap[i + 3];
      //     }
      //     if (8 == i) {
      //       Lateprice = kap[i];
      //     }
      //     // if (11 == i) {
      //     //   Lateprice = kap[i];
      //     // }
      //   }

      //   setState(() {
      //     // Early = true;
      //     Regular = true;
      //     Late = true;
      //     Regularprice = Regularprice;
      //     Lateprice = Lateprice;
      //     TrueCheck = true;

      //     List<String> months = [
      //       'January',
      //       'February',
      //       'March',
      //       'April',
      //       'May',
      //       'June',
      //       'July',
      //       'August',
      //       'September',
      //       'October',
      //       'November',
      //       'December'
      //     ];

      //     List<String> days = [
      //       'Monday',
      //       'Tuseday',
      //       'Wednesday',
      //       'Thursday',
      //       'Friday',
      //       'Saturday',
      //       'Sunday',
      //     ];

      //     final Regularfrom = DateTime.parse(Regularfromdate);
      //     final Regularto = DateTime.parse(Regulartodate);

      //     Regulartodate =
      //         "${Regularto.day} ${months[Regularto.month - 1].substring(0, 3)} ${Regularto.year}";

      //     Regularfromdate =
      //         "  ${Regularfrom.day} ${months[Regularfrom.month - 1].substring(0, 3)} ${Regularfrom.year}";
      //     final Latefrom = DateTime.parse(Latefromdate);
      //     final Lateto = DateTime.parse(Latetodate);

      //     Latetodate =
      //         "${Lateto.day} ${months[Lateto.month - 1].substring(0, 3)} ${Lateto.year}";

      //     Latefromdate =
      //         "  ${Latefrom.day} ${months[Latefrom.month - 1].substring(0, 3)} ${Latefrom.year}";
      //     // print("boofat");
      //   });
      // } else {
      //   for (int i = 0; i < kap.length - 1; i++) {
      //     print("media take from late " + kap.length.toString());

      //     // print(kap[i].toString());
      //     if ("from" == kap[i]) {
      //       Latefromdate = kap[i + 1];
      //     }
      //     if ("to" == kap[i]) {
      //       Latetodate = kap[i + 1];
      //     }
      //     if ("amount" == kap[i]) {
      //       Lateprice = kap[i + 1];
      //     }
      //   }

      //   setState(() {
      //     //Early = true;
      //     Regular = true;
      //     Late = true;
      //     Lateprice = Lateprice;
      //     TrueCheck = true;

      //     List<String> months = [
      //       'January',
      //       'February',
      //       'March',
      //       'April',
      //       'May',
      //       'June',
      //       'July',
      //       'August',
      //       'September',
      //       'October',
      //       'November',
      //       'December'
      //     ];

      //     List<String> days = [
      //       'Monday',
      //       'Tuseday',
      //       'Wednesday',
      //       'Thursday',
      //       'Friday',
      //       'Saturday',
      //       'Sunday',
      //     ];
      //     final Latefrom = DateTime.parse(Latefromdate);
      //     final Lateto = DateTime.parse(Latetodate);

      //     Latetodate =
      //         "${Lateto.day} ${months[Lateto.month - 1].substring(0, 3)} ${Lateto.year}";

      //     Latefromdate =
      //         "  ${Latefrom.day} ${months[Latefrom.month - 1].substring(0, 3)} ${Latefrom.year}";
      //     print("boofat");
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.EventClossEntry);
    // print(widget.EventContactPerson.toString().replaceAll("<br>", ""));
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
            // leading: IconButton(
            //   icon:
            //       Icon(Icons.arrow_back, color: Color.fromARGB(255, 223, 39, 39)),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Event Details',
                  style: TextStyle(
                      shadows: const [ 
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color:
                              Color.fromARGB(255, 223, 71, 45), // shadow color
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
              ],
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          // widget.EventStuff.toString() +
                          //     " " +
                          widget.EventName.toString(),
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.EventStartDate,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 83, 2, 2),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.EventTime,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 134, 3, 3),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ENTRIES CLOSE : ",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 12, 12, 12),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.EventClossEntry,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 134, 6, 6),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 231, 25, 25),
                            textStyle: TextStyle(
                                fontSize: 10.sp,
                                color: const Color.fromARGB(255, 241, 236, 236),
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          SharedPreferences sharedprefrence =
                              await SharedPreferences.getInstance();
                          String? check = sharedprefrence.getString("Token");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Participatent(
                                    eventid: widget.EventId,
                                    eventname:
                                        "${widget.EventStuff} ${widget.EventName}",
                                    eventType: widget.EventType,
                                    eventstall: widget.event_stall,
                                  )));
                        },
                        child: const Text(
                          'Enter in this show',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    height: 250.0.sp,
                    width: 250.0.sp,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 179, 168, 206),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                            5,
                            5,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5.sp),
                      //set border radius to 50% of square height and width
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://new-demo.inkcdogs.org/${widget.EventImage}"),
                        fit: BoxFit.cover, //change image fill type
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(8.sp),
                //   child: Text(
                //     "Events",
                //     style: TextStyle(fontSize: 22.sp),
                //   ),
                // ),
                const Divider(),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          // widget.EventStuff.toString() +
                          //     " " +
                          widget.EventName.toString(),
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          maxLines: 2,
                          // widget.EventStuff.toString() +
                          //     " " +
                          "${widget.EventName} : ${widget.EventStartDate}",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: const Color.fromARGB(255, 126, 3, 3),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          "Judges :              ",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color.fromARGB(255, 8, 8, 8),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (widget.Eventjudge.toString() == "null")
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: AutoSizeText(
                                "To Be Announced Soon",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        const Color.fromARGB(255, 133, 13, 13),
                                    fontWeight: FontWeight.w600),
                                maxLines:
                                    6, // Adjust the maximum number of lines as needed
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: AutoSizeText(
                                widget.Eventjudge.toString(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        const Color.fromARGB(255, 133, 13, 13),
                                    fontWeight: FontWeight.w600),
                                maxLines:
                                    6, // Adjust the maximum number of lines as needed
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      // Container(
                      //   width: 150.sp,
                      //   child: FittedBox(
                      //     fit: BoxFit.contain,
                      //     child: AutoSizeText(
                      //       judgename,
                      //       style: TextStyle(
                      //           fontSize: 13.sp,
                      //           color: const Color.fromARGB(255, 133, 13, 13),
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          "ENTRIES CLOSE :   ",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromARGB(255, 17, 17, 17),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          widget.EventClossEntry.toString(),
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color.fromARGB(255, 155, 6, 6),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          "Venue :                  ",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color.fromARGB(255, 7, 7, 7),
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: AutoSizeText(
                              widget.EventAddress.toString()
                                  .replaceAll("<br>", " "),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 133, 13, 13),
                                  fontWeight: FontWeight.w600),
                              maxLines:
                                  6, // Adjust the maximum number of lines as needed
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 170.sp,
                      //   // height: 100.sp,
                      //   child: FittedBox(
                      //     fit: BoxFit.contain,
                      //     child: AutoSizeText(
                      //       widget.EventAddress.toString()
                      //           .replaceAll("<br>", " "),
                      //       style: TextStyle(
                      //           fontSize: 13.sp,
                      //           color: const Color.fromARGB(255, 133, 13, 13),
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fill,
                        child: AutoSizeText(
                          "Entry fees :",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color.fromARGB(255, 22, 5, 5),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: Early,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: AutoSizeText(
                            "Early Rs: $Earlyprice/-(from$Earlyfromdate to $Earlytodate)",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color.fromARGB(255, 133, 13, 13),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: Regular,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: AutoSizeText(
                            "Regular Entries Rs.$Regularprice/-(from $Regularfromdate to $Regulartodate)",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color.fromARGB(255, 133, 13, 13),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: Late,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: AutoSizeText(
                            "Late Entries Rs.$Lateprice/-(from $Latefromdate to $Latetodate)",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color.fromARGB(255, 133, 13, 13),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: hidestal,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: AutoSizeText(
                            "Optional Dog Benching (Stall fees): \n Cooler Stall 1 Day Charges Rs. $ACfirstday/- \n FAN Stall 1 Day Charges Rs.$ACsecondday/- \n Cooler Stall 2 Day Charges Rs. $Fanfirstday/- \n  FAN Stall 2 Day Charges Rs.$Fanseconday",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color.fromARGB(255, 133, 13, 13),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              "Date :         ",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              widget.EventStartDate.toString(),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 133, 13, 13),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              "Time :         ",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              widget.EventTime.toString(),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 133, 13, 13),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              "Location :    ",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              widget.EventLocation.toString(),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 133, 13, 13),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Divider(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'ORGANIZERS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const Divider(),

                for (int i = 0; i < Phonenumber.length - 1; i++)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (i >= 1)
                          InkWell(
                            onTap: () async {
                              print("$i - ${Phonenumber[i]}");

                              faltu = Phonenumber[i].toString();
                              faltu = faltu.replaceRange(0, 15, "");
                              List numer = Phonenumber[i].toString().split(':');
                              print(numer[0] + "-" + faltu);
                              var url = Uri.parse("tel:$faltu");

                              // numer[0].toString());
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },

                            child: AutoSizeText(
                              Phonenumber[i].toString().substring(15),
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color.fromARGB(255, 172, 4, 4),
                                  fontWeight: FontWeight.w600),
                            ),

                            //     FittedBox(
                            //   fit: BoxFit.cover,
                            //   child: AutoSizeText(
                            //     Phonenumber[i].toString(),
                            //     style: TextStyle(
                            //         fontSize: 14.sp,
                            //         color: Color.fromARGB(255, 172, 4, 4),
                            //         fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                          )
                        else
                          InkWell(
                            onTap: () async {
                              print("$i - ${Phonenumber[i]}");

                              faltu = Phonenumber[i].toString();
                              faltu = faltu.replaceRange(0, 13, "");
                              List numer = Phonenumber[i].toString().split(':');
                              print(numer[0] + "-" + faltu);
                              var url = Uri.parse("tel:$faltu");

                              // numer[0].toString());
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },

                            child: AutoSizeText(
                              Phonenumber[i].toString().substring(13),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color.fromARGB(255, 172, 4, 4),
                                  fontWeight: FontWeight.w600),
                            ),

                            //     FittedBox(
                            //   fit: BoxFit.cover,
                            //   child: AutoSizeText(
                            //     Phonenumber[i].toString(),
                            //     style: TextStyle(
                            //         fontSize: 14.sp,
                            //         color: Color.fromARGB(255, 172, 4, 4),
                            //         fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                          )
                      ],
                    ),
                  ),

                const Divider(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
