import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/events/obidient.dart';
import 'package:inkc/image_helper.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final imagehelper = ImageHelper();

// class PedigreeDogRegistration extends StatelessWidget {
//   const PedigreeDogRegistration({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "profile UI",
//       home: _Pedigree_Dog_registration(),
//     );
//   }
// }

String userid = "";
String token = "";
String image = "";

class PedigreeDogRegistration extends StatefulWidget {
  String participate_event_id,
      is_participate_with_event,
      register_with_event,
      eventname,
      eventtype,
      eventstal,
      pariticaipate_for_event,
      register_for_event;

  PedigreeDogRegistration(
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
  _PedigreeDogRegistrationState createState() =>
      _PedigreeDogRegistrationState();
}

class _PedigreeDogRegistrationState extends State<PedigreeDogRegistration> {
  File? _image;
  TextEditingController sire = TextEditingController();
  TextEditingController dam = TextEditingController();
  TextEditingController Dogname = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController cowner = TextEditingController();

  // events

  bool checkvisible = true;
  String? stallReq = "0";
  bool stall_day_type = false;
  String StallDay = "1";
  String StallType = "0";

  List<Obideint> dataload = [];
  bool prebigner = false;
  bool bigner = false;
  bool novic = false;
  bool Texta = false;
  bool Textb = false;
  bool Textc = false;

  List obidient = [];

  FocusNode focusNode = FocusNode();

  bool showSpinner = false;

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

  String? gender = "0";
  String? AddCoOwner = "0";
  String? MicroRequired = "0";

  // color and making
  List colorandmakingList = [];
  var selectcolormarkingvalue;
  var selectcolormakingid;
  bool _isShowOff = false;

  Future<List<ColorAndMaking>> getColorAndMaking() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

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
      final list = body['data'] as List;

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

      // var datas = jsonDecode(res.body.toString());
      // data = datas['data'];
      setState(() {});
      //print(values.toString());
    } catch (e) {}

