import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inkc/dropdownmodel/drop_down_breed_list.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/dropdownmodel/drop_down_model_kennel_name.dart';
import 'package:inkc/events/obidient.dart';
import 'package:inkc/image_helper.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// class PedigreeDogRegistrationRegistrationWithOtherClubForm
//     extends StatelessWidget {
//   String participate_event_id,
//       is_participate_with_event,
//       register_with_event,
//       eventname,
//       eventtype,
//       eventstal;

//   PedigreeDogRegistrationRegistrationWithOtherClubForm(
//       {required this.participate_event_id,
//       required this.is_participate_with_event,
//       required this.register_with_event,
//       required this.eventname,
//       required this.eventtype,
//       required this.eventstal,
//       super.key});

//   // @override
//   // Widget build(BuildContext context) {
//   //   return const MaterialApp(
//   //     debugShowCheckedModeBanner: false,
//   //     title: "profile UI",
//   //     home: PedigreeDogRegistrationRegistrationWithOtherClub(),
//   //   );
//   // }
// }

String userid = "";
String token = "";
String image = "";
final imagehelper = ImageHelper();

class PedigreeDogRegistrationRegistrationWithOtherClubForm
    extends StatefulWidget {
  String participate_event_id,
      is_participate_with_event,
      register_with_event,
      eventname,
      eventtype,
      eventstal,
      pariticaipate_for_event,
      register_for_event;
  PedigreeDogRegistrationRegistrationWithOtherClubForm(
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
  _PedigreeDogRegistrationRegistrationWithOtherClubFormState createState() =>
      _PedigreeDogRegistrationRegistrationWithOtherClubFormState();
}

class _PedigreeDogRegistrationRegistrationWithOtherClubFormState
    extends State<PedigreeDogRegistrationRegistrationWithOtherClubForm> {
  bool showSpinner = false;
  String? MicroRequired = "0";
  File? _dogphotograph;
  File? _frontsidecertificate;
  File? _backsidecertificate;
  File? _owntransfernumber;

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

  TextEditingController Registornumber = TextEditingController();
  TextEditingController Dogname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController personalid = TextEditingController();

  FocusNode focusNode = FocusNode();

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

  String? gender = "1";

  // drop - down list
  // kennel name
  List data = [];
  final int _value = 1;
  var selectedvalue;
  var selectedid;

  // Dog Breed
  List breedlist = [];
  var selectebreedvalue;
  var selectedbreedid;

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
          Uri.parse(
              "https://new-demo.inkcdogs.org/api/dog/kennel_list_for_non_inkc"),
          headers: requestHeaders);
      // var data = json.decode(res.body);
      // var dataarray = data['data'];
      // print(dataarray);

      final body = json.decode(res.body);
      final list = body['data'] as List;
      // print(body.toString());

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
          Uri.parse("https://new-demo.inkcdogs.org/api/dog/dog_breed_list"),
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

  uploadData(
      String obidientq, String stallReqq, String Dayq, String Typeq) async {
    setState(() {
      showSpinner = true;
    });

    String ResNum = Registornumber.text.toString();
    String KennelId = selectedid.toString();
    String DogName = Dogname.text.toString();
    String DOB = dateofbirth.text.toString();
    String Breed = selectedbreedid.toString();
    String color = selectcolormakingid.toString();
    String Gender = gender.toString();
    // MicroRequired

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      userid = sharedprefrence.getString("Userid")!;
      token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      if (_owntransfernumber.toString() == "null") {
        FormData formData = FormData.fromMap({
          'pet_image': await MultipartFile.fromFile(_dogphotograph!.path,
              filename: "${now.second}.jpg"),
          'front_side_certificate': await MultipartFile.fromFile(
              _frontsidecertificate!.path,
              filename: "${now.second}.jpg"),
          'back_side_certificate': await MultipartFile.fromFile(
              _backsidecertificate!.path,
              filename: "${now.second}.jpg"),
          'pet_sub_category_id': Breed,
          'kennel_club_prefix': KennelId,
          'pet_gender': Gender,
          'color_marking': color,
          'birth_date': DOB,
          'pet_name': DogName,
          'pet_registration_number': ResNum,
          'breded_country': counrty.text.toString(),
          'is_microchip_require': MicroRequired,
          "participate_event_id": widget.participate_event_id.toString(),
          "class_and_price[]": obidientq.toString(),
          "is_stall_required": stallReqq,
          "event_stall_day": Dayq,
          "event_stall_type": Typeq,
          "register_with_event": widget.register_for_event,
          "is_participate_with_event": widget.pariticaipate_for_event
        });

        Response response = await dio.post(
            'https://new-demo.inkcdogs.org/api/dog/non_inkc_registration',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Success...',
            text: 'SuccessFully Registered',
          );

          print(response.toString());
          setState(() {
            RefreshCart();
            showSpinner = false;
          });

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
      } else {
        FormData formData = FormData.fromMap({
          'pet_image': await MultipartFile.fromFile(_dogphotograph!.path,
              filename: "${now.second}.jpg"),
          'front_side_certificate': await MultipartFile.fromFile(
              _frontsidecertificate!.path,
              filename: "${now.second}.jpg"),
          'back_side_certificate': await MultipartFile.fromFile(
              _backsidecertificate!.path,
              filename: "${now.second}.jpg"),
          'other_club_transfer_form': await MultipartFile.fromFile(
              _owntransfernumber!.path,
              filename: "${now.second}.jpg"),
          'pet_sub_category_id': Breed,
          'kennel_club_prefix': KennelId,
          'pet_gender': Gender,
          'color_marking': color,
          'birth_date': DOB,
          'pet_name': DogName,
          'pet_registration_number': ResNum,
          'breded_country': counrty.text.toString(),
          'is_microchip_require': MicroRequired,
          "participate_event_id": widget.participate_event_id.toString(),
          "class_and_price[]": obidientq.toString(),
          "is_stall_required": stallReqq,
          "event_stall_day": Dayq,
          "event_stall_type": Typeq,
          "register_with_event": widget.register_for_event,
          "is_participate_with_event": widget.pariticaipate_for_event
        });

        Response response = await dio.post(
            'https://new-demo.inkcdogs.org/api/dog/non_inkc_registration',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Success...',
            text: 'SuccessFully Registered',
          );

          print(response.toString());
          setState(() {
            RefreshCart();
            showSpinner = false;
          });

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
      }

      // images = File(pickedFile.path);
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      print('no image  selected false');
    }
  }

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

