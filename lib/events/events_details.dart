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
      Eventjudge;
  EventsDetails({
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
  });

  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  String vi = "";
  String From = "";
  String To = "";
  String Amount = "";

  // printed value
  String Froms = "";
  String tos = "";

  bool TrueCheck = false;
  bool judgenamechake = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (judgenamechake == false) {
      EventJudge();
      DogPrice();
    }
  }

  List Phonenumber = [];
  String judgename = "";

  EventJudge() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    print('${userid} / ${token}');

    final uri = "https://new-demo.inkcdogs.org/api/user/get_second_owner_id";

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

    print(value.toString());
  }

  DogPrice() {
    if (TrueCheck == false) {
      String number = widget.EventContactPerson.toString().replaceAll(", ", "");
      Phonenumber = number.split('<br>');

      String dogs = widget.EventDogPriceDiscound.toString()
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("\"", "")
          .replaceAll(":", "")
          .replaceAll(",,", ",");

      List kap = dogs.split(",");
      for (int i = 0; i < kap.length; i++) {
        if ("from" == kap[i]) {
          From = kap[i + 1];
        }
        if ("to" == kap[i]) {
          To = kap[i + 1];
        }
        if ("amount" == kap[i]) {
          Amount = kap[i + 1];
        }
      }

      setState(() {
        From = From;
        To = To;
        Amount = Amount;
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

        final from = DateTime.parse(From);
        final to = DateTime.parse(To);

        tos = "${to.day} ${months[to.month - 1].substring(0, 3)} ${to.year}";

        Froms =
            "  ${from.day} ${months[from.month - 1].substring(0, 3)} ${from.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.EventContactPerson.toString().replaceAll("<br>", ""));
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromARGB(255, 223, 39, 39)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Event Details',
                style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Color.fromARGB(255, 223, 71, 45), // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                    fontSize: 20.sp,
                    decorationColor: Colors.red,
                    color: Color.fromARGB(255, 194, 97, 33),
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
                          color: Color.fromARGB(255, 83, 2, 2),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.EventTime,
                      style: TextStyle(
                          color: Color.fromARGB(255, 134, 3, 3),
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
                          color: Color.fromARGB(255, 12, 12, 12),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.EventClossEntry,
                      style: TextStyle(
                          color: Color.fromARGB(255, 134, 6, 6),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              Divider(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 231, 25, 25),
                          textStyle: TextStyle(
                              fontSize: 10.sp,
                              color: const Color.fromARGB(255, 241, 236, 236),
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Participatent(
                                  eventid: widget.EventId,
                                  eventname: widget.EventStuff.toString() +
                                      " " +
                                      widget.EventName.toString(),
                                )));
                      },
                      child: Text(
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
                    boxShadow: [
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
                      image:
                          NetworkImage("https://new-demo.inkcdogs.org/${widget.EventImage}"),
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
              Divider(),

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
                        widget.EventName.toString() +
                            " : " +
                            widget.EventStartDate.toString(),
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: Color.fromARGB(255, 126, 3, 3),
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
                            color: Color.fromARGB(255, 8, 8, 8),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        judgename,
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
                        "ENTRIES CLOSE :   ",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Color.fromARGB(255, 17, 17, 17),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        widget.EventClossEntry.toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Color.fromARGB(255, 155, 6, 6),
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
                            color: Color.fromARGB(255, 7, 7, 7),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        widget.EventAddress.toString().replaceAll("<br>", "\n"),
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fill,
                      child: AutoSizeText(
                        "Entry fees:\n Regular Rs: " +
                            Amount.toString() +
                            "/-(from" +
                            Froms +
                            " to " +
                            tos +
                            ")",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color.fromARGB(255, 133, 13, 13),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Divider(),
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
                                color: Color.fromARGB(255, 7, 7, 7),
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
                                color: Color.fromARGB(255, 7, 7, 7),
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
                                color: Color.fromARGB(255, 7, 7, 7),
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

              Divider(),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'ORGANIZERS',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Divider(),
              for (int i = 0; i < Phonenumber.length; i++)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          //print(i.toString() + " - " + Phonenumber[i]);
                          List numer = Phonenumber[i].toString().split(':');
                          // print(numer[1]);
                          var url = Uri.parse("tel:" + numer[1].toString());
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: AutoSizeText(
                            Phonenumber[i].toString(),
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Color.fromARGB(255, 172, 4, 4),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              Divider(),
            ],
          ),
        ),
      );
    });
  }
}