    throw Exception('Error fetch data');
  }

  // validator
  bool regisvalidate = false;
  bool kennelvalidate = false;
  bool dogvalidate = false;
  bool datevalidate = false;
  bool breedvalidate = false;
  bool gendervalidator = false;

  bool sirevalide = false;
  String? sireString;
  bool damvalide = false;
  String? DamString;

  uploadData(
      String obidientq, String stallReqq, String Dayq, String Typeq) async {
    // setState(() {
    //   showSpinner = true;
    // });

    String SIRE = sire.text.toString();
    String DAM = dam.text.toString();
    String DogName = Dogname.text.toString();
    String DOB = dateofbirth.text.toString();
    String Gender = gender.toString();
    String AddCoowner = AddCoOwner.toString();
    String MICRO = MicroRequired.toString();
    print(_image.toString());

    print(
        "i am here  sire = ${SIRE}, dam = ${DAM}, Dogname =${DogName}, DOB = ${DOB}, gender = ${Gender},Addcowner= ${AddCoowner} ,secondowner = ${cowner.text.toString()},micro = ${MICRO} , colorand making = ${selectcolormakingid}");
    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(_image!.path,
            filename: "${now.second}.jpg"),
        'pet_gender': Gender,
        'birth_date': DOB,
        'pet_name': DogName,
        if (cowner.text.toString() != "")
          'second_owner_id': cowner.text.toString(),
        'is_second_owner': AddCoOwner.toString(),
        'is_microchip_require': MICRO,
        'color_marking': selectcolormakingid,
        'dam_reg_number': DAM,
        'sire_reg_number': SIRE,
        'breded_country': counrty.text.toString(),
        "participate_event_id": widget.participate_event_id.toString(),
        "class_and_price[]": obidientq.toString(),
        "is_stall_required": stallReqq,
        "event_stall_day": Dayq,
        "event_stall_type": Typeq,
        "register_with_event": widget.register_for_event,
        "is_participate_with_event": widget.pariticaipate_for_event
      });
      print(
          "${"$Gender-$DOB-$DogName-${cowner.text}-$AddCoowner-$MICRO-" + selectcolormakingid}-$DAM-$SIRE");

      Response response = await dio.post(
          'https://new-demo.inkcdogs.org/api/dog/pedigree_dog_registration',
          data: formData,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Usertoken': token,
            'Userid': userid
          }));

      if (response.statusCode == 200) {
        print(response.toString());
        print(response.toString());
        setState(() {
          RefreshCart();
          showSpinner = false;
        });
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success...',
          text: 'SuccessFully Registered',
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SuccessFully Registered')));
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
      print(e.toString() + 'no image  selected false');
    }

    // print(ResNum +
    //     "-" +
    //     KennelId +
    //     "-" +
    //     DogName +
    //     "-" +
    //     DOB +
    //     "-" +
    //     Breed +
    //     "-" +
    //     Gender);

    // var first = new http.ByteStream(firstimages!.openRead());
    // first.cast();

    // var second = new http.ByteStream(secondimages!.openRead());
    // second.cast();

    // var thired = new http.ByteStream(thiredimages!.openRead());
    // thired.cast();

    // var lengthfirst = await firstimages!.length();
    // var lengthsecond = await secondimages!.length();
    // var lengththired = await thiredimages!.length();

    // var uri = Uri.parse("https://new-demo.inkcdogs.org/api/dog/non_inkc_registration");

    // var request = new http.MultipartRequest("POST", uri);

    // SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    // userid = sharedprefrence.getString("Userid")!;
    // token = sharedprefrence.getString("Token")!;

    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   'Usertoken': token,
    //   'Userid': userid
    // };

    // var multipartfirst =
    //     new http.MultipartFile('petfirstImage', first, lengthfirst);

    // var multipartsecond =
    //     new http.MultipartFile('front_side_certificate', second, lengthsecond);

    // var multiparthired =
    //     new http.MultipartFile('back_side_certificate', thired, lengththired);

    // request.headers.addAll(requestHeaders);
    // request.files.add(multipartfirst);
    // request.files.add(multipartsecond);
    // request.files.add(multiparthired);
    // request.fields["pet_name"] = "Dogname.text";
    // request.fields["pet_registration_number"] = '123';
    // request.fields["kennel_club_prefix"] = selectedid.toString();
    // request.fields["birth_date"] = "16-10-2023";
    // request.fields["pet_gender"] = gender.toString();
    // request.fields["pet_sub_category_id"] = selectedbreedid.toString();
    // add(multipart);
    // request.fields.add(multipart);
    // request.fields.add(multipart);
    // request.fields.add(multipart);

    //  var response = await request.send();

    // print(response.toString());

    // if (response.statusCode == 200) {
    //   setState(() {
    //     showSpinner = false;
    //   });
    //   print('Image Uploaded');
    // } else {
    //   print('Image failed');
    // }
  }

  // Country
  TextEditingController counrty = TextEditingController();
  bool countryvalidate = false;

  //RefreshCart
  RefreshCart() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/cart/cartready";

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

    print("${responce.body} Refresh");
  }

  GetAllDam(String text) async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    const uri = "https://new-demo.inkcdogs.org/api/dog/get_dam_details";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {
        "dam_reg_number": text.toString(),
      },
    );
    var data = json.decode(responce.body);
    setState(() {
      DamString = data['data'];
      damvalide = true;
      // sire.value = TextEditingValue(text: data['data']);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back,
                //       color: Color.fromARGB(255, 223, 39, 39)),
                //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: (BuildContext context) => AddDogInfo())),
                // ),
                title: const Column(
                  children: [
                    Text(
                      'Pedigree Dog Registration',
                      style: TextStyle(
                          fontSize: 16,
                          decorationColor: Color.fromARGB(255, 66, 47, 45),
                          color: Color.fromARGB(255, 48, 40, 35),
                          // color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(Both parents registered with INKC)',
                      style: TextStyle(
                          fontSize: 12,
                          decorationColor: Color.fromARGB(255, 66, 47, 45),
                          color: Color.fromARGB(255, 48, 40, 35),
                          // color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Sire's INKC Registration Number ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  onChanged: (value) {
                                    GetAllSire(sire.text.toString());
                                  },
                                  controller: sire,
                                  decoration: InputDecoration(
                                    filled: true,

                                    fillColor: Colors.white,

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    // labelText:
                                    //     "Sire's INKC Registration Number",
                                    hintText: "Sire's INKC Registration Number",
                                    errorText: regisvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: sirevalide,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    sireString.toString(),
                                    style: const TextStyle(
                                        color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Dam's INKC Registration Number ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  onChanged: (value) {
                                    GetAllDam(dam.text.toString());
                                  },
                                  controller: dam,
                                  decoration: InputDecoration(
                                    filled: true,

                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    // labelText: "Dam's INKC Registration Number",
                                    hintText: "Dam's INKC Registration Number",
                                    errorText: regisvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: damvalide,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DamString.toString(),
                                    style: const TextStyle(
                                        color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Add Co Owner ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                              Container(
                                margin: const EdgeInsets.only(top: 5),
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
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: "0",
                                                groupValue: AddCoOwner,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isShowOff = false;
                                                    AddCoOwner =
                                                        value.toString();
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
                                                groupValue: AddCoOwner,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isShowOff = true;
                                                    AddCoOwner =
                                                        value.toString();
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
                              Visibility(
                                  visible: _isShowOff,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 12),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Co Owner ID ",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 22, 21, 21),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextField(
                                          controller: cowner,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.sp)),
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.green),
                                            ),
                                            labelText: 'Co Owner ID',
                                            hintText: 'Co Owner ID',
                                            errorText: dogvalidate
                                                ? "Value Can't Be Empty"
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name of the dog ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: Dogname,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Name of the dog',
                                    hintText: 'Eg.Bruno',
                                    errorText: dogvalidate
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
                                      "Date of Birth ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      width: 160.sp,
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        onTap: () {},
                                        controller: dateofbirth,
                                        enabled: false,
                                        // obscureText: true,
                                        decoration: InputDecoration(
                                          filled: true,

                                          fillColor: Colors.white,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.sp)),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.green),
                                          ),
                                          labelText: 'Date of Birth',
                                          errorText: datevalidate
                                              ? "Value Can't Be Empty"
                                              : null,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 231, 25, 25),
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color.fromARGB(
                                                    255, 241, 236, 236),
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          selectDatePicker();
                                        },
                                        child: const Text(
                                          'Pick date',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Color and Marking ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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

                              FutureBuilder<List<ColorAndMaking>>(
                                  future: getColorAndMaking(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text("Error: ${snapshot.error}"));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text("No data found"));
                                    } else {
                                      // DropDownKennelName? selectedItem =
                                      //     findItemById(snapshot.data!, selectedId);

                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 8.0,
                                            left: 8,
                                            right: 8,
                                            bottom: 8),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: DropdownSearch<ColorAndMaking>(
                                            items: snapshot.data!,
                                            itemAsString:
                                                (ColorAndMaking? model) =>
                                                    model?.colourName ?? "",
                                            // selectedItem:
                                            //     snapshot.data![getcountry],
                                            onChanged:
                                                (ColorAndMaking? selectedItem) {
                                              setState(() {
                                                selectcolormakingid =
                                                    selectedItem?.colourId;
                                              });
                                              // setState(() {
                                              //   countrybool = true;
                                              //   widget.Stategetdata = "";
                                              //   widget.Districtgetdata = "";
                                              //   getcountry = int.parse(
                                              //           "${selectedItem?.countryId}") -
                                              //       1;

                                              //   setState(() {
                                              //     selectebreedvalue =
                                              //         selectedItem?.countryId;
                                              //     selectedbreedid =
                                              //         selectedItem?.countryId;

                                              //     _changeId(selectedbreedid);
                                              //   });
                                              // });
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                filled: true,

                                                fillColor: Colors.white,
                                                // labelText: "Select Color/Pattern",
                                                hintText: "Choose one",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              fit: FlexFit.loose,
                                              itemBuilder:
                                                  (context, item, isSelected) {
                                                return ListTile(
                                                  title: Text(
                                                    item.colourName ?? "",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 95, 46, 46),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                );
                                              },
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItem) {
                                              return Text(
                                                selectedItem?.colourName ?? "",
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 95, 46, 46),
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ); // Display the selected item's name
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                              // FutureBuilder<List<ColorAndMaking>>(
                              //     future: getColorAndMaking(),
                              //     builder: (context, snapshot) {
                              //       if (snapshot.hasData) {
                              //         return Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Container(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 5),
                              //             decoration: BoxDecoration(
                              //               border: Border.all(
                              //                   color: Colors.blueGrey),
                              //               borderRadius:
                              //                   BorderRadius.circular(5),
                              //             ),
                              //             child: DropdownButtonHideUnderline(
                              //               child: DropdownButton<String>(
                              //                 isExpanded: true,
                              //                 value: selectcolormarkingvalue,
                              //                 onChanged: (value) {
                              //                   setState(() {
                              //                     selectcolormarkingvalue =
                              //                         value;
                              //                     selectcolormakingid = value;
                              //                   });
                              //                 },
                              //                 hint: const Text('Select value'),
                              //                 items: snapshot.data!.map((e) {
                              //                   return DropdownMenuItem<String>(
                              //                     value: e.colourId.toString(),
                              //                     child: SizedBox(
                              //                       width: double
                              //                           .infinity, // Auto size based on content
                              //                       child: Text(
                              //                         e.colourName.toString(),
                              //                         style: TextStyle(
                              //                             color: const Color
                              //                                 .fromARGB(
                              //                                 255, 95, 46, 46),
                              //                             fontSize: 12.sp,
                              //                             fontWeight:
                              //                                 FontWeight.bold),
                              //                       ),
                              //                     ),
                              //                   );
                              //                 }).toList(),
                              //               ),
                              //             ),
                              //           ),
                              //           // DropdownButtonFormField(
                              //           //     decoration: InputDecoration(

                              //           //       contentPadding:
                              //           //           const EdgeInsets.only(
                              //           //               left: 30, right: 10),
                              //           //       border: OutlineInputBorder(
                              //           //           borderRadius: BorderRadius.all(
                              //           //               Radius.circular(10))),
                              //           //     ),
                              //           //     hint: Text('Select value'),
                              //           //     isExpanded: true,
                              //           //     value: selectcolormarkingvalue,
                              //           //     items: snapshot.data!.map((e) {
                              //           //       return DropdownMenuItem(
                              //           //           value: e.colourId.toString(),
                              //           //           child: Text(
                              //           //             e.colourName.toString(),
                              //           //             style: TextStyle(
                              //           //                 color: Color.fromARGB(
                              //           //                     255, 95, 46, 46),
                              //           //                 fontSize: 11.sp,
                              //           //                 fontWeight:
                              //           //                     FontWeight.bold),
                              //           //           ));
                              //           //     }).toList(),
                              //           //     onChanged: (value) {
                              //           //       selectcolormarkingvalue = value;
                              //           //       selectcolormakingid = value;
                              //           //       setState(() {});
                              //           //     }),
                              //         );
                              //       } else {
                              //         return const CircularProgressIndicator();
                              //       }
                              //     }),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sex of the dog ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                              Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  boxShadow: const [],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
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
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Male',
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
                                                value: "0",
                                                groupValue: gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender = value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Female',
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Country Bred In ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: counrty,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Country Bred in',
                                    hintText: 'Eg.India',
                                    errorText: countryvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Your dog’s photograph ",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                                      backgroundColor: const Color(0xEBA020F0),
                                      radius: 64,
                                      foregroundImage: _image != null
                                          ? FileImage(_image!)
                                          : null,
                                      child: const Text(
                                        "Select image",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 199, 7, 7),
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
                                          setState(() =>
                                              _image = File(cropperFile.path));
                                          print("justcheck$_image");
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
                              // Container(
                              //   child: firstImage == null
                              //       ? Container(
                              //           margin: EdgeInsets.only(
                              //               left: 60.sp, right: 60.sp),
                              //           child: ElevatedButton(
                              //             style: ElevatedButton.styleFrom(
                              //               backgroundColor:
                              //                   const Color.fromARGB(
                              //                       255, 182, 6, 6),
                              //             ),
                              //             onPressed: () async {
                              //               getfirstImage();
                              //             },
                              //             child: const Text(
                              //               'Pick Image',
                              //               style:
                              //                   TextStyle(color: Colors.white),
                              //             ),
                              //           ),
                              //         )
                              //       : GestureDetector(
                              //           onTap: () {
                              //             getfirstImage();
                              //           },
                              //           child: Column(
                              //             children: [
                              //               Container(
                              //                 width: 130.sp,
                              //                 height: 130.sp,
                              //                 decoration: BoxDecoration(
                              //                     border: Border.all(
                              //                         width: 4,
                              //                         color: Theme.of(context)
                              //                             .scaffoldBackgroundColor),
                              //                     boxShadow: [
                              //                       BoxShadow(
                              //                           spreadRadius: 2,
                              //                           blurRadius: 10,
                              //                           color: Colors.black
                              //                               .withOpacity(0.1),
                              //                           offset:
                              //                               const Offset(0, 10))
                              //                     ],
                              //                     shape: BoxShape.circle,
                              //                     image: DecorationImage(
                              //                       image: FileImage(
                              //                           File(firstImage!.path)
                              //                               .absolute),
                              //                       fit: BoxFit.cover,
                              //                     )
                              //                     // image: DecorationImage(
                              //                     //   image: NetworkImage(
                              //                     //       "https://new-demo.inkcdogs.org/${image}"),
                              //                     //   fit: BoxFit.cover, //change image fill type
                              //                     // ),
                              //                     ),
                              //               ),
                              //               ElevatedButton(
                              //                 style: ElevatedButton.styleFrom(
                              //                   backgroundColor:
                              //                       const Color.fromARGB(
                              //                           255, 196, 3, 3),
                              //                 ),
                              //                 onPressed: () async {
                              //                   getfirstImage();
                              //                 },
                              //                 child: const Text(
                              //                   'Change Image',
                              //                   style: TextStyle(
                              //                       color: Colors.white),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Microchip required ",
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
                              Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  boxShadow: const [],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: "1",
                                                groupValue: MicroRequired,
                                                onChanged: (value) {
                                                  setState(() {
                                                    MicroRequired =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes, I require a microchip for my dog',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "0",
                                                groupValue: MicroRequired,
                                                onChanged: (value) {
                                                  setState(() {
                                                    MicroRequired =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No, I don’t require a microchip for my dog',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                              ),

                              if (widget.participate_event_id != "")
                                EventDetails(context),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 23, 4, 190),
                                        textStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromARGB(
                                                255, 241, 236, 236),
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      String SIRE = sire.text.toString();
                                      String DAM = dam.text.toString();
                                      String DogName = Dogname.text.toString();
                                      String DOB = dateofbirth.text.toString();
                                      String Gender = gender.toString();
                                      String AddCoowner = AddCoOwner.toString();
                                      String MICRO = MicroRequired.toString();
                                      print(
                                          "$SIRE - $DAM - $DogName - $DOB - $Gender - $AddCoowner - $MICRO");

                                      if (SIRE == "") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please Enter SIRE Registration Number',
                                        );
                                      } else {
                                        if (DAM == "") {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text:
                                                'Please Enter DAM Registration Number',
                                          );
                                        } else {
                                          if (DogName == "") {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Oops...',
                                              text: 'Please Enter Dog Name',
                                            );
                                          } else {
                                            if (DOB == "") {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: 'Oops...',
                                                text:
                                                    'Please Select Date of birth',
                                              );
                                            } else {
                                              if (_image.toString() == "null") {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.error,
                                                  title: 'Oops...',
                                                  text: 'Please Select Image',
                                                );
                                              } else {
                                                if (AddCoowner == "0") {
                                                  // uploadData(
                                                  //     obidient.toString(),
                                                  //     stallReq.toString(),
                                                  //     Day,
                                                  //     Type);
                                                  // // print(SIRE +
                                                  // //     " - " +
                                                  // //     DAM +
                                                  // //     " - " +
                                                  // //     DogName +
                                                  // //     " - " +
                                                  // //     DOB +
                                                  // //     " - " +
                                                  // //     Gender +
                                                  // //     " - " +
                                                  // //     AddCoowner +
                                                  // //     " - " +
                                                  // //     MICRO);

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

                                                  {
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
                                                        widget.eventtype
                                                                .toString() ==
                                                            "2") {
                                                      QuickAlert.show(
                                                        context: context,
                                                        type: QuickAlertType
                                                            .error,
                                                        title: 'Oops...',
                                                        text:
                                                            'Please Select atlest 2 box',
                                                      );
                                                    } else {
                                                      uploadData(
                                                          obidient.toString(),
                                                          stallReq.toString(),
                                                          Day,
                                                          Type);
                                                    }
                                                  }
                                                } else {
                                                  if (cowner.text.toString() ==
                                                      "") {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type:
                                                          QuickAlertType.error,
                                                      title: 'Oops...',
                                                      text:
                                                          'Please Enter Co owner Id',
                                                    );
                                                  } else {
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

                                                    {
                                                      if (stallReq == "0") {
                                                        //  print("sukriya");
                                                        Day = "";
                                                        Type = "";
                                                      } else {
                                                        Day = StallDay;
                                                        Type = StallType;
                                                      }

                                                      //obidient.length;
                                                      if (obidient.length <=
                                                              1 &&
                                                          widget.eventtype
                                                                  .toString() ==
                                                              "2") {
                                                        QuickAlert.show(
                                                          context: context,
                                                          type: QuickAlertType
                                                              .error,
                                                          title: 'Oops...',
                                                          text:
                                                              'Please Select atlest 2 box',
                                                        );
                                                      } else {
                                                        uploadData(
                                                            obidient.toString(),
                                                            stallReq.toString(),
                                                            Day,
                                                            Type);
                                                      }
                                                    }
                                                    // uploadData();
                                                    // print(SIRE +
                                                    //     " - " +
                                                    //     DAM +
                                                    //     " - " +
                                                    //     DogName +
                                                    //     " - " +
                                                    //     DOB +
                                                    //     " - " +
                                                    //     Gender +
                                                    //     " - " +
                                                    //     AddCoowner +
                                                    //     " - " +
                                                    //     MICRO +
                                                    //     " - " +
                                                    //     "lundo dnace");
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }

                                      // if (dog.toString().isEmpty) {
                                      //   setState(() {
                                      //     dogvalidate = Dogname.text.isEmpty;
                                      //   });
                                      // } else if (registernum.toString().isEmpty) {
                                      //   setState(() {
                                      //     regisvalidate =
                                      //         Registornumber.text.isEmpty;
                                      //   });
                                      // } else if (kenel.toString().isEmpty) {
                                      //   setState(() {
                                      //     kennelvalidate = selectedid.text.isEmpty;
                                      //   });
                                      // } else if (breed.toString().isEmpty) {
                                      //   setState(() {
                                      //     breedvalidate =
                                      //         selectedbreedid.text.isEmpty;
                                      //   });
                                      // } else if (date.toString().isEmpty) {
                                      //   setState(() {
                                      //     datevalidate = dateofbirth.text.isEmpty;
                                      //   });
                                      // } else if (genders.toString().isEmpty) {
                                      //   setState(() {
                                      //     gendervalidator =
                                      //         gender.toString().isEmpty;
                                      //   });
                                      // } else {}
                                      // String kennelname = selectedid;
                                      // String dogid = selectedbreedid;
                                      print(gender.toString());

                                      // uploadData();
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Visibility EventDetails(BuildContext context) {
    return Visibility(
      visible: checkvisible,
      child: Column(
        children: [
          if (widget.eventtype.toString() == "2")
            Visibility(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Class (Select at least two option.)",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 22, 21, 21),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ), //SizedBox
                        const Text(
                          'Pre-Beginner ',
                          style: TextStyle(fontSize: 15.0),
                        ), //Text
                        const SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                        Checkbox(
                          value: prebigner,
                          onChanged: (value) {
                            setState(() {
                              prebigner = value!;
                              // obidient.add(value);
                              print(prebigner);
                            });
                          },
                        ), //Checkbox
                      ], //<Widget>[]
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ), //SizedBox
                        const Text(
                          'Beginner ',
                          style: TextStyle(fontSize: 15.0),
                        ), //Text
                        const SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                        Checkbox(
                          value: bigner,
                          onChanged: (value) {
                            setState(() {
                              bigner = value!;
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
                          const SizedBox(
                            width: 10,
                          ), //SizedBox
                          const Text(
                            'Novice ',
                            style: TextStyle(fontSize: 15.0),
                          ), //Text
                          const SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: novic,
                            onChanged: (value) {
                              setState(() {
                                novic = value!;
                                // obidient.add(value);
                              });
                            },
                          ), //Checkbox
                        ], //<Widget>[]
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ), //SizedBox
                          const Text(
                            'Test-A ',
                            style: TextStyle(fontSize: 15.0),
                          ), //Text
                          const SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: Texta,
                            onChanged: (value) {
                              setState(() {
                                Texta = value!;
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
                          const SizedBox(
                            width: 10,
                          ), //SizedBox
                          const Text(
                            'Test-B ',
                            style: TextStyle(fontSize: 15.0),
                          ), //Text
                          const SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: Textb,
                            onChanged: (value) {
                              setState(() {
                                Textb = value!;
                                // obidient.add(value);
                              });
                            },
                          ), //Checkbox
                        ], //<Widget>[]
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ), //SizedBox
                          const Text(
                            'Test-C ',
                            style: TextStyle(fontSize: 15.0),
                          ), //Text
                          const SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: Textc,
                            onChanged: (value) {
                              setState(() {
                                Textc = value!;
                                //  obidient.add(value);
                              });
                            },
                          ), //Checkbox
                        ], //<Widget>[]
                      ),
                    ],
                  ),
                ),
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
                            color: const Color.fromARGB(255, 22, 21, 21),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0),
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
                          padding: const EdgeInsets.only(top: 0),
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
                      padding: const EdgeInsets.only(top: 20.0, left: 12),
                      child: Row(
                        children: [
                          Text(
                            "stall Day          ",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 22, 21, 21),
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
                                  padding: const EdgeInsets.only(left: 18.0),
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
                                  padding: const EdgeInsets.only(left: 10.0),
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
                      padding: const EdgeInsets.only(top: 20.0, left: 12),
                      child: Row(
                        children: [
                          Text(
                            "Stall Type             ",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 22, 21, 21),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 0),
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
                              padding: const EdgeInsets.only(top: 0),
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
                                                StallType = value.toString();
                                              });
                                            },
                                          ),
                                          Text(
                                            'FAN',
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
                                            groupValue: StallType,
                                            onChanged: (value) {
                                              setState(() {
                                                // _isShowOff = true;
                                                StallType = value.toString();
                                              });
                                            },
                                          ),
                                          Text(
                                            'AC',
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
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             backgroundColor: const Color.fromARGB(255, 231, 25, 25),
          //             textStyle: TextStyle(
          //                 fontSize: 10.sp,
          //                 color: const Color.fromARGB(255, 241, 236, 236),
          //                 fontWeight: FontWeight.bold)),
          //         onPressed: () async {
          //           String Day = "1";
          //           String Type = "0";
          //           obidient.clear();

          //           if (prebigner == true) {
          //             obidient.add("1");
          //           }
          //           if (bigner == true) {
          //             obidient.add("2");
          //           }
          //           if (novic == true) {
          //             obidient.add("3");
          //           }
          //           if (Texta == true) {
          //             obidient.add("4");
          //           }
          //           if (Textb == true) {
          //             obidient.add("5");
          //           }
          //           if (Textc == true) {
          //             obidient.add("6");
          //           }

          //           print(obidient);

          //           {
          //             if (stallReq == "0") {
          //               //  print("sukriya");
          //               Day = "";
          //               Type = "";
          //             } else {
          //               Day = StallDay;
          //               Type = StallType;
          //             }

          //             //obidient.length;
          //             if (obidient.length <= 1 &&
          //                 widget.eventtype.toString() == "2") {
          //               QuickAlert.show(
          //                 context: context,
          //                 type: QuickAlertType.error,
          //                 title: 'Oops...',
          //                 text: 'Please Select atlest 2 box',
          //               );
          //             } else {
          //               // print(
          //               //     "$selectedValue-$Day - $Type - $obidient - $stallReq - ${widget.eventid}${widget.eventtype}${widget.eventstal}");

          //               SharedPreferences sharedprefrence =
          //                   await SharedPreferences.getInstance();
          //               String userid = sharedprefrence.getString("Userid")!;
          //               String token = sharedprefrence.getString("Token")!;

          //               Map<String, String> requestHeaders = {
          //                 // 'Accept': 'application/json',
          //                 'Usertoken': token,
          //                 'Userid': userid
          //               };

          //               const uri =
          //                   "https://new-demo.inkcdogs.org/api/event/participate";

          //               final responce = await http.post(Uri.parse(uri),
          //                   body: {
          //                     "event_id": widget
          //                         .eventid
          //                         .toString(),
          //                     "pet_id":
          //                         selectedValue
          //                             .toString(),
          //                     "class_and_price[]":
          //                         obidient
          //                             .toString(),
          //                     "is_stall_required":
          //                         stallReq,
          //                     "event_stall_day":
          //                         Day,
          //                     "event_stall_type":
          //                         Type,
          //                     "register_with_event":
          //                         "1"
          //                   },
          //                   headers: requestHeaders);
          //               var data = json.decode(responce.body);
          //               if (data['code'].toString() == "200") {
          //                 QuickAlert.show(
          //                   context: context,
          //                   type: QuickAlertType.success,
          //                   title: 'Success...',
          //                   text: 'Please Check your cart',
          //                 );
          //                 setState(() {
          //                   RefreshCart();
          //                 });
          //               }
          //             }

          //             // print(data['message']);
          //           }
          //         },
          //         child: const Text(
          //           "Submit",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w700, color: Colors.white),
          //         )),
          //   ),
          // ),
        ],
      ),
    );
  }

//   UploadData() async {}

//   UploadData() async {}
}
