import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inkc/model/InkcRegisterDogmodel.dart';
import 'package:inkc/non_inkc_registor_dog_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class SecondOwnerDod extends StatefulWidget {
  const SecondOwnerDod({super.key});

  @override
  State<SecondOwnerDod> createState() => _SecondOwnerDodState();
}

String userid = "";
String token = "";
String image = "";

class _SecondOwnerDodState extends State<SecondOwnerDod> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<InckRegistrationDog> dataload = [];
  String ifDataisnotavailavle = 'FalseData';

  Future<List<InckRegistrationDog>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print('${userid} / ${token}');

    final uri =
        "https://new-demo.inkcdogs.org/api/dog/inkc_kci_registered_dog_second_own";

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    if (dataarray == false) {
      ifDataisnotavailavle = 'False';
    }

    print(dataarray);
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(InckRegistrationDog.fromJson(index));
        print(index.length.toString());
      }
      print("kaccha aam" + dataload.toString());

      return dataload;
    } else {
      return dataload;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Co-Owned Dogs',
              style: TextStyle(
                  // shadows: [
                  //   Shadow(
                  //     blurRadius: 10.0, // shadow blur
                  //     color: Color.fromARGB(255, 223, 71, 45), // shadow color
                  //     offset: Offset(2.0, 2.0), // how much shadow will be shown
                  //   ),
                  // ],
                  fontSize: 17.sp,
                  decorationColor: Colors.red,
                  color: Color.fromARGB(255, 8, 8, 8),
                  // color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: FutureBuilder(
              future: FetchData(),
              builder: (context, snapshot) {
                if (ifDataisnotavailavle == 'False') {
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No Dog Registered yet.",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 177, 43, 10),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: InkWell(
                          //     child: ElevatedButton(
                          //         onPressed: () {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => INKCStore()),
                          //           );
                          //         },
                          //         child: Text('Go to INKC Store')),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: dataload.length,
                    itemBuilder: (context, position) {
                      return Card(
                        elevation: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                        margin: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 255, 255, 255),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          // decoration: const BoxDecoration(
                          //   image: DecorationImage(
                          //       image: NetworkImage(
                          //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReL_kSGg4Ux5ZiwK-mIRe6_L-Ft8GxRaaT1Q&usqp=CAU"),
                          //       fit: BoxFit.cover),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 150.0.sp,
                                  width: 180.0.sp,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 178, 177, 189),
                                        blurRadius: 5,
                                        offset: Offset(
                                          5,
                                          5,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10.sp),
                                    //set border radius to 50% of square height and width
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://new-demo.inkcdogs.org/${dataload[position].petImage}"),
                                      fit:
                                          BoxFit.cover, //change image fill type
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  // width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: AutoSizeText(
                                            dataload[position]
                                                .petName
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '( ${dataload[position].subCategoryName} )',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 231, 25, 25),
                                                textStyle: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: const Color.fromARGB(
                                                        255, 241, 236, 236),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              print("lastword");
                                              // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>NonInkcRegistrationDog(imag dataload[position].petImage,dataload[position].petName,dataload[position].birthDate,dataload[position].petGender,dataload[position].petRegistrationNumber,dataload[position].subCategoryName,dataload[position].subCategoryName)));

                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (BuildContext context) => NonInkcDogDetails(
                                                      id: dataload[position]
                                                          .petId
                                                          .toString(),
                                                      image: dataload[position]
                                                          .petImage
                                                          .toString(),
                                                      petnames:
                                                          dataload[position]
                                                              .petName
                                                              .toString(),
                                                      dateofbirth:
                                                          dataload[position]
                                                              .birthDate
                                                              .toString(),
                                                      sex: dataload[position]
                                                          .petGender
                                                          .toString(),
                                                      registernumber:
                                                          dataload[position]
                                                              .petRegistrationNumber
                                                              .toString(),
                                                      breed: dataload[position]
                                                          .subCategoryName
                                                          .toString(),
                                                      colorandmaking:
                                                          dataload[position]
                                                              .colorMarking
                                                              .toString())));
                                            },
                                            child: Text(
                                              "Details",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Registration Number - ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                dataload[position]
                                                    .petRegistrationNumber
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  print("dataloadlength");
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
  }
}
