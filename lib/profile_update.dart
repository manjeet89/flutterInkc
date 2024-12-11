import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/profile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ProfileUpdate extends StatelessWidget {
  String? names, lastnames, genders, dobs, phones, emails, addresss;
  ProfileUpdate(
      {super.key, required this.names,
      required this.lastnames,
      required this.genders,
      required this.dobs,
      required this.phones,
      required this.emails,
      required this.addresss});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "profile UI",
      home: ProfileUpdates(
        name: names,
        lastname: lastnames,
        gender: genders,
        dob: dobs,
        phone: phones,
        email: emails,
        address: addresss,
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileUpdates extends StatefulWidget {
  String? name, lastname, gender, dob, phone, email, address;
  ProfileUpdates(
      {super.key, required this.name,
      required this.lastname,
      required this.gender,
      required this.dob,
      required this.phone,
      required this.email,
      required this.address});

  @override
  State<ProfileUpdates> createState() => _ProfileUpdatesState();
}

class _ProfileUpdatesState extends State<ProfileUpdates> {
  TextEditingController MyController = TextEditingController();
  TextEditingController First = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController personalid = TextEditingController();

  // dialogbox
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();
  final address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();

  bool showSpinner = false;
  FocusNode focusNode = FocusNode();
  final tenDigitsOnly = RegExp(r'^\d{0,6}$');
  dynamic valuechoose;
  String? gender;
  TextEditingController lastname = TextEditingController();
  bool addnull = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //phonenumber.value = TextEditingValue(text: '${widget.phone}');
    email.value = TextEditingValue(text: '${widget.email}');

    gender = widget.gender.toString();
    First.value = TextEditingValue(text: widget.name.toString());
    lastname.value = TextEditingValue(text: widget.lastname.toString());
    dateofbirth.value = TextEditingValue(text: widget.dob.toString());

    if (widget.address.toString() == "null") {
      addnull = true;
    } else {
      List add = widget.address.toString().split(",");
      for (int i = 0; i < add.length; i++) {
        if (i == 0) {
          address1.value = TextEditingValue(text: '${add[i]}');
        }
        if (i == 1) {
          //valuechoose = add[i];
        }
        if (i == 2) {
          district.value = TextEditingValue(text: '${add[i]}');
        }
        if (i == 3) {
          state.value = TextEditingValue(text: '${add[i]}');
        }
        if (i == 4) {
          pincode.value = TextEditingValue(text: add[i].toString().trim());
        }
        print(add[i]);
      }

      address.value = TextEditingValue(text: '${widget.address}');
    }

    // SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    // String Firstname = sharedprefrence.getString("Firstname")!;
    // String LastName = sharedprefrence.getString("LastName")!;
  }

  List<dynamic> Itemlist = [];

  bool _validateadd1 = false;
  bool _validatepincode = false;
  bool _validatestate = false;
  bool _validatedistic = false;
  final bool _validatelocal = false;
  final bool _validateadd2 = false;

  DateTime date = DateTime.now();
  void selectDatePicker() async {
    DateTime? datepicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));

    if (datepicker != null && datepicker != date) {
      setState(() {
        date = datepicker;
        dateofbirth.value = TextEditingValue(
            text: "${date.day}-${date.month}-${date.year}");
      });
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
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                //automaticallyImplyLeading: false,
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back,
                //       color: Color.fromARGB(255, 223, 39, 39)),
                //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: (BuildContext context) => SettingsUI())),
                // ),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 20.sp,
                      decorationColor: Colors.red,
                      color: const Color.fromARGB(255, 17, 17, 17),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              // body:
              // FutureBuilder<List<ProfileModel>>(
              //   builder: (context, snapshot) {
              //     if (snapshot.data == null)
              //       return const Center(
              //         child: Text("null value print "),
              //       );
              //     else {}
              //     return Center(
              //       child: Text(snapshot.data!.length.toString()),
              //     );
              //   },
              // ),

              body: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      // Center(
                      //   child: Text(
                      //     "Edit Profile",
                      //     style: TextStyle(
                      //         fontSize: 25.sp, fontWeight: FontWeight.w600),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                  visible: addnull,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextField(
                                          controller: First,
                                          enabled: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.sp)),
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.green),
                                            ),
                                            labelText: 'First Name',
                                            hintText: '',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextField(
                                          controller: lastname,
                                          enabled: true,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6.sp)),
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.green),
                                            ),
                                            labelText: 'Last Name',
                                            hintText: '',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          boxShadow: const [],
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4.sp),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  child: Text(
                                                    'Gender',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        fontSize: 12.sp),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: "1",
                                                        groupValue: gender,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            gender = value
                                                                .toString();
                                                          });
                                                        },
                                                      ),
                                                      Text(
                                                        'Male',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
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
                                                            gender = value
                                                                .toString();
                                                          });
                                                        },
                                                      ),
                                                      Text(
                                                        'Female',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 11.sp),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: 150.sp,
                                              child: TextField(
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                onTap: () {},
                                                controller: dateofbirth,
                                                enabled: false,
                                                // obscureText: true,
                                                decoration: InputDecoration(
                                                  // suffixIcon: IconButton(
                                                  //   icon: Icon(Icons.date_range),
                                                  //   onPressed: () {
                                                  //     setState(
                                                  //       () {},
                                                  //     );
                                                  //   },
                                                  // ),
                                                  prefixIcon:
                                                      const Icon(Icons.date_range),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.sp)),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color: Colors.green),
                                                  ),
                                                  labelText: 'Date of Birth',
                                                  hintText: '1-1-2000',
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  selectDatePicker();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                child: const Text(
                                                  'Pick date',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              // Padding(
                              //   padding: EdgeInsets.all(10),
                              //   child: IntlPhoneField(
                              //     enabled: true,
                              //     controller: phonenumber,
                              //     focusNode: focusNode,
                              //     decoration: InputDecoration(
                              //       labelText: 'Phone Number',
                              //       border: OutlineInputBorder(
                              //         borderSide: BorderSide(),
                              //       ),
                              //     ),
                              //     style: TextStyle(
                              //         color: const Color.fromARGB(255, 41, 2, 2),
                              //         fontWeight: FontWeight.w600),
                              //     initialCountryCode: 'IN',
                              //     onChanged: (phone) {
                              //       print(
                              //         phone.completeNumber,
                              //       );
                              //     },
                              //     onCountryChanged: (country) {
                              //       print('Country changed to: ' + country.name);
                              //     },
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 41, 2, 2),
                                      fontWeight: FontWeight.w600),
                                  controller: email,
                                  enabled: true,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Email Address',
                                    hintText: 'example@01.caom',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      enableDrag: false,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 450.sp,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.sp,
                                                  top: 10.sp,
                                                  right: 10.sp),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Address',
                                                    style: TextStyle(
                                                        color: const Color.fromARGB(
                                                            255, 95, 10, 10),
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  // Divider(),
                                                  SizedBox(
                                                    height: 10.sp,
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.all(5),
                                                  //   child: TextField(
                                                  //     style: TextStyle(
                                                  //         color: Color.fromARGB(
                                                  //             75, 15, 3, 3),
                                                  //         fontWeight:
                                                  //             FontWeight.w600),
                                                  //     // onChanged: (value) {
                                                  //     //   if (value.length == 6) {
                                                  //     //     GetAllAddress(pincode
                                                  //     //         .text
                                                  //     //         .toString());

                                                  //     //   }
                                                  //     // },
                                                  //     maxLength: 6,
                                                  //     inputFormatters: <TextInputFormatter>[
                                                  //       FilteringTextInputFormatter
                                                  //           .allow(
                                                  //               RegExp(r'[0-9]')),
                                                  //       LengthLimitingTextInputFormatter(
                                                  //           6),
                                                  //     ],
                                                  //     controller: pincode,
                                                  //     enabled: true,
                                                  //     keyboardType:
                                                  //         TextInputType.number,
                                                  //     decoration: InputDecoration(
                                                  //       border:
                                                  //           OutlineInputBorder(
                                                  //         borderRadius:
                                                  //             BorderRadius.all(
                                                  //                 Radius.circular(
                                                  //                     4.sp)),
                                                  //         borderSide: BorderSide(
                                                  //             width: 1,
                                                  //             color:
                                                  //                 Colors.green),
                                                  //       ),
                                                  //       labelText: 'Pincode',
                                                  //       hintText: 'Eg.123456',
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  const Divider(),

                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: TextField(
                                                      onChanged: (value) {
                                                        if (value.length == 6) {
                                                          GetAllAddress(pincode
                                                              .text
                                                              .toString());
                                                        }
                                                      },
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                        LengthLimitingTextInputFormatter(
                                                            6),
                                                      ],
                                                      maxLength: 6,
                                                      style: const TextStyle(
                                                          color: Color
                                                              .fromARGB(
                                                              255, 41, 2, 2),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      controller: pincode,
                                                      enabled: true,
                                                      decoration:
                                                          InputDecoration(
                                                        errorText: _validatepincode
                                                            ? 'Value Cant Be Empty'
                                                            : null,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.sp)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                        labelText: 'Pincode',
                                                        hintText: 'Eg.123456',
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),

                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.all(8.0),
                                                  //   child:
                                                  //       DropdownButtonFormField(
                                                  //           decoration:
                                                  //               InputDecoration(
                                                  //             contentPadding:
                                                  //                 const EdgeInsets
                                                  //                     .only(
                                                  //                     left: 30,
                                                  //                     right: 10),
                                                  //             border: OutlineInputBorder(
                                                  //                 borderRadius: BorderRadius
                                                  //                     .all(Radius
                                                  //                         .circular(
                                                  //                             10))),
                                                  //           ),
                                                  //           hint: Text(
                                                  //               'Select value'),
                                                  //           isExpanded: true,
                                                  //           value: valuechoose,
                                                  //           items:
                                                  //               Itemlist.map((e) {
                                                  //             return DropdownMenuItem(
                                                  //                 value: e
                                                  //                     .kennelClubId
                                                  //                     .toString(),
                                                  //                 child: Text(
                                                  //                   e.kennelClubName
                                                  //                       .toString(),
                                                  //                   style: TextStyle(
                                                  //                       color: Color.fromARGB(
                                                  //                           255,
                                                  //                           95,
                                                  //                           46,
                                                  //                           46),
                                                  //                       fontSize:
                                                  //                           12.sp,
                                                  //                       fontWeight:
                                                  //                           FontWeight
                                                  //                               .bold),
                                                  //                 ));
                                                  //           }).toList(),
                                                  //           onChanged: (value) {
                                                  //             valuechoose = value;

                                                  //             setState(() {});
                                                  //           }),
                                                  // ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                      ),
                                                      hint: const Text(
                                                          'Select locality'),
                                                      dropdownColor:
                                                          Colors.white,
                                                      icon: const Icon(Icons
                                                          .arrow_drop_down),
                                                      value: valuechoose,
                                                      onChanged: (newvalue) {
                                                        setState(() {
                                                          valuechoose = newvalue
                                                              as String?;
                                                        });
                                                      },
                                                      items:
                                                          Itemlist.map((value) {
                                                        return DropdownMenuItem(
                                                          value:
                                                              value.toString(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              value.toString(),
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                      255,
                                                                      41,
                                                                      2,
                                                                      2),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: TextField(
                                                      style: const TextStyle(
                                                          color: Color
                                                              .fromARGB(
                                                              255, 41, 2, 2),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      controller: district,
                                                      enabled: true,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.sp)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                        labelText: 'District',
                                                        hintText: 'Eg.Indore',
                                                        errorText: _validatedistic
                                                            ? 'Value Cant Be Empty'
                                                            : null,
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: TextField(
                                                      style: const TextStyle(
                                                          color: Color
                                                              .fromARGB(
                                                              255, 41, 2, 2),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      controller: state,
                                                      enabled: true,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.sp)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                        errorText: _validatestate
                                                            ? 'Value Cant Be Empty'
                                                            : null,
                                                        labelText: 'State',
                                                        hintText:
                                                            'Eg.Madhya Pradesh',
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: TextField(
                                                      style: const TextStyle(
                                                          color: Color
                                                              .fromARGB(
                                                              255, 41, 2, 2),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      controller: address1,
                                                      enabled: true,
                                                      maxLines: null,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.sp)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                        errorText: _validateadd1
                                                            ? 'Value Cant Be Empty'
                                                            : null,
                                                        labelText:
                                                            'Address Line 1',
                                                        hintText:
                                                            'Eg.Vithalwadi...',
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: TextField(
                                                      style: const TextStyle(
                                                          color: Color
                                                              .fromARGB(
                                                              255, 41, 2, 2),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      controller: address2,
                                                      enabled: true,
                                                      maxLines: null,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.sp)),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                        labelText:
                                                            'Address Line 2',
                                                        hintText:
                                                            'Eg.Mumbai Central...',
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  Center(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  80,
                                                                  3,
                                                                  3), // Background color
                                                        ),
                                                        onPressed: () {
                                                          insertData();
                                                        },
                                                        child: const Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Submit',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: TextField(
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 41, 2, 2),
                                        fontWeight: FontWeight.w600),
                                    maxLines: null,
                                    controller: address,
                                    enabled: false,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.sp)),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.green),
                                      ),
                                      labelText: 'Address',
                                      hintText: 'Rajbhar',
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(85, 2, 11, 0.957)),
                                  onPressed: () async {
                                    SharedPreferences sharedprefrence =
                                        await SharedPreferences.getInstance();
                                    String userid =
                                        sharedprefrence.getString("Userid")!;
                                    String token =
                                        sharedprefrence.getString("Token")!;
                                    EasyLoading.showToast('Please Wait...');

                                    SharedPreferences fulladdress =
                                        await SharedPreferences.getInstance();
                                    await fulladdress.setString(
                                        "fulladdress", address.text.toString());

                                    const uri =
                                        "https://new-demo.inkcdogs.org/api/user/update_profile";

                                    Map<String, String> requestHeaders = {
                                      'Accept': 'application/json',
                                      'Usertoken': token,
                                      'Userid': userid
                                    };

                                    print("${email.text} $valuechoose ${state.text} ${pincode.text} ${address1.text} ${address2.text} ${district.text} ${phonenumber.text}");

                                    final responce = await http.post(
                                      Uri.parse(uri),
                                      headers: requestHeaders,
                                      body: {
                                        "first_name": First.text.toString(),
                                        "last_name": lastname.text.toString(),
                                        "user_birth_date":
                                            dateofbirth.text.toString(),
                                        "gender": gender.toString(),
                                        "user_email_id": email.text.toString(),
                                        "user_local": valuechoose.toString(),
                                        "user_state": state.text.toString(),
                                        "user_pincode": pincode.text.toString(),
                                        "user_address":
                                            address1.text.toString(),
                                        "user_address2":
                                            address2.text.toString(),
                                        "user_district":
                                            district.text.toString(),
                                        "alternet_contact_number": " ",
                                        // phonenumber.text.toString(),
                                      },
                                    );
                                    var data = json.decode(responce.body);

                                    // print(data);

                                    if (data['code'] == 200) {
                                      print(data['data']);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const SettingsUI()));
                                    } else {
                                      print(data);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Something went wrong')));
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 252, 250, 250)),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  GetAllAddress(String text) async {
    print(text.toString());
    Itemlist.clear();
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;
    EasyLoading.showToast('Please Wait...');

    const uri = "https://new-demo.inkcdogs.org/api/user/get_city_data_from_pincode";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {
        "user_pincode": text.toString(),
      },
    );
    var data = json.decode(responce.body);

    // print(data);

    if (data['code'] == 200) {
      // Itemlist = [data['data']['user_local']];
      String arra = data['data']['user_local'];

      List sp = arra.split(",");
      for (int i = 0; i < sp.length; i++) {
        Itemlist.add(sp[i]);
      }
      print(Itemlist);
      setState(() {
        district.value = TextEditingValue(text: data['data']['user_district']);
        state.value = TextEditingValue(text: data['data']['user_state']);
      });
    } else {
      Navigator.pop(context);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Note is can not empty',
      );
    }
  }

  void insertData() {
    String add1 = address1.text.toString();
    String add2 = address2.text.toString();
    String local = valuechoose.toString();
    String dis = district.text.toString();
    String stat = state.text.toString();
    String pin = pincode.text.toString();

    setState(() {
      add1.toString().isEmpty ? _validateadd1 = true : _validateadd1 = false;
      dis.toString().isEmpty ? _validatedistic = true : _validatedistic = false;

      stat.toString().isEmpty ? _validatestate = true : _validatestate = false;
      pin.toString().isEmpty
          ? _validatepincode = true
          : _validatepincode = false;
    });

    if (add1.isEmpty) {
    } else if (pin.isEmpty) {
    } else if (dis.isEmpty) {
    } else if (stat.isEmpty) {
    } else {
      address.value = TextEditingValue(
          text: "$add1 $add2 $local $dis $stat $pin");
      Navigator.pop(context);
    }

    // if(add1.isEmpty){
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text(
    //         'Please Enter full address',
    //         style: TextStyle(color: Color.fromARGB(255, 12, 2, 2)),
    //       ),
    //       backgroundColor: Color.fromARGB(255, 236, 234, 241),
    //     ));
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    address1.dispose();
  }
}
