import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inkc/bottom_nav_pages/notification.dart';
import 'package:inkc/model/DamNumberModel.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'litterregistration.dart';

class KennelNumber extends StatefulWidget {
  const KennelNumber({super.key});

  @override
  State<KennelNumber> createState() => _KennelNumberState();
}

class _KennelNumberState extends State<KennelNumber> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ColorAndMakingfatch();
  }

  bool _isShowOff = false;
  bool _datecheck = false;
  bool _damOff = false;

  TextEditingController address = new TextEditingController();
  TextEditingController dateofbirth = new TextEditingController();
  TextEditingController avalable = new TextEditingController();

  late int difference;

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

        final birthday = DateTime(int.parse(date.year.toString()),
            int.parse(date.month.toString()), int.parse(date.day.toString()));
        final date2 = DateTime.now();
        difference = date2.difference(birthday).inDays;
        print(difference.toString());
      });
    }
  }
  // void Submit() {
  //   setState(() {
  //     String va = address.text;
  //     int intVal = int.parse(va);
  //     if (intVal <= 10) {
  //       _isShowOff = false;
  //       print(intVal);
  //     } else {
  //       _isShowOff = true;
  //     }
  //   });
  //   //address.value = TextEditingValue();
  // }

  String? damnumbers;
  var Nodata;

  Future<List<DamNumberModel>> ColorAndMakingfatch() async {
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
          Uri.parse("https://www.inkc.in/api/dog/dog_dam_list"),
          headers: requestHeaders);

      var body = json.decode(res.body);
      // Nodata = body['data'];
      var v = body['data'];
      if (v.toString() == "false") {
        setState(() {
          Nodata = v;
          //print("youdth");
        });
      } else {
        var list = body['data'] as List;
        // Nodata = body['data'];
        // print(list);

        if (res.statusCode == 200) {
          return list.map((e) {
            final map = e as Map<String, dynamic>;
            return DamNumberModel(
              petId: map['pet_id'],
              referBy: map['refer_by'],
              ownerId: map['owner_id'],
              isSecondOwner: map['is_second_owner'],
              secondOwnerId: map['second_owner_id'],
              litterKennelId: map['litter_kennel_id'],
              isNonInkcRegistration: map['is_non_inkc_registration'],
              petName: map['pet_name'],
              breederOwnerId: map['breeder_owner_id'],
              implementedDate: map['implemented_date'],
              birthDate: map['birth_date'],
              petCategoryId: map['pet_category_id'],
              petSubCategoryId: map['pet_sub_category_id'],
              isMicrochipRequire: map['is_microchip_require'],
              petMicrochipNumber: map['pet_microchip_number'],
              uploadMicrochipDocument: map['upload_microchip_document'],
              isDocumentRequire: map['is_document_require'],
              petRegistrationNumber: map['pet_registration_number'],
              sireRegNumber: map['sire_reg_number'],
              sireUserApproval: map['sire_user_approval'],
              sireUserApprovalComment: map['sire_user_approval_comment'],
              sireAdminApproval: map['sire_admin_approval'],
              sireAdminApprovalComment: map['sire_admin_approval_comment'],
              damRegNumber: map['dam_reg_number'],
              damUserApproval: map['dam_user_approval'],
              damUserApprovalComment: map['dam_user_approval_comment'],
              damAdminApproval: map['dam_admin_approval'],
              damAdminApprovalComment: map['dam_admin_approval_comment'],
              implementBy: map['implement_by'],
              implementerName: map['implementer_name'],
              implementerMobileNumber: map['implementer_mobile_number'],
              microchipStatus: map['microchip_status'],
              petGender: map['pet_gender'],
              colorMarking: map['color_marking'],
              brededCountry: map['breded_country'],
              petImage: map['pet_image'],
              frontSideCertificate: map['front_side_certificate'],
              backSideCertificate: map['back_side_certificate'],
              petHeightImage: map['pet_height_image'],
              petSideImage: map['pet_side_image'],
              documentUpload: map['document_upload'],
              petComment: map['pet_comment'],
              isTransferChangedName: map['is_transfer_changed_name'],
              petUpdatedOn: map['pet_updated_on'],
              petCreatedOn: map['pet_created_on'],
              petRegisteredAs: map['pet_registered_as'],
              petChecked: map['pet_checked'],
              isDeath: map['is_death'],
              deathDate: map['death_date'],
              petStatus: map['pet_status'],
              paymentMode: map['payment_mode'],
              paymentComment: map['payment_comment'],
              isPaidForPet: map['is_paid_for_pet'],
            );
          }).toList();
        }
      }
    } catch (e) {}

    throw Exception('Error fetch data');
  }

  // Country
  TextEditingController counrty = new TextEditingController();
  bool countryvalidate = false;

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
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 223, 39, 39)),
                onPressed: () => Navigator.of(context).pop(),
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
            body: SingleChildScrollView(
              child: Container(
                height: 450.sp,
                // width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
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
                  borderRadius: BorderRadius.circular(20.sp),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20, bottom: 15),
                      child: Text(
                        "Number Of Puppies In The Litter",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 209, 13, 13)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 15, bottom: 5, right: 15),
                      child: TextField(
                        maxLines: 1,
                        controller: address,
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.green),
                          ),
                          // labelText: 'Address',
                          hintText: 'Number Of Puppies In The Litters',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isShowOff,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150.0, bottom: 20),
                        child: Text(
                          "Please Enter 0 to 10 number. ",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    if (Nodata.toString() == "false")
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 15, bottom: 5, right: 15),
                        child: TextField(
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          controller: avalable,
                          enabled: false,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.green),
                            ),
                            // labelText: 'Address',
                            hintText: 'No Dog registered yet.',
                          ),
                        ),
                      )
                    else
                      FutureBuilder<List<DamNumberModel>>(
                          future: ColorAndMakingfatch(),
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
                                      value: damnumbers,
                                      onChanged: (value) {
                                        setState(() {
                                          if (damnumbers.toString() == "") {
                                          } else {
                                            damnumbers = value;
                                          }
                                        });
                                      },
                                      items: snapshot.data!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.damRegNumber.toString(),
                                          child: Container(
                                            width: double
                                                .infinity, // Auto size based on content
                                            child: Text(
                                              e.petName.toString(),
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
                                // DropdownButtonFormField(
                                //     decoration: InputDecoration(
                                //       contentPadding: const EdgeInsets.only(
                                //           left: 10, right: 5, bottom: 10),
                                //       border: OutlineInputBorder(
                                //           borderRadius: BorderRadius.all(
                                //               Radius.circular(10))),
                                //     ),
                                //     hint: Text('Select Dog'),
                                //     isExpanded: true,
                                //     // value: chinchan[i],
                                //     items: snapshot.data!.map((e) {
                                //       return DropdownMenuItem(
                                //           value: e.damRegNumber.toString(),
                                //           child: Text(
                                //             e.petName.toString(),
                                //             style: TextStyle(
                                //                 color: Color.fromARGB(
                                //                     255, 95, 46, 46),
                                //                 fontSize: 10.sp,
                                //                 fontWeight: FontWeight.bold),
                                //           ));
                                //     }).toList(),
                                //     onChanged: (value) {
                                //       setState(() {
                                //         if (damnumbers.toString() == "") {
                                //         } else {
                                //           damnumbers = value;
                                //         }
                                //       });
                                //     }),
                              );
                            } else {
                              return Center(
                                  child: Center(
                                child: Text(""),
                              ));
                            }
                          }),
                    Visibility(
                      visible: _damOff,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150.0, bottom: 20),
                        child: Text(
                          "Please select dam number. ",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 140.sp,
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
                                //     );s
                                //   },
                                // ),
                                prefixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.sp)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.green),
                                ),
                                labelText: 'Date of Birth',
                                hintText: '',
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                selectDatePicker();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                'Pick date',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _datecheck,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150.0, bottom: 20),
                        child: Text(
                          "Please select date under 60 day . ",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 12),
                      child: Row(
                        children: [
                          Text(
                            "Country Bred In ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 22, 21, 21),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.sp)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.green),
                          ),
                          labelText: 'Country Bred in',
                          hintText: 'Eg.India',
                          errorText:
                              countryvalidate ? "Value Can't Be Empty" : null,
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 43, 9, 168),
                              textStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color:
                                      const Color.fromARGB(255, 241, 236, 236),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            // Submit();
                            if (counrty.text.toString() == "") {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Please Enter Country',
                              );
                            } else {
                              print(damnumbers.toString() + "audi");
                              setState(() {
                                String va = address.text;
                                int intVal = int.parse(va);
                                if (intVal <= 10 && difference <= 60
                                    //&&
                                    //damnumbers.toString() != "null"
                                    ) {
                                  _isShowOff = false;
                                  _datecheck = false;
                                  _damOff = false;
                                  print(damnumbers);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LitterRegistration(
                                            value: address.text.toString(),
                                            dob: dateofbirth.text.toString(),
                                            // damnumber: damnumbers.toString(),
                                          )));
                                } else {
                                  _isShowOff = true;
                                  _datecheck = true;
                                  _damOff = true;
                                }
                              });
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
