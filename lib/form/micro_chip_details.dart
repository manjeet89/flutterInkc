import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eosdart/eosdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkc/dropdownmodel/micro_chip_details.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
// import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MicroChipDetails extends StatefulWidget {
  String? pname, rcnumber, pic;
  MicroChipDetails(
      {required this.pname, required this.rcnumber, required this.pic});

  @override
  State<MicroChipDetails> createState() => _MicroChipDetailsState();
}

class _MicroChipDetailsState extends State<MicroChipDetails> {
  bool showSpinner = false;

  TextEditingController micronumber = new TextEditingController();
  TextEditingController implementName = new TextEditingController();
  TextEditingController Number = new TextEditingController();
  TextEditingController dateofbirth = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController personalid = new TextEditingController();

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

// validator
  bool micronumbervalidate = false;
  bool Numbervalidate = false;
  bool implementNamevalidate = false;
  bool datevalidate = false;

  Future<List<MicroChipModel>> getkennelclub() async {
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
          Uri.parse("https://www.inkc.in/api/dog/implemented_by_list"),
          headers: requestHeaders);
      // var data = json.decode(res.body);
      // var dataarray = data['data'];
      // print(dataarray);

      final body = json.decode(res.body);
      final list = body['data'] as List;

      if (res.statusCode == 200) {
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return MicroChipModel(
            empTypeId: map['emp_type_id'],
            empTypeName: map['emp_type_name'],
            empTypeAccess: map['emp_type_access'],
            empTypeStatus: map['emp_type_status'],
            empTypeUpdatedOn: map['emp_type_updated_on'],
            empTypeCreatedOn: map['emp_type_created_on'],
            isAdminLogin: map['is_admin_login'],
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

  var selectedvalue;
  var selectedid;

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

  uploadData() async {
    setState(() {
      // showSpinner = true;
    });

    String MicroNumber = micronumber.text;
    String impletedId = selectedid;
    String ImplementNames = implementName.text;
    String DOB = dateofbirth.text;
    String number = Number.text;

    // print(MicroNumber +
    //     " - " +
    //     impletedId +
    //     " - " +
    //     ImplementNames +
    //     " - " +
    //     DOB +
    //     " - " +
    //     number);

    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      String userid = sharedprefrence.getString("Userid")!;
      String token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'upload_microchip_document': await MultipartFile.fromFile(
            firstImage!.path,
            filename: now.second.toString() + ".jpg"),
        'implementer_name': ImplementNames,
        'implement_by': impletedId,
        'pet_microchip_number': MicroNumber,
        'implementer_mobile_number': number,
        'implemented_date': DOB,
      });

      Response response = await dio.post(
          'https://www.inkc.in/api/dog/upload_document_microchip',
          data: formData,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Usertoken': token,
            'Userid': userid
          }));

      if (response.statusCode == 200) {
        print(response.toString());
        setState(() {
          RefreshCart();
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

  // final GlobalKey qrkey = GlobalKey(debugLabel: "OR");
  // QRViewController? controller;
  // String Result = "";

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   controller?.dispose();
  // }

  // void _onQRVireCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((event) {
  //     setState(() {
  //       Result = event.code!;
  //     });
  //   });
  // }

  // Future _qrScanner() async {
  //   // var camerastatus = await Permission.camera.status;

  //   String? qdata = await Scanner.scan();
  //   print(qdata);
  //   // String qrdataphone =
  // }

  Future<void> scanBarCode() async {
    String barcodescanerres;
    try {
      barcodescanerres = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodescanerres);
      print(barcodescanerres);
      setState(() {
        micronumber.value = TextEditingValue(text: barcodescanerres);
      });
    } on PlatformException {
      barcodescanerres = "Failed to get platform version";
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
                //   onPressed: () => Navigator.of(context).pop(),
                // ),
                title: Text(
                  'MicroChip Details',
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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100.sp,
                              height: 100.sp,
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
                                      "https://www.inkc.in/${widget.pic}"),
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Name of Dog :     ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Container(
                                      width: 100.sp,
                                      height: 50.sp,
                                      child: Text(
                                        widget.pname.toString(),
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 163, 8, 8),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Registration Number :  ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 21, 21),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      widget.rcnumber.toString(),
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 163, 8, 8),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Microchip Number ",
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

                            // Expanded(
                            //     flex: 5,
                            //     child: QRView(
                            //         key: qrkey,
                            //         onQRViewCreated: _onQRVireCreated)),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 88, 8, 126),
                                    textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        color: const Color.fromARGB(
                                            255, 241, 236, 236),
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  // _onQRVireCreated();
                                  // _qrScanner();
                                  scanBarCode();
                                },
                                child: Text(
                                  'Scan Barcode',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.white),
                                )),
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
                                  controller: micronumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Microchip Number ',
                                    hintText: 'Microchip Number ',
                                    errorText: micronumbervalidate
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
                                      "Implemented by ",
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
                              FutureBuilder<List<MicroChipModel>>(
                                  future: getkennelclub(),
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
                                              value: selectedvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedvalue = value;
                                                  selectedid = value;
                                                });
                                              },
                                              hint: Text('Select value'),
                                              items: snapshot.data!.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.empTypeId.toString(),
                                                  child: Container(
                                                    width: double
                                                        .infinity, // Auto size based on content
                                                    child: Text(
                                                      e.empTypeName.toString(),
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
                                        //     value: selectedvalue,
                                        //     items: snapshot.data!.map((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e.empTypeId.toString(),
                                        //           child: Text(
                                        //             e.empTypeName.toString(),
                                        //             style: TextStyle(
                                        //                 color: Color.fromARGB(
                                        //                     255, 95, 46, 46),
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       selectedvalue = value;
                                        //       selectedid = value;
                                        //       setState(() {});
                                        //     }),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
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
                                      "Implementer Name ",
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
                                  controller: implementName,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Implementer Name ',
                                    hintText: 'Implementer Name ',
                                    errorText: implementNamevalidate
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
                                      "Implementer Mobile Number ",
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
                                  controller: Number,
                                  keyboardType: TextInputType.number,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.green),
                                    ),
                                    labelText: 'Implementer Mobile Numbe',
                                    errorText: Numbervalidate
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
                                      "Implemented Date ",
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Upload Document ",
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
                                child: firstImage == null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 60.sp, right: 60.sp),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 192, 5, 5),
                                          ),
                                          onPressed: () async {
                                            getfirstImage();
                                          },
                                          child: Text(
                                            'Pick Image',
                                            style: TextStyle(
                                              color: Colors.white,
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
                                                  //       "https://www.inkc.in/${image}"),
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
                              SizedBox(
                                height: 30.sp,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 51, 6, 175),
                                        textStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromARGB(
                                                255, 241, 236, 236),
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      if (micronumber.text.toString().isEmpty) {
                                        setState(() {
                                          micronumbervalidate =
                                              micronumber.text.isEmpty;
                                        });
                                      } else if (selectedid
                                          .toString()
                                          .isEmpty) {
                                        // setState(() {
                                        //   regisvalidate =
                                        //       Registornumber.text.isEmpty;
                                        // });
                                      } else if (implementName.text
                                          .toString()
                                          .isEmpty) {
                                        setState(() {
                                          implementNamevalidate =
                                              implementName.text.isEmpty;
                                        });
                                      } else if (Number.text
                                          .toString()
                                          .isEmpty) {
                                        setState(() {
                                          Numbervalidate = Number.text.isEmpty;
                                        });
                                      } else if (dateofbirth.text
                                          .toString()
                                          .isEmpty) {
                                        setState(() {
                                          datevalidate =
                                              dateofbirth.text.isEmpty;
                                        });
                                      } else {
                                        //print("object");
                                        uploadData();
                                      }
                                    },
                                    child: Text(
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
}
