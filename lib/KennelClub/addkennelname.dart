import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkc/KennelClub/kennelclubname.dart';
import 'package:inkc/model/kennelNames/kennel_history.dart';
import 'package:inkc/model/kennelNames/kennel_second_owner.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AddKennelName extends StatelessWidget {
  const AddKennelName({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const AddKennelNameHistre(),
        );
      },
    );
  }
}

class AddKennelNameHistre extends StatefulWidget {
  const AddKennelNameHistre({super.key});

  @override
  State<AddKennelNameHistre> createState() => _AddKennelNameHistreState();
}

class _AddKennelNameHistreState extends State<AddKennelNameHistre> {
  TextEditingController First = new TextEditingController();
  TextEditingController lastname = new TextEditingController();

  String? gender = "0";
  late bool hide = false;

  bool Firstvalidate = false;
  bool secondvalidate = false;
  bool checktrue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (checktrue == false) {
      AddName();
    }
  }

  AddName() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String kennelnamestore = sharedprefrence.getString("Kennelnamestore")!;
    setState(() {
      First.value = TextEditingValue(text: kennelnamestore);
      checktrue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          //   icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 32, 22, 22)),
          //   onPressed: () => Navigator.of(context, rootNavigator: true)
          //       .push(MaterialPageRoute(builder: (_) => KennelClubName())),
          // ),
          title: Text(
            'Add Kennel Name',
            style: TextStyle(
                fontSize: 18.sp,
                decorationColor: Colors.red,
                color: Color.fromARGB(255, 17, 11, 7),
                // color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 15, right: 15, bottom: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: First,
                  enabled: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                      borderSide: BorderSide(width: 1, color: Colors.green),
                    ),
                    labelText: 'Kennel Name',
                    hintText: 'Kennel Name',
                    errorText: Firstvalidate ? "Value Can't Be Empty" : null,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  boxShadow: [],
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(4.sp),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'Add second owner',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14.sp),
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
                                    gender = value.toString();
                                    hide = true;
                                  });
                                },
                              ),
                              Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13.sp),
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
                                    hide = false;
                                  });
                                },
                              ),
                              Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: hide,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: lastname,
                    enabled: true,
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.sp)),
                        borderSide: BorderSide(width: 1, color: Colors.green),
                      ),
                      labelText: 'Second owner’s ID',
                      hintText: 'Second owner’s ID',
                      errorText: secondvalidate ? "Value Can't Be Empty" : null,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (First.text.toString().isEmpty) {
                    setState(() {
                      Firstvalidate = First.text.isEmpty;
                    });
                  } else if (hide == true) {
                    if (lastname.text.toString().isEmpty) {
                      setState(() {
                        secondvalidate = lastname.text.isEmpty;
                      });
                    } else {
                      RUNDATAWITHSECONDOWNER(lastname.text.toString());
                    }
                  } else {
                    RUNDATA();
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 231, 25, 25),
                    textStyle: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 241, 236, 236),
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void RUNDATA() async {
    print("object");
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    final uri = "https://www.inkc.in/api/dog/kennel_name_registration";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(Uri.parse(uri),
        headers: requestHeaders,
        body: {
          'kennel_club_name': First.text.toString(),
          'second_owner_id': ""
        });
    var data = json.decode(responce.body);

    if (data['code'].toString() == "200") {
      SharedPreferences Kennelnamestore = await SharedPreferences.getInstance();
      await Kennelnamestore.setString("Kennelnamestore", First.text.toString());

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
      );
    }
  }

//RefreshCart
  RefreshCart() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    final uri = "https://www.inkc.in/api/cart/cartready";

    Map<String, String> requestHeaders = {
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
    );
    var data = json.decode(responce.body);
    // setState(() {
    //   showSpinner = false;
    // });

    print(responce.body + " Refresh");
  }

  void RUNDATAWITHSECONDOWNER(String string) async {
    print(string);
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    final uri = "https://www.inkc.in/api/dog/kennel_name_registration";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(Uri.parse(uri),
        headers: requestHeaders,
        body: {
          'kennel_club_name': First.text.toString(),
          'second_owner_id': string
        });
    var data = json.decode(responce.body);
    if (data['code'].toString() == "200") {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
      );
      setState(() {
        RefreshCart();
      });
    }
  }
}
