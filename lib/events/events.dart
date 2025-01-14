import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:inkc/credential/login.dart';
import 'package:inkc/events/eventsModel.dart';
import 'package:inkc/events/events_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<EventsModel> dataload = [];
  var ifDataisnotavailavle;
  String dateset = "";
  String close = "";

  Future<List<EventsModel>> FetchData() async {
    const uri = "https://new-demo.inkcdogs.org/api/home/event";

    final responce = await http.post(Uri.parse(uri));
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    //print(data['data']);

    if (data['data'].toString() == "false") {
      // setState(() {

      // });
      ifDataisnotavailavle = "False";
      //print("pachas lakh");
    }

    dataload.clear();
    if (data['code'] == 200) {
      if (responce.statusCode == 200) {
        for (Map<String, dynamic> index in dataarray) {
          dataload.add(EventsModel.fromJson(index));
        }
        return dataload;
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const Login()));
        return dataload;
      }
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const Login()));
      return dataload;
    }
  }

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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Events',
                    style: TextStyle(
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0, // shadow blur
                            color: Color.fromARGB(
                                255, 223, 71, 45), // shadow color
                            offset: Offset(
                                2.0, 2.0), // how much shadow will be shown
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
            body: FutureBuilder(
                future: FetchData(),
                builder: (context, snapshot) {
                  // print(ifDataisnotavailavle + "banda");
                  if (ifDataisnotavailavle.toString() == 'False') {
                    //print(ifDataisnotavailavle + "des");
                    return Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No Events.",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 177, 43, 10),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: dataload.length,
                      itemBuilder: (context, position) {
                        // print(dataload[position].eventContactPerson.toString());

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

                        final dateTimeObj = DateTime.parse(
                            dataload[position].eventStartDateTime.toString());

                        final enddateTimeObj = DateTime.parse(
                            dataload[position].eventEndDateTime.toString());

                        final closeEvents = DateTime.parse(
                            dataload[position].eventEntryClosedOn.toString());

                        // print("Inteme" +
                        //     dataload[position].eventEntryClosedOn.toString());

                        String closedate =
                            "${closeEvents.day}  ${months[closeEvents.month - 1].substring(0, 3)} ${closeEvents.year}";
                        close = closedate;

                        // date format //${days[dateTimeObj.weekday - 1].substring(0, 3)},
                        String fdate =
                            " ${dateTimeObj.day} ${months[dateTimeObj.month - 1].substring(0, 3)} ${dateTimeObj.year}";
                        // time format
                        dateset = fdate;
                        // String time =
                        //     "${(dateTimeObj.hour > 12 ? dateTimeObj.hour - 12 : dateTimeObj.hour).abs()}:${dateTimeObj.minute}${dateTimeObj.hour >= 12 ? "PM" : "AM"}";
                        // print("$fdate $time");

                        // String endtime =
                        //     "${(enddateTimeObj.hour > 12 ? enddateTimeObj.hour - 12 : enddateTimeObj.hour).abs()}:${enddateTimeObj.minute}${enddateTimeObj.hour >= 12 ? "PM" : "AM"}";
                        //print("$fdate $time");
                        String timeStamp24HRend = dataload[position]
                            .eventEndDateTime
                            .toString(); //"2020-07-20T18:15:12";
                        String endtime = DateFormat.jm()
                            .format(DateTime.parse(timeStamp24HRend));

                        String timeStamp24HR = dataload[position]
                            .eventStartDateTime
                            .toString(); //"2020-07-20T18:15:12";
                        String time = DateFormat.jm()
                            .format(DateTime.parse(timeStamp24HR));

                        // print(new DateFormat.jm()
                        //     .format(DateTime.parse(timeStamp24HR)));

                        print("$close - $dateset - $time - $endtime");

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
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                        "https://new-demo.inkcdogs.org/${dataload[position].eventImage}"),
                                  ),

                                  // Container(
                                  //   height: 140.0.sp,
                                  //   width: 150.0.sp,
                                  //   decoration: BoxDecoration(
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color:
                                  //             Color.fromARGB(255, 178, 177, 189),
                                  //         blurRadius: 2,
                                  //         offset: Offset(
                                  //           5,
                                  //           5,
                                  //         ),
                                  //       )
                                  //     ],
                                  //     borderRadius: BorderRadius.circular(10.sp),
                                  //     //set border radius to 50% of square height and width
                                  //     image: DecorationImage(
                                  //       image: NetworkImage(
                                  //           "https://new-demo.inkcdogs.org/${dataload[position].eventImage}"),
                                  //       fit:
                                  //           BoxFit.cover, //change image fill type
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    // width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10, bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: AutoSizeText(
                                              // dataload[position]
                                              //         .eventNameSuff
                                              //         .toString() +
                                              //     " " +
                                              dataload[position]
                                                  .eventName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "( $dateset )  \n    ${dataload[position].eventLocation}",
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 110, 3, 3),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "( $time ) - ( $endtime )",
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 71, 2, 2),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(5.0),
                                          //   child: Text(
                                          //     '( ${dataload[position].subCategoryName} )',
                                          //     style: TextStyle(
                                          //         fontSize: 12.sp,
                                          //         color: Colors.black,
                                          //         fontWeight: FontWeight.bold),
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 231, 25, 25),
                                                  textStyle: TextStyle(
                                                      fontSize: 10.sp,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              241,
                                                              236,
                                                              236),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              onPressed: () {
                                                print(dateset);
                                                // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>NonInkcRegistrationDog(imag dataload[position].petImage,dataload[position].petName,dataload[position].birthDate,dataload[position].petGender,dataload[position].petRegistrationNumber,dataload[position].subCategoryName,dataload[position].subCategoryName)));
                                                // print(
                                                //     dataload[position]
                                                //             .eventId
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .eventNumber
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[
                                                //                 position]
                                                //             .eventNameSuff
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .eventName
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .eventSlug
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .eventImage
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .dogPriceDiscount
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .eventAddress
                                                //             .toString() +
                                                //         " " +
                                                //         dataload[position]
                                                //             .eventLocation
                                                //             .toString() +
                                                //         " - " +
                                                //         dataload[position]
                                                //             .eventContactPerson
                                                //             .toString() +
                                                //         " - " +
                                                //         dateset.toString());
                                                String eventstalAC = "null";
                                                if (dataload[position]
                                                        .eventStall
                                                        .toString() ==
                                                    "0") {
                                                  eventstalAC = "null";
                                                } else {
                                                  String eventAC =
                                                      dataload[position]
                                                          .eventStallPriceAc
                                                          .toString()
                                                          .replaceAll("[", "")
                                                          .replaceAll("\"", "")
                                                          .replaceAll("]", ",");

                                                  String eventstalFan =
                                                      dataload[position]
                                                          .eventStallPriceFan
                                                          .toString()
                                                          .replaceAll("[", "")
                                                          .replaceAll("\"", "")
                                                          .replaceAll("]", "");

                                                  eventstalAC =
                                                      eventAC + eventstalFan;

                                                  // print("tarak" + AC);
                                                }

                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext context) =>
                                                            EventsDetails(
                                                                EventId: dataload[position]
                                                                    .eventId
                                                                    .toString(),
                                                                EventNumber: dataload[position]
                                                                    .eventNumber
                                                                    .toString(),
                                                                EventStuff: dataload[position]
                                                                    .eventNameSuff
                                                                    .toString(),
                                                                EventName: dataload[position]
                                                                    .eventName
                                                                    .toString(),
                                                                EventSlug: dataload[position]
                                                                    .eventSlug
                                                                    .toString(),
                                                                EventImage: dataload[position]
                                                                    .eventImage
                                                                    .toString(),
                                                                EventDogPriceDiscound: dataload[position]
                                                                    .dogPriceDiscount
                                                                    .toString(),
                                                                EventAddress: dataload[position]
                                                                    .eventAddress
                                                                    .toString(),
                                                                EventLocation: dataload[position]
                                                                    .eventLocation
                                                                    .toString(),
                                                                EventContactPerson: dataload[position]
                                                                    .eventContactPerson
                                                                    .toString(),
                                                                EventStartDate: dateset
                                                                    .toString()

                                                                // dataload[
                                                                //         position]
                                                                //     .eventStartDateTime
                                                                //     .toString()
                                                                ,
                                                                EventEndDate: dataload[position]
                                                                    .eventEndDateTime
                                                                    .toString(),
                                                                EventClossEntry: close,
                                                                // dataload[
                                                                //         position]
                                                                //     .eventEntryClosedOn
                                                                //     .toString(),
                                                                EventTime: "Time: $time $endtime",
                                                                Eventjudge: dataload[position].lastName.toString() == "null" ? dataload[position].firstName.toString() : "${dataload[position].firstName} ${dataload[position].lastName}",
                                                                Eventstall: eventstalAC,
                                                                EventType: dataload[position].eventType.toString(),
                                                                event_stall: dataload[position].eventStall.toString())));
                                              },
                                              child: const Text(
                                                "Events Details",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(left: 30),
                                          //   child: Row(
                                          //     children: [
                                          //       Text(
                                          //         'Registration Number - ',
                                          //         style: TextStyle(
                                          //             color: Colors.black,
                                          //             fontWeight:
                                          //                 FontWeight.bold),
                                          //       ),
                                          //       Text(
                                          //         dataload[position]
                                          //             .petRegistrationNumber
                                          //             .toString(),
                                          //         style: TextStyle(
                                          //             fontSize: 14.sp,
                                          //             color: Colors.black,
                                          //             fontWeight:
                                          //                 FontWeight.w600),
                                          //       ),
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
                          ),
                        );
                      },
                    );
                  } else {
                    //print("dataloadlength");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}
