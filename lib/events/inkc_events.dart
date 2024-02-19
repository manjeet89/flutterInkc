import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkc/events/obidient.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class INKCEventsDropdown extends StatefulWidget {
  String eventid, eventname, eventtype, eventstal;
  INKCEventsDropdown(
      {required this.eventid,
      required this.eventname,
      required this.eventtype,
      required this.eventstal});

  @override
  State<INKCEventsDropdown> createState() => _INKCEventsDropdownState();
}

class _INKCEventsDropdownState extends State<INKCEventsDropdown> {
  List<Obideint> dataload = [];
  bool prebigner = false;
  bool bigner = false;
  bool novic = false;
  bool Texta = false;
  bool Textb = false;
  bool Textc = false;

  List obidient = [];

  // Future<List<Obideint>> FetchData() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   String userid = sharedprefrence.getString("Userid")!;
  //   String token = sharedprefrence.getString("Token")!;

  //   print('${userid} / ${token}');

  //   final uri =
  //       "https://www.inkc.in/api/event/obidence_class_and_price_list";

  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Usertoken': token,
  //     'Userid': userid
  //   };

  //   final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
  //   var data = json.decode(responce.body);
  //   var dataarray = data['data'];

  //   // print(dataarray);
  //   dataload.clear();
  //   if (responce.statusCode == 200) {
  //     for (Map<String, dynamic> index in dataarray) {
  //       //if (index['owner_id'].toString() == userid) {
  //       dataload.add(Obideint.fromJson(index));
  //       //}
  //     }
  //     print("kaccha aam" + dataload.toString());

  //     return dataload;
  //   } else {
  //     return dataload;
  //   }
  // }

  bool checkvisible = true;
  String? stallReq = "0";
  bool stall_day_type = false;
  String StallDay = "1";
  String StallType = "0";

  List<Map<String, String>> keyValueList = [
    // {"298": "value1"},
    // {"847": "value2"},
    // {"123": "value3"},
  ];

  List products = [];

  String? selectedValue; // Initial selected value

  Future insertvalue() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    try {
      final res = await http.post(
          Uri.parse(
              "https://www.inkc.in/api/dog/inkc_kci_registered_dog_second_own"),
          headers: requestHeaders);

      final body = json.decode(res.body);

      keyValueList.clear();
      products.clear();

      if (body['data'].toString() != "false") {
        List list = body['data'];

        for (int i = 0; i < list.length; i++) {
          // if (body['data'][i]['owner_id'].toString() == userid) {
          var productMap = {
            body['data'][i]['pet_id'].toString():
                body['data'][i]['pet_name'].toString(),
          };
          keyValueList.add(productMap);
          //print(body['data'][i]['pet_id'].toString());
          // }
        }
      }

      final ress = await http.post(
          Uri.parse("https://www.inkc.in/api/dog/inkc_kci_registered_dog"),
          headers: requestHeaders);

      final bodys = json.decode(ress.body);

      List lists = bodys['data'];

      for (int i = 0; i < lists.length; i++) {
        // if (bodys['data'][i]['owner_id'].toString() == userid) {
        var productMap = {
          bodys['data'][i]['pet_id'].toString():
              bodys['data'][i]['pet_name'].toString(),
        };
        keyValueList.add(productMap);
        print(bodys['data'][i]['pet_id'].toString());
        //}
      }

      //print(list);
    } catch (e) {}

    //throw Exception('Error fetch data');
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

