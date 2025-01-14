import 'dart:convert';
import 'dart:io';
// import 'package:eosdart/eosdart.darts' as eos;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/image_helper.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

final imagehelper = ImageHelper();

class LitterPuppyRegistration extends StatefulWidget {
  String sire, dam, dob, country, puppy, petcolordid;
  String image;
  String sirefrontcerificate;
  String sirebackcerificate;

  String damfrontcerificate;
  String dambackcerificate;
  String siretranferform;

  String siretranform;
  String damtranform;

  LitterPuppyRegistration({
    super.key,
    required this.sire,
    required this.dam,
    required this.dob,
    required this.country,
    required this.puppy,
    required this.petcolordid,
    required this.image,
    required this.sirefrontcerificate,
    required this.sirebackcerificate,
    required this.damfrontcerificate,
    required this.dambackcerificate,
    required this.siretranferform,
    required this.siretranform,
    required this.damtranform,
  });

  @override
  State<LitterPuppyRegistration> createState() =>
      _LitterPuppyRegistrationState();
}

var k = 1;

class _LitterPuppyRegistrationState extends State<LitterPuppyRegistration> {
  bool showSpinner = false;

  final List<TextEditingController> _name = [];
  final List<TextEditingController> _dateofbirth = [];
  final List _gender = [];

