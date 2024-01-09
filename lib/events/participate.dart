import 'package:flutter/material.dart';
import 'package:inkc/events/dont_have.dart';
import 'package:inkc/events/i_have_certificate.dart';
import 'package:sizer/sizer.dart';

class Participatent extends StatefulWidget {
  String eventid, eventname;
  Participatent({required this.eventid, required this.eventname});

  @override
  State<Participatent> createState() => _ParticipatentState();
}

class _ParticipatentState extends State<Participatent> {
  String? gender = "1";
  late bool hide = false;
  String certificae = "1";

  @override
  Widget build(BuildContext context) {
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
                'Event Participate',
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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.eventname,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "INKC",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: "1",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  hide = false;
                                });
                              },
                            ),
                            Text(
                              'INKC Registered Dog',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 206, 26, 26),
                                  fontSize: 11.sp),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: "0",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  hide = true;
                                });
                              },
                            ),
                            Text(
                              'Non INKC Registered Dog',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 190, 26, 26),
                                  fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: hide,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "1",
                                groupValue: certificae,
                                onChanged: (value) {
                                  setState(() {
                                    certificae = value.toString();
                                  });
                                },
                              ),
                              Text(
                                'I have certificate',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 206, 26, 26),
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "0",
                                groupValue: certificae,
                                onChanged: (value) {
                                  setState(() {
                                    certificae = value.toString();
                                  });
                                },
                              ),
                              Text(
                                "I don't have certificate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 190, 26, 26),
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
                        if (gender == "1") {
                          print("inkc register");
                        } else if (certificae == "1") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  IHaveCertificate()));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  IDontHaveCertificate()));
                        }
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => Participatent(
                        //           // eventid: widget.EventId,
                        //           // eventname: widget.EventStuff.toString() +
                        //           //     " " +
                        //           //     widget.EventName.toString(),
                        //         )));
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      )),
                ),
              ),
            ]),
      );
    });
  }
}