  @override
  Widget build(BuildContext context) {
    //insertvalue();
    //products.clear();
    // keyValueList.clear();
    // for (int i = 1; i < 5; i++) {
    //   var productMap = {
    //     (i + 111).toString(): i.toString(),
    //   };
    //   keyValueList.add(productMap);

    //   // products.add(productMap);
    //   // productMap.clear();
    // }

    // print('final list of products');
    // print(products);
    print(keyValueList);
    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                    'Event Participate',
                    style: TextStyle(
                        shadows: [
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
                        color: Color.fromARGB(255, 194, 97, 33),
                        // color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Visibility(
              visible: checkvisible,
              child: Column(
                children: [
                  FutureBuilder(
                      future: insertvalue(),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    hint: Text('Select value'),
                                    items: keyValueList
                                        .map<DropdownMenuItem<String>>(
                                            (Map<String, String> pair) {
                                      final String key = pair.keys.first;
                                      final String value = pair.values.first;
                                      return DropdownMenuItem<String>(
                                        value: key,
                                        child: Container(
                                          width: double
                                              .infinity, // Auto size based on content
                                          child: Text(
                                            '$value'.toString(),
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 95, 46, 46),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              // DropdownButtonFormField<String>(
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         const EdgeInsets.only(left: 30, right: 10),
                              //     border: OutlineInputBorder(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(10))),
                              //   ),
                              //   hint: Text("selected value"),
                              //   value: selectedValue,
                              //   onChanged: (String? newValue) {
                              //     setState(() {
                              //       selectedValue = newValue;
                              //     });
                              //     // if (newValue != null) {
                              //     //   //Handle dropdown value change
                              //     //   print(newValue);
                              //     //   selectedValue = newValue;
                              //     // }
                              //   },
                              //   isExpanded: true,
                              //   items: keyValueList.map<DropdownMenuItem<String>>(
                              //       (Map<String, String> pair) {
                              //     final String key = pair.keys.first;
                              //     final String value = pair.values.first;

                              //     return DropdownMenuItem<String>(
                              //       value: key,
                              //       child: Text(
                              //         '$value'.toString(),
                              //         style: TextStyle(
                              //             color: Color.fromARGB(255, 95, 46, 46),
                              //             fontSize: 12.sp,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     );
                              //   }).toList(),
                              // ),
                            ],
                          ),
                        );
                      }),
                  if (widget.eventtype.toString() == "2")
                    Visibility(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Class (Select at least two option.)",
                            style: TextStyle(
                                color: Color.fromARGB(255, 22, 21, 21),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ), //SizedBox
                                Text(
                                  'Pre-Beginner ',
                                  style: TextStyle(fontSize: 15.0),
                                ), //Text
                                SizedBox(width: 10), //SizedBox
                                /** Checkbox Widget **/
                                Checkbox(
                                  value: this.prebigner,
                                  onChanged: (value) {
                                    setState(() {
                                      this.prebigner = value!;
                                      // obidient.add(value);
                                      print(this.prebigner);
                                    });
                                  },
                                ), //Checkbox
                              ], //<Widget>[]
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ), //SizedBox
                                Text(
                                  'Beginner ',
                                  style: TextStyle(fontSize: 15.0),
                                ), //Text
                                SizedBox(width: 10), //SizedBox
                                /** Checkbox Widget **/
                                Checkbox(
                                  value: this.bigner,
                                  onChanged: (value) {
                                    setState(() {
                                      this.bigner = value!;
                                      // obidient.add(value);
                                    });
                                  },
                                ), //Checkbox
                              ], //<Widget>[]
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ), //SizedBox
                                  Text(
                                    'Novice ',
                                    style: TextStyle(fontSize: 15.0),
                                  ), //Text
                                  SizedBox(width: 10), //SizedBox
                                  /** Checkbox Widget **/
                                  Checkbox(
                                    value: this.novic,
                                    onChanged: (value) {
                                      setState(() {
                                        this.novic = value!;
                                        // obidient.add(value);
                                      });
                                    },
                                  ), //Checkbox
                                ], //<Widget>[]
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ), //SizedBox
                                  Text(
                                    'Test-A ',
                                    style: TextStyle(fontSize: 15.0),
                                  ), //Text
                                  SizedBox(width: 10), //SizedBox
                                  /** Checkbox Widget **/
                                  Checkbox(
                                    value: this.Texta,
                                    onChanged: (value) {
                                      setState(() {
                                        this.Texta = value!;
                                        //obidient.add(value);
                                      });
                                    },
                                  ), //Checkbox
                                ], //<Widget>[]
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ), //SizedBox
                                  Text(
                                    'Test-B ',
                                    style: TextStyle(fontSize: 15.0),
                                  ), //Text
                                  SizedBox(width: 10), //SizedBox
                                  /** Checkbox Widget **/
                                  Checkbox(
                                    value: this.Textb,
                                    onChanged: (value) {
                                      setState(() {
                                        this.Textb = value!;
                                        // obidient.add(value);
                                      });
                                    },
                                  ), //Checkbox
                                ], //<Widget>[]
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ), //SizedBox
                                  Text(
                                    'Test-C ',
                                    style: TextStyle(fontSize: 15.0),
                                  ), //Text
                                  SizedBox(width: 10), //SizedBox
                                  /** Checkbox Widget **/
                                  Checkbox(
                                    value: this.Textc,
                                    onChanged: (value) {
                                      setState(() {
                                        this.Textc = value!;
                                        //  obidient.add(value);
                                      });
                                    },
                                  ), //Checkbox
                                ], //<Widget>[]
                              ),
                            ],
                          ),
                        ),

                        // FutureBuilder(
                        //     future: FetchData(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         return ListView.builder(
                        //           itemCount: dataload.length,
                        //           itemBuilder: (context, position) {
                        //             return Card(
                        //               elevation: 10,
                        //               color: Color.fromARGB(255, 255, 255, 255),
                        //               margin: EdgeInsets.all(5),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(10),
                        //                   gradient: LinearGradient(
                        //                     colors: [
                        //                       Color.fromARGB(255, 255, 255, 255),
                        //                       Color.fromARGB(255, 255, 255, 255),
                        //                     ],
                        //                     begin: Alignment.topLeft,
                        //                     end: Alignment.bottomRight,
                        //                   ),
                        //                 ),
                        //                 // decoration: const BoxDecoration(
                        //                 //   image: DecorationImage(
                        //                 //       image: NetworkImage(
                        //                 //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReL_kSGg4Ux5ZiwK-mIRe6_L-Ft8GxRaaT1Q&usqp=CAU"),
                        //                 //       fit: BoxFit.cover),
                        //                 // ),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(20.0),
                        //                   child: Column(
                        //                     children: [
                        //                       Card(
                        //                         child: Padding(
                        //                           padding:
                        //                               const EdgeInsets.all(15.0),
                        //                           child: SizedBox(
                        //                             width: 30,
                        //                             height: 70,
                        //                             child: Column(
                        //                               children: [
                        //                                 Row(
                        //                                   children: <Widget>[
                        //                                     SizedBox(
                        //                                       width: 10,
                        //                                     ), //SizedBox
                        //                                     Text(
                        //                                       dataload[position]
                        //                                           .className
                        //                                           .toString(),
                        //                                       style: TextStyle(
                        //                                           fontSize: 17.0),
                        //                                     ), //Text
                        //                                     SizedBox(
                        //                                         width:
                        //                                             10), //SizedBox
                        //                                     /** Checkbox Widget **/
                        //                                     Checkbox(
                        //                                       value: this.values,
                        //                                       onChanged: (value) {
                        //                                         this.values =
                        //                                             value!;
                        //                                       },
                        //                                     ), //Checkbox
                        //                                   ], //<Widget>[]
                        //                                 ), //Row
                        //                               ],
                        //                             ), //Column
                        //                           ), //SizedBox
                        //                         ), //Padding
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       } else {
                        //         // print("dataloadlength");
                        //         return Center(
                        //           child: CircularProgressIndicator(),
                        //         );
                        //       }
                        //     }),
                      ],
                    )),
                  if (widget.eventstal.toString() == "1")
                    Visibility(
                        child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 12),
                          child: Row(
                            children: [
                              Text(
                                "Do you need stall              ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 22, 21, 21),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0),
                                // decoration: BoxDecoration(
                                //   boxShadow: [],
                                //   border: Border.all(
                                //     color: Colors.black,
                                //     width: 0.5,
                                //   ),
                                //   borderRadius: BorderRadius.circular(4.sp),
                                //   color: Colors.white,
                                // ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: "0",
                                                groupValue: stallReq,
                                                onChanged: (value) {
                                                  setState(() {
                                                    stall_day_type = false;
                                                    stallReq = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "1",
                                                groupValue: stallReq,
                                                onChanged: (value) {
                                                  setState(() {
                                                    stall_day_type = true;
                                                    stallReq = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                            ],
                          ),
                        ),
                      ],
                    )),
                  if (widget.eventstal.toString() == "1")
                    Visibility(
                        visible: stall_day_type,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "stall Day          ",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 22, 21, 21),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: "1",
                                              groupValue: StallDay,
                                              onChanged: (value) {
                                                setState(() {
                                                  // _isShowOff = true;
                                                  StallDay = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              'First Day',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 11.sp),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: "2",
                                                groupValue: StallDay,
                                                onChanged: (value) {
                                                  setState(() {
                                                    // _isShowOff = true;
                                                    StallDay = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Second Day',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: "3",
                                                groupValue: StallDay,
                                                onChanged: (value) {
                                                  setState(() {
                                                    // _isShowOff = true;
                                                    StallDay = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Both Days',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  if (widget.eventstal.toString() == "1")
                    Visibility(
                        visible: stall_day_type,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "Stall Type             ",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 22, 21, 21),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 0),
                                    // decoration: BoxDecoration(
                                    //   boxShadow: [],
                                    //   border: Border.all(
                                    //     color: Colors.black,
                                    //     width: 0.5,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(4.sp),
                                    //   color: Colors.white,
                                    // ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: "0",
                                                    groupValue: StallType,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        // _isShowOff = false;
                                                        StallType =
                                                            value.toString();
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    'FAN',
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
                                                    value: "1",
                                                    groupValue: StallType,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        // _isShowOff = true;
                                                        StallType =
                                                            value.toString();
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    'AC',
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
                                ],
                              ),
                            ),
                          ],
                        )),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 231, 25, 25),
                              textStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color:
                                      const Color.fromARGB(255, 241, 236, 236),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            String Day = "1";
                            String Type = "0";
                            obidient.clear();

                            if (prebigner == true) {
                              obidient.add("1");
                            }
                            if (bigner == true) {
                              obidient.add("2");
                            }
                            if (novic == true) {
                              obidient.add("3");
                            }
                            if (Texta == true) {
                              obidient.add("4");
                            }
                            if (Textb == true) {
                              obidient.add("5");
                            }
                            if (Textc == true) {
                              obidient.add("6");
                            }

                            print(obidient);

                            if (selectedValue.toString() == "null") {
                              print("bahar");
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Please Select Dog',
                              );
                            } else {
                              if (stallReq == "0") {
                                //  print("sukriya");
                                Day = "";
                                Type = "";
                              } else {
                                Day = StallDay;
                                Type = StallType;
                              }

                              //obidient.length;
                              if (obidient.length <= 1 &&
                                  widget.eventtype.toString() == "2") {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Oops...',
                                  text: 'Please Select atlest 2 box',
                                );
                              } else {
                                print(selectedValue.toString() +
                                    "-" +
                                    Day +
                                    " - " +
                                    Type +
                                    " - " +
                                    obidient.toString() +
                                    " - " +
                                    stallReq.toString() +
                                    " - " +
                                    widget.eventid +
                                    widget.eventtype +
                                    widget.eventstal);

                                SharedPreferences sharedprefrence =
                                    await SharedPreferences.getInstance();
                                String userid =
                                    sharedprefrence.getString("Userid")!;
                                String token =
                                    sharedprefrence.getString("Token")!;

                                Map<String, String> requestHeaders = {
                                  // 'Accept': 'application/json',
                                  'Usertoken': token,
                                  'Userid': userid
                                };

                                final uri =
                                    "https://www.inkc.in/api/event/participate";

                                final responce = await http.post(Uri.parse(uri),
                                    body: {
                                      "event_id": widget.eventid.toString(),
                                      "pet_id": selectedValue.toString(),
                                      "class_and_price[]": obidient.toString(),
                                      "is_stall_required": stallReq,
                                      "event_stall_day": Day,
                                      "event_stall_type": Type,
                                      "register_with_event": "1"
                                    },
                                    headers: requestHeaders);
                                var data = json.decode(responce.body);
                                if (data['code'].toString() == "200") {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: 'Success...',
                                    text: 'Please Check your cart',
                                  );
                                  setState(() {
                                    RefreshCart();
                                  });
                                }
                              }

                              // print(data['message']);
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            )

            // Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       DropdownButton<String>(
            //         hint: Text("selected value"),
            //         value: selectedValue,
            //         onChanged: (String? newValue) {
            //           setState(() {
            //             selectedValue = newValue;
            //             print(newValue.toString() + " new values");
            //           });
            //           // if (newValue != null) {
            //           //   //Handle dropdown value change
            //           //   print(newValue);
            //           //   selectedValue = newValue;
            //           // }
            //         },
            //         items: keyValueList
            //             .map<DropdownMenuItem<String>>((Map<String, String> pair) {
            //           final String key = pair.keys.first;
            //           final String value = pair.values.first;

            //           return DropdownMenuItem<String>(
            //             value: key,
            //             child: Text('$value'.toString()),
            //           );
            //         }).toList(),
            //       ),
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }
}