  String? gender, gender1, gender2;
  List chinchan = [];
  String? prifixdata = "1";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // getColorAndMaking();
    insertvalue();
    for (var i = 0; i < int.parse(widget.puppy.toString()); i++) {
      _addFiled();
      chinchan.add(i);
      _gender.add(i);
    }
  }

  var Lakho = [];

  bool checkvisible = false;

  List<Map<String, String>> keyValueList = [];

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
          Uri.parse("https://new-demo.inkcdogs.org/api/user/kennel_details"),
          headers: requestHeaders);

      final body = json.decode(res.body);

      keyValueList.clear();
      products.clear();

      if (body['data']['kennel_second_owner'].toString() == "false") {
        //checkvisible = false;
        print("doremon");
      } else {
        List list = body['data']['kennel_second_owner'];
        for (int i = 0; i < list.length; i++) {
          var productMap = {
            body['data']['kennel_second_owner'][i]['kennel_id'].toString():
                body['data']['kennel_second_owner'][i]['kennel_name']
                    .toString(),
          };
          keyValueList.add(productMap);
          // print(keyValueList);
        }
        if (checkvisible == false) {
          setState(() {
            checkvisible = true;
          });
        }
      }

      if (body['data']['kennel_info'].toString() == "false") {
        //checkvisible = false;
      } else {
        // checkvisible = false;

        keyValueList.add({
          body['data']['kennel_info']['kennel_id'].toString():
              body['data']['kennel_info']['kennel_name'].toString()
        });
        //   = [
        //   {
        //     body['data']['kennel_info']['kennel_id'].toString():
        //         body['data']['kennel_info']['kennel_name'].toString()
        //   }
        // ];
        // print(keyValueList);
        if (checkvisible == false) {
          setState(() {
            checkvisible = true;
          });
        }
      }
      print(keyValueList);

      //print(list);
    } catch (e) {}

    //throw Exception('Error fetch data');
  }

  // Future<List<KennelNameInfoModel>> KennelNameget() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   String userid = sharedprefrence.getString("Userid")!;
  //   String token = sharedprefrence.getString("Token")!;
  //   Map<String, String> requestHeaders = {
  //     // 'Content-type': 'application/json',
  //     // 'Accept': 'application/json',
  //     'Usertoken': token,
  //     'Userid': userid
  //   };

  //   try {
  //     final res = await http.post(
  //         Uri.parse("https://new-demo.inkcdogs.org/api/user/kennel_details"),
  //         headers: requestHeaders);

  //     var body = json.decode(res.body);
  //     var list = body['data']['kennel_info'] as List;
  //     var listarray = body['data']['kennel_second_owner'] as List;

  //     //Lakho.add(body['data']['kennel_info']['kennel_name'].toString());

  //     if (res.statusCode == 200) {
  //       return list.map((e) {
  //         final map = e as Map<String, dynamic>;
  //         return KennelNameInfoModel(
  //           kennelId: map['kennel_id'],
  //           ownerUserId: map['owner_user_id'],
  //           isSecondOwner: map['is_second_owner'],
  //           secondOwnerId: map['second_owner_id'],
  //           kennelName: map['kennel_name'],
  //           kennelComment: map['kennel_comment'],
  //           kennelStatus: map['kennel_status'],
  //           isKennelNamePaid: map['is_kennel_name_paid'],
  //           kennelUpdatedOn: map['kennel_updated_on'],
  //           kennelCreatedOn: map['kennel_created_on'],
  //         );
  //       }).toList();
  //     }

  //     // if (res.statusCode == 200) {
  //     //   return listarray.map((e) {
  //     //     final map = e as Map<String, dynamic>;
  //     //     return KennelNameInfoModel(
  //     //       kennelId: map['kennel_id'],
  //     //       ownerUserId: map['owner_user_id'],
  //     //       isSecondOwner: map['is_second_owner'],
  //     //       secondOwnerId: map['second_owner_id'],
  //     //       kennelName: map['kennel_name'],
  //     //       kennelComment: map['kennel_comment'],
  //     //       kennelStatus: map['kennel_status'],
  //     //       isKennelNamePaid: map['is_kennel_name_paid'],
  //     //       kennelUpdatedOn: map['kennel_updated_on'],
  //     //       kennelCreatedOn: map['kennel_created_on'],
  //     //     );
  //     //   }).toList();
  //     // }
  //   } catch (e) {}

  //   throw Exception('Error fetch data');
  // }

  _addFiled() {
    setState(() {
      _name.add(TextEditingController());

      //_gender;
    });
  }

  TextEditingController SireNumber = TextEditingController();
  TextEditingController DamNumber = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController personalid = TextEditingController();

  bool SireNumberValidate = false;
  bool DamNumberValidate = false;
  bool DateValidate = false;
  bool datevalidate = false;

  bool sirevalide = false;
  String? sireString;

  GetAllSire(String text) async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/dog/get_sire_details";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {
        "sire_reg_number": text.toString(),
      },
    );
    var data = json.decode(responce.body);
    setState(() {
      sireString = data['data'];
      sirevalide = true;
      // sire.value = TextEditingValue(text: data['data']);
    });
  }

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
        dateofbirth.value =
            TextEditingValue(text: "${date.day}-${date.month}-${date.year}");
      });
    }
  }

  File? firstImage;
  final _firstpicker = ImagePicker();

  // Future getfirstImage() async {
  //   final pickedFilefirst = await _firstpicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 80);

  //   if (pickedFilefirst != null) {
  //     firstImage = File(pickedFilefirst.path);
  //     print(firstImage);

  //     setState(() {});
  //   } else {
  //     print('no image  selected');
  //   }
  // }

  //var selectedvalue;
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
          Uri.parse(
              "https://new-demo.inkcdogs.org/api/dog/dog_color_marking_list"),
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

    print(
        "$firstImage--${widget.image}--${widget.sirefrontcerificate}--${widget.sirebackcerificate}");

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

    print(puppyname);

    String colo = ok.toString();
    colo.replaceAll("[", "").replaceAll("]", "");

    String Gend = Gender.toString();
    Gend.replaceAll("[", "").replaceAll("]", "");

    // SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    // String KennelName = sharedprefrence.getString("KennelName")!;

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      String userid = sharedprefrence.getString("Userid")!;
      String token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formDatas = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(firstImage!.path,
            filename: "${now.second}.jpg"),
        'sire_reg_number': widget.sire,
        'dam_reg_number': widget.dam.toString(),
        'pet_sub_category_id': widget.petcolordid.toString(),
        'pet_gender[]': Gend,
        'birth_date': widget.dob.toString(),
        'pet_name[]': puppyname,
        'color_marking[]': colo,
        'sire_front_side_certificate': widget.sirefrontcerificate.toString(),
        'sire_back_side_certificate': widget.sirebackcerificate.toString(),
        // if (widget.sirefrontcerificate.toString() != "null")
        // 'sire_front_side_certificate': await MultipartFile.fromFile(
        //     widget.sirefrontcerificate!.path,
        //     filename: "${now.second}.jpg"),
        // if (widget.sirebackcerificate.toString() != "null")
        // 'sire_back_side_certificate': await MultipartFile.fromFile(
        //     widget.sirebackcerificate!.path,
        //     filename: "${now.second}.jpg"),
        // if (widget.image.toString() != "null")
        //   'stud_agreement_form': await MultipartFile.fromFile(
        //       widget.image!.path,
        //       filename: "${now.second}.jpg"),
      });

      Response response = await dio.post(
          'https://new-demo.inkcdogs.org/api/dog/litter_registration_new',
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
        //print('something worng');
      }

      // images = File(pickedFile.path);
    } catch (e) {
      print('no image  selected false');
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
      child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Sizer(builder: (context, orientation, deviceType) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 223, 39, 39)),
                  onPressed: () => Navigator.pop(context, true),
                ),
                title: Text(
                  'Litter Registration',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0.sp, // shadow blur
                          color: const Color.fromARGB(
                              255, 223, 71, 45), // shadow color
                          offset: const Offset(
                              2.0, 2.0), // how much shadow will be shown
                        ),
                      ],
                      fontSize: 23.sp,
                      decorationColor: Colors.red,
                      color: const Color.fromARGB(255, 194, 97, 33),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  child: Container(
                    child: ListView(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Upload Litter's Photograph with mother ",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 22, 21, 21),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp),
                                      ),
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 231, 11, 11),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xEBA020F0),
                                        radius: 64,
                                        foregroundImage: firstImage != null
                                            ? FileImage(firstImage!)
                                            : null,
                                        child: const Text(
                                          "Select image",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 199, 7, 7),
                                      ),
                                      onPressed: () async {
                                        final files =
                                            await imagehelper.PickImage();
                                        if (files.isNotEmpty) {
                                          final cropperFile =
                                              await imagehelper.crop(
                                                  file: files.first,
                                                  cropStyle: CropStyle.circle);
                                          if (cropperFile != null) {
                                            setState(() => firstImage =
                                                File(cropperFile.path));
                                            print("justcheck$firstImage");
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                for (int i = 0; i < _name.length; i++)
                                  Card(
                                    margin: EdgeInsets.only(top: 15.sp),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "Puppy Number ${i + 1}",
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
                                                        BorderRadius.circular(
                                                            8)),
                                                label: const Text("Name")),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
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
                                                        groupValue: _gender[i]
                                                            .toString(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _gender[i] = value
                                                                .toString();
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
                                                            fontSize: 10.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: "0",
                                                        groupValue: _gender[i]
                                                            .toString(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            // _gender[i] = value;
                                                            _gender[i] = value
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
                                                            fontSize: 10.sp),
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
                                            "Color and Marking",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 12.sp),
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
                                                  child:
                                                      DropdownButtonFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 30,
                                                                    right: 10),
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                          ),
                                                          hint: const Text(
                                                              'Select value'),
                                                          isExpanded: true,
                                                          // value: chinchan[i],
                                                          items: snapshot.data!
                                                              .map((e) {
                                                            return DropdownMenuItem(
                                                                value: e
                                                                    .colourId
                                                                    .toString(),
                                                                child: Text(
                                                                  e.colourName
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          95,
                                                                          46,
                                                                          46),
                                                                      fontSize:
                                                                          10.sp,
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
                                                return const CircularProgressIndicator();
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
                                        backgroundColor: const Color.fromARGB(
                                            255, 14, 41, 163),
                                        textStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromARGB(
                                                255, 241, 236, 236),
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      UpLoadData();
                                    },
                                    child: const Text(
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
          })),
    );
  }
}

// widget for dynamic text field
