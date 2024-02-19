import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:inkc/form/micro_chip_details.dart';
import 'package:inkc/model/profilemodel.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'nonRegistorEdit/note.dart';

class NonInkcDogDetails extends StatefulWidget {
  String id,
      image,
      petnames,
      dateofbirth,
      sex,
      registernumber,
      breed,
      colorandmaking;

  NonInkcDogDetails({
    required this.id,
    required this.image,
    required this.petnames,
    required this.dateofbirth,
    required this.sex,
    required this.registernumber,
    required this.breed,
    required this.colorandmaking,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: "Non INKC Dog",
  //     home: NonInkcDogs(),
  //   );
  // }

  @override
  State<NonInkcDogDetails> createState() => _NonInkcDogsState(id, image,
      petnames, dateofbirth, sex, registernumber, breed, colorandmaking);
}

// class NonInkcDogs extends StatefulWidget {
//   @override
//   _NonInkcDogsState createState() => _NonInkcDogsState();
// }

String IDs = "";

class _NonInkcDogsState extends State<NonInkcDogDetails> {
  TextEditingController petname = new TextEditingController();
  TextEditingController breed = new TextEditingController();
  TextEditingController sex = new TextEditingController();
  TextEditingController image = new TextEditingController();
  TextEditingController colorandmaking = new TextEditingController();
  TextEditingController dateofbirth = new TextEditingController();
  TextEditingController registration = new TextEditingController();

  FocusNode focusNode = FocusNode();

  _NonInkcDogsState(
      String id,
      String image,
      String petnames,
      String dateofbirth,
      String sex,
      String registernumber,
      String breed,
      String colorandmaking);

  // final List<ProfileModel> profileadd = [];

  // Future<List<ProfileModel>> fetchjson() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   userid = sharedprefrence.getString("Userid")!;
  //   token = sharedprefrence.getString("Token")!;

  //   // print('${userid} / ${token}');

  //   final uri = "https://www.inkc.in/api/user/user_profile";

  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Usertoken': token,
  //     'Userid': userid
  //   };

  //   final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
  //   var data = json.decode(responce.body);

  //   List<ProfileModel> promodel = [];

  //   if (data['code'] == 200) {
  //     var datas = data['data'];
  //     print(data['data']);

  //     for (var jsondata in datas) {
  //       promodel.add(ProfileModel.fromJson(jsondata));
  //     }
  //   }

  //   return promodel;
  // }

  // Future<List<ProfileModel>> getalldata() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   userid = sharedprefrence.getString("Userid")!;
  //   token = sharedprefrence.getString("Token")!;

  //   // print('${userid} / ${token}');

  //   final uri = "https://www.inkc.in/api/user/user_profile";

  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Usertoken': token,
  //     'Userid': userid
  //   };

  //   final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
  //   var data = json.decode(responce.body);
  //   var dataarray = data['data'];

  //   List<ProfileModel> dataload = [];

  //   for (var jsondata in dataarray) {
  //     ProfileModel profileModel = ProfileModel(
  //         firstname: jsondata['first_name'], lastname: jsondata['last_name']);
  //     dataload.add(profileModel);

  //     print(jsondata['first_name']);
  //     print(jsondata['last_name']);

  // First.value = TextEditingValue(text: jsondata['first_name']);
  // MyController.value = TextEditingValue(text: jsondata['last_name']);
  // phonenumber.value = TextEditingValue(text: jsondata['user_phone_number']);
  // email.value = TextEditingValue(text: jsondata['user_email_id']);
  // dateofbirth.value = TextEditingValue(text: jsondata['user_birth_date']);
  //     address.value = TextEditingValue(
  //         text: jsondata['user_address'] +
  //             " " +
  //             jsondata['user_local'] +
  //             " " +
  //             jsondata['user_district'] +
  //             " " +
  //             jsondata['user_state'] +
  //             " " +
  //             jsondata['user_pincode']);
  //     personalid.value = TextEditingValue(text: jsondata['user_id']);

  //     image = jsondata['user_profile_image'];
  //     print(image);
  //   }
  //   return dataload;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   // First.value = TextEditingValue(text: );
  //   // MyController.value = TextEditingValue(text: "Rajbhar");
  //   // phonenumber.value = TextEditingValue(text: "9630296544");
  //   // email.value = TextEditingValue(text: "manjeetrajbhar89@gmail.com");
  //   // dateofbirth.value = TextEditingValue(text: "25/07/2001");
  //   // address.value =
  //   //     TextEditingValue(text: "Suman Colony Mhow Indore Madhay Pradesh");
  //   // personalid.value = TextEditingValue(text: "24825");

  //   // fetchjson().then((value) {
  //   //   setState(() {
  //   //     profileadd.addAll(value);
  //   //   });
  //   // });
  //   future:
  //   getalldata();
  // }
  bool colorcheckrue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.colorandmaking.toString());

    if (colorcheckrue == false) {
      ColorAndMaking();
    }

    petname.value = TextEditingValue(text: widget.petnames);
    image.value = TextEditingValue(text: widget.image);
    if (widget.sex == "1")
      sex.value = TextEditingValue(text: "Male");
    else
      sex.value = TextEditingValue(text: "Female");

    registration.value = TextEditingValue(text: widget.registernumber);
    dateofbirth.value = TextEditingValue(text: widget.dateofbirth);
    breed.value = TextEditingValue(text: widget.breed);

    IDs = widget.id;
  }

