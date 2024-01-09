import 'dart:convert';
import 'dart:io';
import 'package:eosdart/eosdart.dart' as eos;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/drop_dow_kennel_name_info.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/dropdownmodel/drop_down_second_owner_kennel_name.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class LitterRegistration extends StatefulWidget {
  String value, dob;
  LitterRegistration({
    required this.value,
    required this.dob,
  });

  @override
  State<LitterRegistration> createState() => _LitterRegistrationState();
}

var k = 1;

class _LitterRegistrationState extends State<LitterRegistration> {
  bool showSpinner = false;

  List<TextEditingController> _name = [];
  List<TextEditingController> _dateofbirth = [];
  List _gender = [];

  String? gender, gender1, gender2;
  List chinchan = [];
  String? prifixdata = "1";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // getColorAndMaking();
    // insertvalue();
    for (var i = 0; i < int.parse(widget.value.toString()); i++) {
      _addFiled();
      chinchan.add(i);
      _gender.add(i);
    }
  }

  var Lakho = [];

  Future<List<KennelNameInfoModel>> KennelNameget() async {
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
          Uri.parse("https://new-demo.inkcdogs.org/api/user/kennel_details"),
          headers: requestHeaders);

      var body = json.decode(res.body);
      var list = body['data']['kennel_info'] as List;
      var listarray = body['data']['kennel_second_owner'] as List;

      //Lakho.add(body['data']['kennel_info']['kennel_name'].toString());

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return KennelNameInfoModel(
            kennelId: map['kennel_id'],
            ownerUserId: map['owner_user_id'],
            isSecondOwner: map['is_second_owner'],
            secondOwnerId: map['second_owner_id'],
            kennelName: map['kennel_name'],
            kennelComment: map['kennel_comment'],
            kennelStatus: map['kennel_status'],
            isKennelNamePaid: map['is_kennel_name_paid'],
            kennelUpdatedOn: map['kennel_updated_on'],
            kennelCreatedOn: map['kennel_created_on'],
          );
        }).toList();
      }

      // if (res.statusCode == 200) {
      //   return listarray.map((e) {
      //     final map = e as Map<String, dynamic>;
      //     return KennelNameInfoModel(
      //       kennelId: map['kennel_id'],
      //       ownerUserId: map['owner_user_id'],
      //       isSecondOwner: map['is_second_owner'],
      //       secondOwnerId: map['second_owner_id'],
      //       kennelName: map['kennel_name'],
      //       kennelComment: map['kennel_comment'],
      //       kennelStatus: map['kennel_status'],
      //       isKennelNamePaid: map['is_kennel_name_paid'],
      //       kennelUpdatedOn: map['kennel_updated_on'],
      //       kennelCreatedOn: map['kennel_created_on'],
      //     );
      //   }).toList();
      // }
    } catch (e) {}

    throw Exception('Error fetch data');
  }

  _addFiled() {
    setState(() {
      _name.add(TextEditingController());

      //_gender;
    });
  }

  TextEditingController SireNumber = new TextEditingController();
  TextEditingController DamNumber = new TextEditingController();
  TextEditingController dateofbirth = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController personalid = new TextEditingController();

  bool SireNumberValidate = false;
  bool DamNumberValidate = false;
  bool DateValidate = false;
  bool datevalidate = false;

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
            text: date.day.toString() +
                "-" +
                date.month.toString() +
                "-" +
                date.year.toString());
      });
    }
  }

  File? firstImage;
  final _firstpicker = ImagePicker();

  Future getfirstImage() async {
    final pickedFilefirst = await _firstpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFilefirst != null) {
      firstImage = File(pickedFilefirst.path);
      print(firstImage);

      setState(() {});
    } else {
      print('no image  selected');
    }
  }

  var selectedvalue;
  var selectedid;

  var selectedvaluesecond;
  var selectedidsecond;

  var colorid;
  var colorname;

  Future<List<ColorAndMaking>> ColorAndMakingfatch() async {
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
          Uri.parse("https://new-demo.inkcdogs.org/api/dog/dog_color_marking_list"),
          headers: requestHeaders);

      final body = json.decode(res.body);

      var list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return ColorAndMaking(
            colourId: map['colour_id'],
            colourCode: map['colour_code'],
            colourName: map['colour_name'],
            colourStatus: map['colour_status'],
            colourUpdatedOn: map['colour_updated_on'],
            colourCreatedOn: map['colour_created_on'],
          );
        }).toList();
      }
    } catch (e) {}

    throw Exception('Error fetch data');
  }

  UpLoadData() async {
    String sir = SireNumber.text;
    String dam = DamNumber.text;

    List thik = [];
    List ok = [];
    List Gender = [];
    for (int i = 0; i < _name.length; i++) {
      thik.add(_name[i].text.toString());
      ok.add(chinchan[i].toString());
      Gender.add(_gender[i].toString());
    }

    String puppyname = thik.toString();
    puppyname.replaceAll("[", "").replaceAll("]", "");

    String colo = ok.toString();
    colo.replaceAll("[", "").replaceAll("]", "");

    String Gend = Gender.toString();
    Gend.replaceAll("[", "").replaceAll("]", "");

    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String KennelName = sharedprefrence.getString("KennelName")!;

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      String userid = sharedprefrence.getString("Userid")!;
      String token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formDatas = FormData.fromMap({
        'upload_microchip_document': await MultipartFile.fromFile(
            firstImage!.path,
            filename: now.second.toString() + ".jpg"),
        'sire_reg_number': sir,
        // 'dam_reg_number': widget.damnumber.toString(),
        'pet_gender': Gend,
        'birth_date': widget.dob.toString(),
        'pet_name': puppyname,
        'color_marking': colo,
        'kennel_name': selectedvalue.toString(),
        'kennel_name_pre': prifixdata,
      });

      Response response =
          await dio.post('https://www.inkc.in/api/dog/litter_registration',
              data: formDatas,
              options: Options(headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                'Usertoken': token,
                'Userid': userid
              }));

      if (response.statusCode == 200) {
        print(response.toString());
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Success')));
      } else {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')));
        print('something worng');
      }

      // images = File(pickedFile.path);
    } catch (e) {
      print('no image  selected false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Sizer(builder: (context, orientation, deviceType) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 223, 39, 39)),
                onPressed: () => Navigator.pop(context, true),
              ),
              title: Text(
                'Litter Registration',
                style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 10.0.sp, // shadow blur
                        color: Color.fromARGB(255, 223, 71, 45), // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                    fontSize: 23.sp,
                    decorationColor: Colors.red,
                    color: Color.fromARGB(255, 194, 97, 33),
                    // color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                child: Container(
                  child: ListView(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sire's INKC Registration Number ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: SireNumber,
                                  keyboardType: TextInputType.number,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText:
                                        "Sire's INKC Registration Number",
                                    errorText: SireNumberValidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Upload Litter's Photograph with mother ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10.sp),
                                child: firstImage == null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 60.sp, right: 60.sp),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 173, 4, 4),
                                          ),
                                          onPressed: () async {
                                            getfirstImage();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Pick Image',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          getfirstImage();
                                        },
                                        child: Column(
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
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset: Offset(0, 10))
                                                  ],
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                    image: FileImage(
                                                        File(firstImage!.path)
                                                            .absolute),
                                                    fit: BoxFit.cover,
                                                  )
                                                  // image: DecorationImage(
                                                  //   image: NetworkImage(
                                                  //       "https://new-demo.inkcdogs.org/${image}"),
                                                  //   fit: BoxFit.cover, //change image fill type
                                                  // ),
                                                  ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 223, 20, 20),
                                              ),
                                              onPressed: () async {
                                                getfirstImage();
                                              },
                                              child: Text(
                                                'Change Image',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Kennel Name ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 231, 11, 11),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),

                              // DropdownButtonFormField(
                              //     decoration: InputDecoration(
                              //       contentPadding: const EdgeInsets.only(
                              //           left: 30, right: 10),
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(10))),
                              //     ),
                              //     hint: Text('Select value'),
                              //     isExpanded: true,
                              //     value: selectedvalue,
                              //     items: Lakho.map((e) {
                              //       return DropdownMenuItem(
                              //           value: e.toString(),
                              //           child: Text(
                              //             e.toString(),
                              //             style: TextStyle(
                              //                 color: Color.fromARGB(
                              //                     255, 95, 46, 46),
                              //                 fontSize: 12.sp,
                              //                 fontWeight: FontWeight.bold),
                              //           ));
                              //     }).toList(),
                              //     onChanged: (var value) {
                              //       // selectedvalue = value;
                              //       //selectedid = value;
                              //       setState(() {
                              //         selectedvalue = value!;
                              //       });
                              //     }),

                              FutureBuilder<List<KennelNameInfoModel>>(
                                  future: KennelNameget(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 30, right: 10),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                            hint: Text('Select value'),
                                            isExpanded: true,
                                            // value: chinchan[i],
                                            items: snapshot.data!.map((e) {
                                              return DropdownMenuItem(
                                                  value: e.kennelId.toString(),
                                                  child: Text(
                                                    e.kennelName.toString(),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 95, 46, 46),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              // colorid = value;
                                              // colorname = value;
                                              // chinchan[i] = value;

                                              setState(() {});
                                            }),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),

                              // FutureBuilder<List<SecondOwneModel>>(
                              //     future: SecondOwner(),
                              //     builder: (context, snapshot) {
                              //       if (snapshot.hasData) {
                              //         return Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: DropdownButtonFormField(
                              //               decoration: InputDecoration(
                              //                 contentPadding: const EdgeInsets.only(
                              //                     left: 30, right: 10),
                              //                 border: OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(10))),
                              //               ),
                              //               hint: Text('Select value'),
                              //               isExpanded: true,
                              //               value: selectedvaluesecond,
                              //               items: snapshot.data!.map((e) {
                              //                 return DropdownMenuItem(
                              //                     value: e.kennelId.toString(),
                              //                     child: Text(
                              //                       e.kennelName.toString(),
                              //                       style: TextStyle(
                              //                           color: Color.fromARGB(
                              //                               255, 95, 46, 46),
                              //                           fontSize: 12.sp,
                              //                           fontWeight:
                              //                               FontWeight.bold),
                              //                     ));
                              //               }).toList(),
                              //               onChanged: (value) {
                              //                 selectedvaluesecond = value;
                              //                 selectedidsecond = value;
                              //                 setState(() {});
                              //               }),
                              //         );
                              //       } else {
                              //         return CircularProgressIndicator();
                              //       }
                              //     }),

                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Dog name with kennel name',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: Text(
                                                '* ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color.fromARGB(
                                                        255, 201, 9, 9),
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: "0",
                                              groupValue: prifixdata.toString(),
                                              onChanged: (value) {
                                                setState(() {
                                                  prifixdata = value.toString();
                                                  // = value.toString();
                                                  // = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              'Prefix Kennel Name',
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
                                              groupValue: prifixdata.toString(),
                                              onChanged: (value) {
                                                setState(() {
                                                  // _gender[i] = value;
                                                  prifixdata = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              'Without Kennel Name',
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
                              for (int i = 0; i < _name.length; i++)
                                Card(
                                  margin: EdgeInsets.only(top: 15.sp),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Puppy Number " + (i + 1).toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _name[i],
                                          validator: (value) {
                                            if (value == "") {
                                              return "Please Enter Name.";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              label: const Text("Name")),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                child: Text(
                                                  'Gender',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      groupValue:
                                                          _gender[i].toString(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _gender[i] =
                                                              value.toString();
                                                          // = value.toString();
                                                          // = value.toString();
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      'Male',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 13.sp),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: "0",
                                                      groupValue:
                                                          _gender[i].toString(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          // _gender[i] = value;
                                                          _gender[i] =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      'Female',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 13.sp),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Color and Making",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                          // controller: _name[i],
                                          // validator: (value) {
                                          //   if (value == "") {
                                          //     return "Please Enter Name.";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          // decoration: InputDecoration(
                                          //     border: OutlineInputBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(8)),
                                          //     label:
                                          //         const Text("Color and Making")),
                                        ),
                                      ),

                                      FutureBuilder<List<ColorAndMaking>>(
                                          future: ColorAndMakingfatch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 30,
                                                              right: 10),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    hint: Text('Select value'),
                                                    isExpanded: true,
                                                    // value: chinchan[i],
                                                    items:
                                                        snapshot.data!.map((e) {
                                                      return DropdownMenuItem(
                                                          value: e.colourId
                                                              .toString(),
                                                          child: Text(
                                                            e.colourName
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        95,
                                                                        46,
                                                                        46),
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ));
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      colorid = value;
                                                      colorname = value;
                                                      chinchan[i] = value;

                                                      setState(() {});
                                                    }),
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          }),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: TextFormField(
                                      //     controller: _dateofbirth[i],
                                      //     validator: (value) {
                                      //       if (value == "") {
                                      //         return "Please Enter Date of birth .";
                                      //       } else {
                                      //         return null;
                                      //       }
                                      //     },
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius: BorderRadius.circular(8)),
                                      //         label: const Text("Date of birth ")),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 14, 41, 163),
                                      textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: const Color.fromARGB(
                                              255, 241, 236, 236),
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    UpLoadData();
                                  },
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              const Divider(),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}

// widget for dynamic text field
