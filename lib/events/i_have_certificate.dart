import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/drop_down_breed_list.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/dropdownmodel/drop_down_model_kennel_name.dart';
import 'package:inkc/model/profilemodel.dart';
// import 'package:myprofile_ui/pages/myprofile.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// class IHaveCertificate extends StatelessWidget {
//   String eventid, eventname, eventtype, eventstal;
//   IHaveCertificate(
//       {required this.eventid,
//       required this.eventname,
//       required this.eventtype,
//       required this.eventstal});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Certificated",
//       home: IHaveCertificate(),
//     );
//   }
// }

String userid = "";
String token = "";
String image = "";

class IHaveCertificate extends StatefulWidget {
  String eventid, eventname, eventtype, eventstal;
  IHaveCertificate(
      {required this.eventid,
      required this.eventname,
      required this.eventtype,
      required this.eventstal});

  @override
  _IHaveCertificateState createState() => _IHaveCertificateState();
}

class _IHaveCertificateState extends State<IHaveCertificate> {
  TextEditingController Registornumber = new TextEditingController();
  TextEditingController Dogname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController dateofbirth = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController personalid = new TextEditingController();
  TextEditingController sire = new TextEditingController();
  TextEditingController dam = new TextEditingController();
  TextEditingController counrty = new TextEditingController();

  List colorandmakingList = [];
  var selectcolormarkingvalue;
  var selectcolormakingid;

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
          Uri.parse("https://www.inkc.in/api/dog/dog_color_marking_list"),
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

  FocusNode focusNode = FocusNode();

  File? firstimages;
  final _firstpickers = ImagePicker();

  File? secondimages;
  final _secondpickers = ImagePicker();