  ColorAndMaking() async {
    String Color = widget.colorandmaking.toString();
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    final uri = "https://www.inkc.in/api/dog/dog_color_marking_list";

    Map<String, String> requestHeaders = {'Usertoken': token, 'Userid': userid};

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    List hawai = data['data'];
    //print(hawai.length);

    // List che = [];

    for (int i = 0; i < hawai.length; i++) {
      String color =
          hawai[i].toString().replaceAll("{", "").replaceAll("}", "");
      String making = color.toString().replaceAll(":", ",");
      List che = making.toString().split(",");
      // print(che.toString());

      for (int j = 0; j < che.length; j++) {
        // print(che[j]);
        if (widget.colorandmaking.toString() == che[j].toString().trim()) {
          print(" chal na" + che[j + 4].toString());
          setState(() {
            colorandmaking.value =
                TextEditingValue(text: che[j + 4].toString());
            colorcheckrue = true;
          });
          break;
        }
        //
      }
      //print(widget.colorandmaking.toString());
    }
  }

  bool showPassword = false;

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
              title: Text(
                widget.petnames.toString(),
                style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Color.fromARGB(255, 223, 71, 45), // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                    fontSize: 14.sp,
                    decorationColor: Colors.red,
                    color: Color.fromARGB(255, 194, 97, 33),
                    // color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    // Text(
                    //   "My Profile",
                    //   style:
                    //       TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130.sp,
                            height: 130.sp,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://www.inkc.in/${widget.image}"),
                                fit: BoxFit.cover, //change image fill type
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 0.sp,
                          //   right: 0.sp,
                          //   child: Container(
                          //     height: 40.sp,
                          //     width: 40.sp,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       border: Border.all(
                          //         width: 4,
                          //         color:
                          //             Theme.of(context).scaffoldBackgroundColor,
                          //       ),
                          //       color: Colors.black,
                          //     ),
                          //     // child: InkWell(
                          //     //   onTap: () {
                          //     //     EditSlide(context);
                          //     //   },
                          //     child: Icon(
                          //       Icons.edit,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 0, right: 8),
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 40.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.black,
                        ),
                        child: InkWell(
                            onTap: () {
                              EditSlide(context);
                            },
                            child: Image.asset(
                              'assets/file3.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                      // Positioned(
                      //   bottom: 0.sp,
                      //   right: 0.sp,
                      //   child: Container(
                      //     height: 40.sp,
                      //     width: 40.sp,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //         width: 4,
                      //         color: Theme.of(context).scaffoldBackgroundColor,
                      //       ),
                      //       color: Colors.black,
                      //     ),
                      //     child: InkWell(
                      //       onTap: () {
                      //         // EditSlide(context);
                      //       },
                      //       child: Icon(
                      //         Icons.edit,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                controller: petname,
                                enabled: false,
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Pet Name',
                                  hintText: '',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                controller: breed,
                                enabled: false,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Breed Of Dogs',
                                  hintText: '',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                controller: sex,
                                enabled: false,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Sex',
                                  hintText: 'Rajbhar',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                controller: dateofbirth,
                                enabled: false,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.date_range),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Date of Birth',
                                  hintText: 'Rajbhar',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                maxLines: null,
                                controller: registration,
                                enabled: false,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.sp)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.green),
                                  ),
                                  labelText: 'Registration Number',
                                  hintText: 'Rajbhar',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: colorandmaking.text.toString() == null
                                  ? TextField(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      maxLines: null,
                                      controller: colorandmaking,
                                      enabled: false,
                                      // obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.sp)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.green),
                                        ),
                                        labelText: 'Color and Making',
                                        hintText: '-',
                                      ),
                                    )
                                  : TextField(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      maxLines: null,
                                      controller: colorandmaking,
                                      enabled: false,
                                      // obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.sp)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.green),
                                        ),
                                        labelText: ' - ',
                                        hintText: '-',
                                      ),
                                    ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void EditSlide(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
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
            margin: EdgeInsets.all(5.sp),
            height: 220.sp,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    height: 150.sp,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
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
                    margin: EdgeInsets.all(15),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MicroChipDetails(
                                      pname: petname.text.toString(),
                                      pic: widget.image,
                                      rcnumber: widget.registernumber,
                                    )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            height: 80.0.sp,
                            width: 80.0.sp,
                            child: Image.asset("assets/vetservices.png"),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),

                              //set border radius to 50% of square height and width
                              // image: DecorationImage(
                              //   image: AssetImage("assets/chip.jpeg"),
                              //   fit: BoxFit.fill, //change image fill type
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Text(
                            'Microchip Details',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    // blurRadius: 5.0, // shadow blur
                                    color: ui.Color.fromARGB(
                                        255, 2, 1, 10), // shadow color
                                    // offset: Offset(2.0,
                                    //     2.0), // how much shadow will be shown
                                  ),
                                ],
                                fontWeight: FontWeight.bold,
                                // foreground: Paint()
                                //   ..shader = ui.Gradient.linear(
                                //     const Offset(0, 20),
                                //     const Offset(170, 20),
                                //     <Color>[
                                //       Color.fromARGB(255, 235, 15, 15),
                                //       Color.fromARGB(255, 22, 26, 226),
                                //     ],
                                //   ),
                                fontSize: 11.sp),
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
                Card(
                  child: Container(
                    height: 150.sp,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
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
                    margin: EdgeInsets.all(15),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NonRegisterNote(
                                      id: IDs,
                                    )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            height: 80.0.sp,
                            width: 80.0.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),

                              //set border radius to 50% of square height and width
                              image: DecorationImage(
                                image: AssetImage("assets/note.png"),
                                fit: BoxFit.fill, //change image fill type
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 20),
                          child: Text(
                            ' Add Notes',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    // blurRadius: 5.0, // shadow blur
                                    color: ui.Color.fromARGB(
                                        255, 2, 1, 10), // shadow color
                                    // offset: Offset(2.0,
                                    //     2.0), // how much shadow will be shown
                                  ),
                                ],
                                fontWeight: FontWeight.bold,
                                // foreground: Paint()
                                //   ..shader = ui.Gradient.linear(
                                //     const Offset(0, 20),
                                //     const Offset(150, 20),
                                //     <Color>[
                                //       Color.fromARGB(255, 235, 15, 15),
                                //       Color.fromARGB(255, 22, 26, 226),
                                //     ],
                                //   ),
                                fontSize: 13.sp),
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
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: InkWell(
                //     onTap: () {
                //       // print(widget.image);
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (BuildContext context) => MicroChipDetails(
                //                 pname: petname.text.toString(),
                //                 pic: widget.image,
                //                 rcnumber: widget.registernumber,
                //               )));
                //     },
                //     child: Text(
                //       'Microchip Details',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold, fontSize: 15.sp),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: InkWell(
                //     onTap: () {},
                //     child: Text(
                //       'Death Report',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold, fontSize: 15.sp),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (BuildContext context) => NonRegisterNote(
                //                 id: IDs,
                //               )));
                //     },
                //     child: Text(
                //       'Add Note',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold, fontSize: 15.sp),
                //     ),
                //   ),
                // )
              ],
            ),
          );
        });
  }
}
