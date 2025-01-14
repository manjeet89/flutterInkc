import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkc/Updated_pages_dogs_registered/Both_Parents_Registered_With_INKC_form/pedigree_dog_registration.dart';
import 'package:inkc/Updated_pages_dogs_registered/Both_Parents_Registered_With_other_clubs/pedigree_dog_registration_with_club.dart';
import 'package:inkc/Updated_pages_dogs_registered/Dam_Registration_With_INKC/dam_registration_with_inkc.dart';
import 'package:inkc/Updated_pages_dogs_registered/Dam_registration_with_link_sire_unknown/dam_registration_with_inkc_sire_unknown.dart';
import 'package:inkc/Updated_pages_dogs_registered/Dam_registration_with_other_club_sire_unkown/dam_registration_with_other_club_sire_unkown.dart';
import 'package:inkc/Updated_pages_dogs_registered/Sire_Registration_with_INKC/sire_registration_with_inkc.dart';
import 'package:inkc/Updated_pages_dogs_registered/Sire_registration_with_inkc_dam_unkown/sire_registration_with_inkc_dam_unknown.dart';
import 'package:inkc/Updated_pages_dogs_registered/Sire_registration_with_other_club_dam_unknown/sire_registration_with_other_club_dam_unknown.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';

// class Barpage extends StatelessWidget {
//   const Barpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return const MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: Barpagewidegt(),
//         );
//       },
//     );
//   }
// }

class SingleDogRegisrationEitherParaentsKnows extends StatefulWidget {
  String participate_event_id,
      is_participate_with_event,
      register_with_event,
      eventname,
      eventtype,
      eventstal,
      pariticaipate_for_event,
      register_for_event;
  SingleDogRegisrationEitherParaentsKnows(
      {required this.participate_event_id,
      required this.is_participate_with_event,
      required this.register_with_event,
      required this.eventname,
      required this.eventtype,
      required this.eventstal,
      required this.pariticaipate_for_event,
      required this.register_for_event,
      super.key});

  @override
  State<SingleDogRegisrationEitherParaentsKnows> createState() =>
      _SingleDogRegisrationEitherParaentsKnowsState();
}