// Country
  TextEditingController counrty = TextEditingController();
  bool countryvalidate = false;

  //RefreshCart
  RefreshCart() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

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
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back,
                //       color: Color.fromARGB(255, 223, 39, 39)),
                //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: (BuildContext context) => AddDogInfo())),
                // ),
                title: const Text(
                  'Pedigree Dog Registration',
                  style: TextStyle(
                      fontSize: 14,
                      decorationColor: Color.fromARGB(255, 66, 47, 45),
                      color: Color.fromARGB(255, 48, 40, 35),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 1),
                padding: const EdgeInsets.only(left: 16, top: 5, right: 16),
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
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _dogphotograph != null
                                  ? FileImage(_dogphotograph!)
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
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() =>
                                      _dogphotograph = File(cropperFile.path));
                                  print("justcheck$_dogphotograph");
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Front side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 73, 72, 72),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _frontsidecertificate != null
                                  ? FileImage(_frontsidecertificate!)
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
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() => _frontsidecertificate =
                                      File(cropperFile.path));
                                  print("justcheck$_frontsidecertificate");
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Back side of the certificate ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _backsidecertificate != null
                                  ? FileImage(_backsidecertificate!)
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
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() => _backsidecertificate =
                                      File(cropperFile.path));
                                  print("justcheck$_backsidecertificate");
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Own Transfer Form",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xEBA020F0),
                              radius: 64,
                              foregroundImage: _owntransfernumber != null
                                  ? FileImage(_owntransfernumber!)
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
                              final files = await imagehelper.PickImage();
                              if (files.isNotEmpty) {
                                final cropperFile = await imagehelper.crop(
                                    file: files.first,
                                    cropStyle: CropStyle.circle);
                                if (cropperFile != null) {
                                  setState(() => _owntransfernumber =
                                      File(cropperFile.path));
                                  print("justcheck$_owntransfernumber");
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Registration Number ",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 22, 21, 21),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
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
                                  controller: Registornumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: const BorderSide(
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
                                      "Kennel Club ",
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

                              FutureBuilder<List<DropDownKennelName>>(
                                  future: getkennelclub(),
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
                                          child: DropdownSearch<
                                              DropDownKennelName>(
                                            items: snapshot.data!,
                                            itemAsString:
                                                (DropDownKennelName? model) =>
                                                    model?.kennelClubName ?? "",
                                            // selectedItem:
                                            //     snapshot.data![getcountry],
                                            onChanged: (DropDownKennelName?
                                                selectedItem) {
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
                                                      item.kennelClubName ??
                                                          ""),
                                                );
                                              },
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItem) {
                                              return Text(selectedItem
                                                      ?.kennelClubName ??
                                                  ""); // Display the selected item's name
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  }),

                              // FutureBuilder<List<DropDownKennelName>>(
                              //     future: getkennelclub(),
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
                              //                 value: selectedvalue,
                              //                 onChanged: (value) {
                              //                   setState(() {
                              //                     selectedvalue = value;
                              //                     selectedid = value;
                              //                   });
                              //                 },
                              //                 hint: const Text('Select value'),
                              //                 items: snapshot.data!.map((e) {
                              //                   return DropdownMenuItem<String>(
                              //                     value:
                              //                         e.kennelClubId.toString(),
                              //                     child: SizedBox(
                              //                       width: double
                              //                           .infinity, // Auto size based on content
                              //                       child: Text(
                              //                         e.kennelClubName
                              //                             .toString(),
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
                                      "Name of the dog ",
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
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: Dogname,
                                  // obscureText: true,
                                  decoration: InputDecoration(
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
                                      "Breed ",
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

                              FutureBuilder<List<DogBreedList>>(
                                  future: getbreedlist(),
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
                                          child: DropdownSearch<DogBreedList>(
                                            items: snapshot.data!,
                                            itemAsString:
                                                (DogBreedList? model) =>
                                                    model?.subCategoryName ??
                                                    "",
                                            // selectedItem:
                                            //     snapshot.data![getcountry],
                                            onChanged:
                                                (DogBreedList? selectedItem) {
                                              setState(() {
                                                selectedbreedid =
                                                    selectedItem?.subCatId;
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
                                                      item.subCategoryName ??
                                                          ""),
                                                );
                                              },
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItem) {
                                              return Text(selectedItem
                                                      ?.subCategoryName ??
                                                  ""); // Display the selected item's name
                                            },
                                          ),
                                        ),
                                      );
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
                                                      item.colourName ?? ""),
                                                );
                                              },
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItem) {
                                              return Text(selectedItem
                                                      ?.colourName ??
                                                  ""); // Display the selected item's name
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  }),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      "Gender ",
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
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          children: [
                            Text(
                              "Microchip required",
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
                                      String ResNum =
                                          Registornumber.text.toString();
                                      String KennelId = selectedid.toString();
                                      String DogName = Dogname.text.toString();
                                      String DOB = dateofbirth.text.toString();
                                      String Breed = selectedbreedid.toString();
                                      String color =
                                          selectcolormakingid.toString();
                                      String Gender = gender.toString();

                                      if (_dogphotograph.toString() == "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text: 'Please Select dog Image',
                                        );
                                      } else if (_frontsidecertificate
                                              .toString() ==
                                          "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please Select front side certificate Image',
                                        );
                                      } else if (_backsidecertificate
                                              .toString() ==
                                          "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please Select front back certificate Image',
                                        );
                                      } else if (ResNum.toString() == "") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text:
                                              'Please enter registration number',
                                        );
                                      } else if (DogName.toString() == "") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text: 'Please enter dog name',
                                        );
                                      } else if (KennelId.toString() == "") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text: 'Please select kennal name',
                                        );
                                      } else if (DOB.toString() == "") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text: 'Please select date of birth',
                                        );
                                      } else if (Breed.toString() == "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text: 'Please select breed name',
                                        );
                                      } else if (color.toString() == "null") {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Oops...',
                                          text: 'Please select color name',
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
                                          if (obidient.length <= 1 &&
                                              widget.eventtype.toString() ==
                                                  "2") {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Oops...',
                                              text:
                                                  'Please Select atlest 2 box',
                                            );
                                          } else {
                                            // print(
                                            //     "$selectedValue-$Day - $Type - $obidient - $stallReq - ${widget.eventid}${widget.eventtype}${widget.eventstal}");

                                            // SharedPreferences sharedprefrence =
                                            //     await SharedPreferences.getInstance();
                                            // String userid = sharedprefrence.getString("Userid")!;
                                            // String token = sharedprefrence.getString("Token")!;

                                            // Map<String, String> requestHeaders = {
                                            //   // 'Accept': 'application/json',
                                            //   'Usertoken': token,
                                            //   'Userid': userid
                                            // };

                                            // const uri =
                                            //     "https://new-demo.inkcdogs.org/api/event/participate";

                                            // final responce = await http.post(Uri.parse(uri),
                                            //     body: {
                                            //       "event_id": widget
                                            //           .eventid
                                            //           .toString(),
                                            //       "pet_id":
                                            //           selectedValue
                                            //               .toString(),
                                            //       "class_and_price[]":
                                            //           obidient
                                            //               .toString(),
                                            //       "is_stall_required":
                                            //           stallReq,
                                            //       "event_stall_day":
                                            //           Day,
                                            //       "event_stall_type":
                                            //           Type,
                                            //       "register_with_event":
                                            //           "1"
                                            //     },
                                            uploadData(obidient.toString(),
                                                stallReq.toString(), Day, Type);
                                            //       headers: requestHeaders);
                                            //   var data = json.decode(responce.body);
                                            //   if (data['code'].toString() == "200") {
                                            //     QuickAlert.show(
                                            //       context: context,
                                            //       type: QuickAlertType.success,
                                            //       title: 'Success...',
                                            //       text: 'Please Check your cart',
                                            //     );
                                            //     setState(() {
                                            //       RefreshCart();
                                            //     });
                                            //   }
                                          }

                                          // print(data['message']);
                                        }
                                      }
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
}