  File? thiredimages;
  final _thiredpickers = ImagePicker();

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
        dateofbirth.value = TextEditingValue(
            text: date.day.toString() +
                "-" +
                date.month.toString() +
                "-" +
                date.year.toString());
      });
    }
  }

  String? gender;

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

  File? secondImage;
  final _secondpicker = ImagePicker();

  Future getsecondImage() async {
    final pickedFilesecond = await _secondpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFilesecond != null) {
      secondImage = File(pickedFilesecond.path);
      print(secondImage);

      setState(() {});
    } else {
      print('no image  selected');
    }
  }

  File? thiredImage;
  final _thiredpicker = ImagePicker();
  Future getthardImage() async {
    final pickedFilethired = await _thiredpicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFilethired != null) {
      thiredImage = File(pickedFilethired.path);
      print(thiredImage);

      setState(() {});
    } else {
      print('no image  selected');
    }
  }

  // drop - down list
  // kennel name
  List data = [];
  int _value = 1;
  var selectedvalue;
  var selectedid;

  // Dog Breed
  List breedlist = [];
  var selectebreedvalue;
  var selectedbreedid;

  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'A longer option 4'
  ];

  Future<List<DropDownKennelName>> getkennelclub() async {
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
          Uri.parse("https://www.inkc.in/api/dog/kennel_list_for_non_inkc"),
          headers: requestHeaders);
      // var data = json.decode(res.body);
      // var dataarray = data['data'];
      // print(dataarray);

      final body = json.decode(res.body);
      final list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownKennelName(
            kennelClubId: map['kennel_club_id'],
            kennelClubName: map['kennel_club_name'],
            kennelClubPrefix: map['kennel_club_prefix'],
            kennelClubStatus: map['kennel_club_status'],
            kennelClubUpdatedOn: map['kennel_club_updated_on'],
            kennelClubCreatedOn: map['kennel_club_created_on'],
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

  Future<List<DogBreedList>> getbreedlist() async {
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
          Uri.parse("https://www.inkc.in/api/dog/dog_breed_list"),
          headers: requestHeaders);

      final body = json.decode(res.body);
      final list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return DogBreedList(
            subCatId: map['sub_cat_id'],
            petCategoryId: map['pet_category_id'],
            subCategoryName: map['sub_category_name'],
            subCategoryCode: map['sub_category_code'],
            subCatSlug: map['sub_cat_slug'],
            subCatStudSlug: map['sub_cat_stud_slug'],
            subCatImage: map['sub_cat_image'],
            subIsDiscounted: map['sub_is_discounted'],
            subCategoryStatus: map['sub_category_status'],
            subCategoryUpdatedOn: map['sub_category_updated_on'],
            subCategoryCreatedOn: map['sub_category_created_on'],
          );
        }).toList();
      }

      // var datas = jsonDecode(res.body.toString());
      // data = datas['data'];
      setState(() {});
      print(list);
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
  bool countryvalidate = false;

  uploadData() async {
    setState(() {
      showSpinner = true;
    });

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

    if (stallReq == "0") {
      //  print("sukriya");
      Day = "";
      Type = "";
    } else {
      Day = StallDay;
      Type = StallType;
    }

    print(selectedid.toString() +
        " - " +
        Registornumber.text.toString() +
        " - " +
        sire.text.toString() +
        " - " +
        dam.text.toString() +
        " - " +
        Dogname.text.toString() +
        " - " +
        dateofbirth.text.toString() +
        " - " +
        selectedbreedid.toString() +
        " - " +
        selectcolormakingid.toString() +
        " - " +
        gender.toString() +
        " - " +
        counrty.text.toString() +
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
        " - " +
        widget.eventtype +
        " - " +
        widget.eventstal);

    String sires = sire.text.toString();
    String dams = dam.text.toString();
    String ResNum = Registornumber.text;
    String KennelId = selectedid.toString();
    String DogName = Dogname.text.toString();
    String DOB = dateofbirth.text.toString();
    String Breed = selectedbreedid.toString();
    String Gender = gender.toString();
    String color = selectcolormakingid.toString();

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(firstImage!.path,
            filename: now.second.toString() + ".jpg"),
        'front_side_certificate': await MultipartFile.fromFile(
            secondImage!.path,
            filename: now.second.toString() + ".jpg"),
        'back_side_certificate': await MultipartFile.fromFile(thiredImage!.path,
            filename: now.second.toString() + ".jpg"),
        'event_id': widget.eventid.toString(),
        'pet_sub_category_id': Breed,
        'kennel_club_prefix': KennelId,
        'pet_gender': Gender,
        'birth_date': DOB,
        'pet_name': DogName,
        'non_inkc_registration_number': ResNum,
        'color_marking': color,
        'sire_reg_number': sires,
        'dam_reg_number': dams,
        'breded_country': counrty.text.toString(),
        "class_and_price[]": obidient.toString(),
        "is_stall_required": stallReq,
        "event_stall_day": Day,
        "event_stall_type": Type,
        "register_with_event": "1"
      });

      Response response = await dio.post(
          'https://www.inkc.in/api/event/non_inkc_registration_participants',
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
          text: 'Please Check your cart',
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SuccessFully Registered')));
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

    // var uri = Uri.parse("https://www.inkc.in/api/dog/non_inkc_registration");

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
    //     new http.MultipartFile('pet_image', first, lengthfirst);

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

  // Event Details
  bool prebigner = false;
  bool bigner = false;
  bool novic = false;
  bool Texta = false;
  bool Textb = false;
  bool Textc = false;

  List obidient = [];

  bool checkvisible = true;
  String? stallReq = "0";
  bool stall_day_type = false;
  String StallDay = "1";
  String StallType = "0";

  List<Map<String, String>> keyValueList = [];

  List products = [];

  String? selectedValue; // Initial selected value

  //RefreshCart
  RefreshCart() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

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
    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 223, 39, 39)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  'Participate',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color:
                              Color.fromARGB(255, 223, 71, 45), // shadow color
                          offset:
                              Offset(2.0, 2.0), // how much shadow will be shown
                        ),
                      ],
                      fontSize: 25,
                      decorationColor: Colors.red,
                      color: Color.fromARGB(255, 194, 97, 33),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 16, top: 5, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Your dog’s photograph ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: firstImage == null
                            ? Container(
                                margin:
                                    EdgeInsets.only(left: 60.sp, right: 60.sp),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 187, 4, 4),
                                  ),
                                  onPressed: () async {
                                    getfirstImage();
                                  },
                                  child: Text(
                                    'Pick Image',
                                    style: TextStyle(color: Colors.white),
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
                                          //       "https://www.inkc.in/${image}"),
                                          //   fit: BoxFit.cover, //change image fill type
                                          // ),
                                          ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 199, 7, 7),
                                      ),
                                      onPressed: () async {
                                        getfirstImage();
                                      },
                                      child: Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Front side of the certificate ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 73, 72, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: secondImage == null
                            ? Container(
                                margin:
                                    EdgeInsets.only(left: 60.sp, right: 60.sp),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 197, 4, 4),
                                  ),
                                  onPressed: () async {
                                    getsecondImage();
                                  },
                                  child: Text(
                                    'Pick Image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  getsecondImage();
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
                                                File(secondImage!.path)
                                                    .absolute),
                                            fit: BoxFit.cover,
                                          )
                                          // image: DecorationImage(
                                          //   image: NetworkImage(
                                          //       "https://www.inkc.in/${image}"),
                                          //   fit: BoxFit.cover, //change image fill type
                                          // ),
                                          ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 199, 13, 13),
                                      ),
                                      onPressed: () async {
                                        getsecondImage();
                                      },
                                      child: Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Back side of the certificate ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: thiredImage == null
                            ? Container(
                                margin:
                                    EdgeInsets.only(left: 60.sp, right: 60.sp),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 199, 13, 13),
                                  ),
                                  onPressed: () async {
                                    getthardImage();
                                  },
                                  child: Text(
                                    'Pick Image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  getthardImage();
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
                                                File(thiredImage!.path)
                                                    .absolute),
                                            fit: BoxFit.cover,
                                          )
                                          // image: DecorationImage(
                                          //   image: NetworkImage(
                                          //       "https://www.inkc.in/${image}"),
                                          //   fit: BoxFit.cover, //change image fill type
                                          // ),
                                          ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 187, 9, 9),
                                      ),
                                      onPressed: () async {
                                        getthardImage();
                                      },
                                      child: Text(
                                        'Pick Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Kennel Club ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<List<DropDownKennelName>>(
                          future: getkennelclub(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedvalue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedvalue = value;
                                          selectedid = value;
                                        });
                                      },
                                      items: snapshot.data!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.kennelClubId.toString(),
                                          child: Container(
                                            width: double
                                                .infinity, // Auto size based on content
                                            child: Text(
                                              e.kennelClubName.toString(),
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
                                //  DropdownButtonFormField(
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
                                //     items: snapshot.data!.map((e) {
                                //       return DropdownMenuItem(
                                //           value: e.kennelClubId.toString(),
                                //           child: Text(
                                //             e.kennelClubName.toString(),
                                //             style: TextStyle(
                                //                 color: Color.fromARGB(
                                //                     255, 95, 46, 46),
                                //                 fontSize: 12.sp,
                                //                 fontWeight: FontWeight.bold),
                                //           ));
                                //     }).toList(),
                                //     onChanged: (value) {
                                //       setState(() {
                                //         selectedvalue = value;
                                //         selectedid = value;
                                //       });
                                //     }
                                //     ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Registration Number ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: Registornumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Registration Number',
                                    hintText: 'Non INKC registration number',
                                    errorText: regisvalidate
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
                                      "Sire's INKC Registration Number ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    // Text(
                                    //   "*",
                                    //   style: TextStyle(
                                    //       color: Color.fromARGB(255, 231, 11, 11),
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15.sp),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: sire,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText:
                                        "Sire's INKC Registration Number",
                                    hintText: "Sire's INKC Registration Number",
                                    errorText: regisvalidate
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
                                      "Dam's INKC Registration Number ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    // Text(
                                    //   "*",
                                    //   style: TextStyle(
                                    //       color: Color.fromARGB(255, 231, 11, 11),
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15.sp),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: dam,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText:
                                        "Sire's INKC Registration Number",
                                    hintText: "Sire's INKC Registration Number",
                                    errorText: regisvalidate
                                        ? "Value Can't Be Empty"
                                        : null,
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.all(18),
                              //   child: DropdownButton(
                              //     items: data.map((e) {
                              //       print(e["kennel_club_name"]);

                              //       return DropdownMenuItem(
                              //           child: Text(
                              //             e["kennel_club_name"],
                              //             style: TextStyle(color: Colors.black),
                              //           ),
                              //           value: e["kennel_club_id"]);
                              //     }).toList(),
                              //     onChanged: (value) {
                              //       _value = value as int;
                              //       setState(() {});
                              //     },
                              //     // obscureText: true,
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name of the dog ",
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
                                  controller: Dogname,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
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
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      width: 160.sp,
                                      child: TextField(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
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
                                          prefixIcon: Icon(Icons.date_range),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.sp)),
                                            borderSide: BorderSide(
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
                                            primary: Color.fromARGB(
                                                255, 231, 25, 25),
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color.fromARGB(
                                                    255, 241, 236, 236),
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          selectDatePicker();
                                        },
                                        child: Text(
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
                                      "Breed ",
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
                              // Padding(
                              //   padding: EdgeInsets.all(8),
                              //   child: TextField(
                              //     maxLines: null,
                              //     controller: address,
                              //     // obscureText: true,
                              //     decoration: InputDecoration(
                              //       border: OutlineInputBorder(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(4.sp)),
                              //         borderSide:
                              //             BorderSide(width: 1, color: Colors.green),
                              //       ),
                              //       labelText: 'Breed',
                              //     ),
                              //   ),
                              // ),

                              FutureBuilder<List<DogBreedList>>(
                                  future: getbreedlist(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectebreedvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectebreedvalue = value;
                                                  selectedbreedid = value;
                                                });
                                              },
                                              items: snapshot.data!.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.subCatId.toString(),
                                                  child: Container(
                                                    width: double
                                                        .infinity, // Auto size based on content
                                                    child: Text(
                                                      e.subCategoryName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 95, 46, 46),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        // DropdownButtonFormField(
                                        //     decoration: InputDecoration(
                                        //       contentPadding:
                                        //           const EdgeInsets.only(
                                        //               left: 10, right: 10),
                                        //       border: OutlineInputBorder(
                                        //           borderRadius: BorderRadius.all(
                                        //               Radius.circular(10))),
                                        //     ),
                                        //     hint: Text('Select value'),
                                        //     isExpanded: true,
                                        //     value: selectebreedvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e.subCatId.toString(),
                                        //           child: Text(
                                        //             e.subCategoryName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       selectebreedvalue = value;
                                        //       selectedbreedid = value;
                                        //       setState(() {});
                                        //     }),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Color and Marking ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                              FutureBuilder<List<ColorAndMaking>>(
                                  future: getColorAndMaking(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectcolormarkingvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectcolormarkingvalue =
                                                      value;
                                                  selectcolormakingid = value;
                                                });
                                              },
                                              items: snapshot.data!.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.colourId.toString(),
                                                  child: Container(
                                                    width: double
                                                        .infinity, // Auto size based on content
                                                    child: Text(
                                                      e.colourName.toString(),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 95, 46, 46),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        // DropdownButtonFormField(
                                        //     decoration: InputDecoration(
                                        //       contentPadding:
                                        //           const EdgeInsets.only(
                                        //               left: 30, right: 10),
                                        //       border: OutlineInputBorder(
                                        //           borderRadius: BorderRadius.all(
                                        //               Radius.circular(10))),
                                        //     ),
                                        //     hint: Text('Select value'),
                                        //     isExpanded: true,
                                        //     value: selectcolormarkingvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e.colourId.toString(),
                                        //           child: Text(
                                        //             e.colourName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 11.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       selectcolormarkingvalue = value;
                                        //       selectcolormakingid = value;
                                        //       setState(() {});
                                        //     }),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sex of the dog ",
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
                                  padding: EdgeInsets.all(8),
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
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Female',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Country Bred In ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: counrty,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
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
                              if (widget.eventstal.toString() == "1" ||
                                  widget.eventstal.toString() == "2")
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        "EVENT DETAILS",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 22, 21, 21),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17.sp),
                                      ),
                                    ],
                                  ),
                                ),

                              if (widget.eventtype.toString() == "2")
                                Visibility(
                                    child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Class (Select at least two option.)",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 22, 21, 21),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ), //SizedBox
                                              Text(
                                                'Novice ',
                                                style:
                                                    TextStyle(fontSize: 15.0),
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
                                                style:
                                                    TextStyle(fontSize: 15.0),
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
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ), //SizedBox
                                              Text(
                                                'Test-B ',
                                                style:
                                                    TextStyle(fontSize: 15.0),
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
                                                style:
                                                    TextStyle(fontSize: 15.0),
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
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Do you need stall              ",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 22, 21, 21),
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
                                                            groupValue:
                                                                stallReq,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                stall_day_type =
                                                                    false;
                                                                stallReq = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            'No',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    11.sp),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Radio(
                                                            value: "1",
                                                            groupValue:
                                                                stallReq,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                stall_day_type =
                                                                    true;
                                                                stallReq = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    11.sp),
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
                                          padding: const EdgeInsets.only(
                                              top: 20.0, left: 12),
                                          child: Row(
                                            children: [
                                              Text(
                                                "stall Day          ",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 22, 21, 21),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                              StallDay = value
                                                                  .toString();
                                                            });
                                                          },
                                                        ),
                                                        Text(
                                                          'First Day',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11.sp),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 18.0),
                                                      child: Row(
                                                        children: [
                                                          Radio(
                                                            value: "2",
                                                            groupValue:
                                                                StallDay,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                // _isShowOff = true;
                                                                StallDay = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            'Second Day',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    11.sp),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Row(
                                                        children: [
                                                          Radio(
                                                            value: "3",
                                                            groupValue:
                                                                StallDay,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                // _isShowOff = true;
                                                                StallDay = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            'Both Days',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    11.sp),
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
                                          padding: const EdgeInsets.only(
                                              top: 20.0, left: 12),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Stall Type             ",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 22, 21, 21),
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
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                value: "0",
                                                                groupValue:
                                                                    StallType,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    // _isShowOff = false;
                                                                    StallType =
                                                                        value
                                                                            .toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                'FAN',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        11.sp),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                value: "1",
                                                                groupValue:
                                                                    StallType,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    // _isShowOff = true;
                                                                    StallType =
                                                                        value
                                                                            .toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                'AC',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        11.sp),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
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
                                    // print(gender.toString());

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

                                    if (selectedid.toString() == "null") {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: 'Oops...',
                                        text: 'Please Select Kennel Club',
                                      );
                                    } else {
                                      if (Registornumber.text.toString() ==
                                          "") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please Enter Registration Number',
                                        );
                                      } else {
                                        if (Dogname.text.toString() == "") {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text: 'Please Enter Dog Name',
                                          );
                                        } else {
                                          if (dateofbirth.text.toString() ==
                                              "") {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Oops...',
                                              text: 'Please Select date',
                                            );
                                          } else {
                                            if (selectedbreedid.toString() ==
                                                "null") {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: 'Oops...',
                                                text: 'Please Select Breed',
                                              );
                                            } else {
                                              if (selectcolormakingid
                                                      .toString() ==
                                                  "") {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.error,
                                                  title: 'Oops...',
                                                  text:
                                                      'Please Select Color and Making',
                                                );
                                              } else {
                                                if (gender.toString() ==
                                                    "null") {
                                                  QuickAlert.show(
                                                    context: context,
                                                    type: QuickAlertType.error,
                                                    title: 'Oops...',
                                                    text:
                                                        'Please Select gender',
                                                  );
                                                } else {
                                                  if (counrty.text.toString() ==
                                                      "") {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type:
                                                          QuickAlertType.error,
                                                      title: 'Oops...',
                                                      text:
                                                          'Please Enter country name',
                                                    );
                                                  } else {
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
                                                      uploadData();
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }

                                    // print(selectedid.toString() +
                                    //     " - " +
                                    //     Registornumber.text.toString() +
                                    //     " - " +
                                    //     sire.text.toString() +
                                    //     " - " +
                                    //     dam.text.toString() +
                                    //     " - " +
                                    //     Dogname.text.toString() +
                                    //     " - " +
                                    //     dateofbirth.text.toString() +
                                    //     " - " +
                                    //     selectedbreedid.toString() +
                                    //     " - " +
                                    //     selectcolormakingid.toString() +
                                    //     " - " +
                                    //     gender.toString() +
                                    //     " - " +
                                    //     counrty.text.toString() +
                                    //     "-" +
                                    //     Day +
                                    //     " - " +
                                    //     Type +
                                    //     " - " +
                                    //     obidient.toString() +
                                    //     " - " +
                                    //     stallReq.toString() +
                                    //     " - " +
                                    //     widget.eventid +
                                    //     " - " +
                                    //     widget.eventtype +
                                    //     " - " +
                                    //     widget.eventstal);

                                    //uploadData();
                                  },
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 46, 6, 155),
                                      textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: const Color.fromARGB(
                                              255, 241, 236, 236),
                                          fontWeight: FontWeight.bold)),
                                ),
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

//   UploadData() async {}
}