class _SingleDogRegisrationEitherParaentsKnowsState
    extends State<SingleDogRegisrationEitherParaentsKnows> {
  bool parentregistrationhide = false;
  bool sixmonthold = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Single Dog Registration (Either Parent Known)',
              style: TextStyle(
                  fontSize: 11.sp,
                  decorationColor: Colors.red,
                  color: const Color.fromARGB(255, 22, 22, 21),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PedigreeDogRegistration(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                                  color: const ui.Color(0xFF80A5D6),
                                  width: 0.5,
                                ),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(20),
                                // color: ui.Color.fromARGB(136, 172, 220, 255),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PedigreeDogRegistration(
                                                  participate_event_id: widget
                                                      .participate_event_id,
                                                  is_participate_with_event: widget
                                                      .is_participate_with_event,
                                                  register_with_event: widget
                                                      .register_with_event,
                                                  eventname: widget.eventname,
                                                  eventtype: widget.eventtype,
                                                  eventstal: widget.eventstal,
                                                  register_for_event:
                                                      widget.register_for_event,
                                                  pariticaipate_for_event: widget
                                                      .pariticaipate_for_event)));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.dog,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Both Parents Registered With INKC',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PedigreeDogRegistrationWithClub(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PedigreeDogRegistrationWithClub(
                                                  participate_event_id: widget
                                                      .participate_event_id,
                                                  is_participate_with_event: widget
                                                      .is_participate_with_event,
                                                  register_with_event: widget
                                                      .register_with_event,
                                                  eventname: widget.eventname,
                                                  eventtype: widget.eventtype,
                                                  eventstal: widget.eventstal,
                                                  register_for_event:
                                                      widget.register_for_event,
                                                  pariticaipate_for_event: widget
                                                      .pariticaipate_for_event)));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.home,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Both Parents Registered With other clubs',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SireRegistrationWithInkc(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                                  color: const ui.Color(0xFF80A5D6),
                                  width: 0.5,
                                ),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(20),
                                // color: ui.Color.fromARGB(136, 172, 220, 255),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SireRegistrationWithInkc(
                                                  participate_event_id: widget
                                                      .participate_event_id,
                                                  is_participate_with_event: widget
                                                      .is_participate_with_event,
                                                  register_with_event: widget
                                                      .register_with_event,
                                                  eventname: widget.eventname,
                                                  eventtype: widget.eventtype,
                                                  eventstal: widget.eventstal,
                                                  register_for_event:
                                                      widget.register_for_event,
                                                  pariticaipate_for_event: widget
                                                      .pariticaipate_for_event)));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.paw,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Sire Registered With INKC',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DamRegistrationWithInkc(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DamRegistrationWithInkc(
                                                  participate_event_id: widget
                                                      .participate_event_id,
                                                  is_participate_with_event: widget
                                                      .is_participate_with_event,
                                                  register_with_event: widget
                                                      .register_with_event,
                                                  eventname: widget.eventname,
                                                  eventtype: widget.eventtype,
                                                  eventstal: widget.eventstal,
                                                  register_for_event:
                                                      widget.register_for_event,
                                                  pariticaipate_for_event: widget
                                                      .pariticaipate_for_event)));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.paw,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Dam Registered With other clubs',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SireRegistrationWithInkcDamUnknown(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                                  color: const ui.Color(0xFF80A5D6),
                                  width: 0.5,
                                ),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(20),
                                // color: ui.Color.fromARGB(136, 172, 220, 255),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SireRegistrationWithInkcDamUnknown(
                                                  participate_event_id: widget
                                                      .participate_event_id,
                                                  is_participate_with_event: widget
                                                      .is_participate_with_event,
                                                  register_with_event: widget
                                                      .register_with_event,
                                                  eventname: widget.eventname,
                                                  eventtype: widget.eventtype,
                                                  eventstal: widget.eventstal,
                                                  register_for_event:
                                                      widget.register_for_event,
                                                  pariticaipate_for_event: widget
                                                      .pariticaipate_for_event)));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.magento,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Sire Registered With INKC dam unknown',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DamRegistrationWithInkcSireUnknown(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.solidNoteSticky,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Dam Registered With INKC sire unknown',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SireRegistrationWithOtherClubDamUnknown(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                                  color: const ui.Color(0xFF80A5D6),
                                  width: 0.5,
                                ),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(20),
                                // color: ui.Color.fromARGB(136, 172, 220, 255),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.galacticRepublic,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Sire Registered With Other Club dam unknown',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DamRegistrationWithOtherClubSireUnkown(
                                          participate_event_id:
                                              widget.participate_event_id,
                                          is_participate_with_event:
                                              widget.is_participate_with_event,
                                          register_with_event:
                                              widget.register_with_event,
                                          eventname: widget.eventname,
                                          eventtype: widget.eventtype,
                                          eventstal: widget.eventstal,
                                          register_for_event:
                                              widget.register_for_event,
                                          pariticaipate_for_event:
                                              widget.pariticaipate_for_event)));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                            },
                            child: Container(
                              height: 120.sp,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: const [
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
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (BuildContext context) =>
                                      //         PedigreeDogRegistrationRegistrationWithOtherClubForm()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 30.0.sp,
                                      // width: 50.0.sp,
                                      child: const FaIcon(
                                        FontAwesomeIcons.contactBook,
                                        color: ui.Color(0xFF80A5D6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120.0.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Dam Registered With other clubs sire unknown',
                                        style: TextStyle(
                                            shadows: const [
                                              Shadow(
                                                // blurRadius: 5.0, // shadow blur
                                                color: Color.fromARGB(255, 85,
                                                    70, 218), // shadow color
                                                // offset: Offset(2.0,
                                                //     2.0), // how much shadow will be shown
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
