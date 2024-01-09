import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inkc/adddoginfo.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/inkcstore.dart';
import 'package:inkc/litternumber.dart';
import 'package:inkc/main.dart';
import 'package:inkc/model/cartlist.dart';
import 'package:inkc/payment/upi_integrate.dart';
import 'package:inkc/payment/upi_pay.dart';
import 'package:inkc/paymentcart/finalcart.dart';
import 'package:inkc/profile.dart';
// import 'package:quantupi/quantupi.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
// import 'package:upi_india/upi_india.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'dart:async';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Searchpage(),
        );
      },
    );
  }
}

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

String cart_id = "",
    p_id = "",
    p_name = "",
    p_quantity = "",
    p_charges = "",
    p_is_courier_required = "",
    p_pet_id = "",
    p_pet_birth_age = "",
    p_pet_registered_as = "",
    p_is_microchip_require = "",
    access_type = "";

// String product_id = "product_id";
// String product_name = "product_name";
// String product_quantity = "product_quantity";
// String product_charges = "product_charges";
// String is_courier_required = "is_courier_required";

String pet_id_is_available = "pet_id";
// String pet_id = "pet_id";
// String pet_birth_age = "pet_birth_age";
// String pet_registered_as = "pet_registered_as";
// String is_microchip_require = "is_microchip_require";

class _SearchpageState extends State<Searchpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Check();
    //FetchData();
  }

  Check() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("Token");
    if (check != null) {
      print("object with not back");
    } else {
      setState(() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (_) => Login()));
      });
    }
  }

  List<CartList> dataload = [];
  String ifDataisnotavailavle = 'FalseData';

  String userid = "";
  String token = "";
  String image = "";
  String dateset = "";
  String TOTAL = "0";
  int SUBTOTAL = 0;
  int DELEVRY = 0;
  int CHECKTOTAL = 0;
  int chareges_ship = 1;

  var map;
  var mainjson;
  var cart_total;
  var jsonput;
  late List cart_data_product = [];
  late List cart_total_cost = [];
  String checkpage = "first time run";
  int valueinput = 1;

// UPI Interget
  bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Cart',
            style: TextStyle(
                fontSize: 20.sp,
                decorationColor: Colors.red,
                color: Color.fromARGB(255, 22, 22, 21),
                // color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 5.sp),
          child: FutureBuilder(
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
                              "Cart is empty.",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 177, 43, 10),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => INKCStore()),
                                    );
                                  },
                                  child: Text('Go to INKC Store')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  if (snapshot.hasData) {
                    // print(checkpage);
                    // cart_id = "";
                    // p_id = "";
                    // p_name = "";
                    // p_quantity = "";
                    // p_charges = "";
                    // p_is_courier_required = "";
                    // p_pet_id = "";
                    // p_pet_birth_age = "";
                    // p_pet_registered_as = "";
                    // p_is_microchip_require = "";

                    // SUBTOTAL = 0;
                    // DELEVRY = 0;
                    // CHECKTOTAL = 0;
                    // chareges_ship = 1;

                    // cart_data_product.clear();
                    // cart_total_cost.clear();
                    // dataload.clear;
                    // mainjson = null;
                    // map = null;

                    // checkpage = "second time";

                    return ListView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemCount: dataload.length,
                      itemBuilder: (context, position) {
                        if (dataload[position].cartInfo.isNotEmpty) {
                          String text = dataload[position]
                              .cartInfo
                              .toString()
                              .replaceAll("{", "")
                              .replaceAll("}", "");
                          String withoutquotesLine1 = text.replaceAll("\"", "");
                          String withoutquotesLine2 =
                              withoutquotesLine1.replaceAll(":", ",");

                          List strArr = withoutquotesLine2.split(",");

                          for (int i = 0; i < strArr.length; i++) {
                            if (strArr[i].toString() == "product_id") {
                              // print(strArr[i + 1]);
                              p_id = strArr[i + 1];

                              // p_name = strArr[i + 1];
                              // p_quantity = strArr[i + 1];
                              // p_charges = strArr[i + 1];
                              // p_is_courier_required = strArr[i + 1];
                            }

                            // if (strArr[i].toString() == "is_microchip_require") {
                            if (strArr[i].toString() == "product_name") {
                              p_name = strArr[i + 1];
                              //   }
                              // } else {
                              //   p_name = strArr[i + 1];
                            }

                            if (strArr[i].toString() == "product_quantity") {
                              p_quantity = strArr[i + 1];
                            }

                            if (strArr[i].toString() == "pet_id") {
                              p_name = strArr[i - 4] + " " + strArr[i - 3];
                            }

                            if (strArr[i].toString() == "product_charges") {
                              p_charges = strArr[i + 1];
                            }
                            //total = total + total;

                            // if (strArr[i].toString() == "is_courier_required") {
                            //   p_is_courier_required = strArr[i + 1];
                            //   if (chareges_ship ==
                            //       int.parse(p_is_courier_required.toString())) {
                            //     TOTAL = "50";
                            //     DELEVRY = 50;
                            //     CHECKTOTAL = 50;
                            //     chareges_ship++;
                            //     //print("CHECKTOTAL");
                            //   }
                            // }

                            if (strArr[i].toString() == "pet_id") {
                              p_pet_id = strArr[i + 1];
                              // print(p_pet_id);
                            }

                            if (strArr[i].toString() == "pet_birth_age") {
                              p_pet_birth_age = strArr[i + 1];
                            }

                            if (strArr[i].toString() == "pet_registered_as") {
                              p_pet_registered_as = strArr[i + 1];
                            }
                            if (strArr[i].toString() ==
                                "is_microchip_require") {
                              p_is_microchip_require = strArr[i + 1];
                            }
                          }
                          // SUBTOTAL = SUBTOTAL + int.parse(p_charges);

                          // if (CHECKTOTAL == 50) {
                          //   cart_total = {
                          //     "sub_total_cost": SUBTOTAL.toString(),
                          //     "product_id": p_id,
                          //     "product_name": "Courier / Registered / Speed Post",
                          //     "product_charges": 50,
                          //     "total_cost": SUBTOTAL + 50,
                          //   };
                          // } else {
                          //   cart_total = {
                          //     "sub_total_cost": SUBTOTAL.toString(),
                          //     "total_cost": SUBTOTAL + 50,
                          //   };
                          // }

                          // if (p_pet_id.isEmpty) {
                          //   map = {
                          //     "cart_id": dataload[position].cartId,
                          //     "product_id": p_id,
                          //     "product_name": p_name,
                          //     "product_quantity": p_quantity,
                          //     "product_charges": p_charges
                          //   };
                          // } else {
                          //   map = {
                          //     "cart_id": dataload[position].cartId,
                          //     "product_id": p_id,
                          //     "product_name": p_name,
                          //     "p_pet_id": p_pet_id,
                          //     "pet_birth_age": p_pet_birth_age,
                          //     "pet_registered_as": p_pet_registered_as,
                          //     "is_microchip_require": p_is_microchip_require,
                          //     "product_quantity": p_quantity,
                          //     "product_charges": p_charges,
                          //   };
                          //   // print("object check is run");
                          // }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => INKCStore()));
                        }
                        // cart_data_product.add(map);
                        // print(map);

                        return Card(
                          elevation: 5,
                          color: Color.fromARGB(255, 255, 255, 255),
                          margin: EdgeInsets.all(5),
                          child: Container(
                            // height: 140.sp,
                            constraints: BoxConstraints.tightFor(),

                            // width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  offset: Offset(
                                    5,
                                    5,
                                  ),
                                )
                              ],
                              border: Border.all(
                                color: Colors.black,
                                width: 0.3,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(5),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  // onTap: () {
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //       builder: (BuildContext context) =>
                                  //           INKCDogRegistration()));
                                  // },
                                  child: Container(
                                    constraints: BoxConstraints.tightFor(),
                                    child: Image.asset('assets/INKCLogo.png'),
                                    margin: EdgeInsets.only(
                                        top: 12, left: 12, bottom: 12),
                                    height: 100.0.sp,
                                    width: 90.0.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15.sp),

                                      //set border radius to 50% of square height and width

                                      // image: DecorationImage(
                                      //   image: Image.asset(
                                      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMq7svXemr7fVP-3Z5Qvb-TFj5LW4zscRvEGgZnVuXe0N9J6Y7iWm6adhgcxmQJPdyqpw&usqp=CAU"),
                                      // fit: BoxFit.fill, //change image fill type
                                    ),
                                  ),
                                ),
                                // ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30.0, left: 15, right: 20),
                                      child: Container(
                                        width: 150.sp,
                                        child: Text(
                                          '${p_name}',
                                          maxLines: 5,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 19, 11, 10),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 15, right: 20),
                                      child: Text(
                                        ' Quantity : ${p_quantity}',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 53, 52, 52),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0,
                                              left: 15,
                                              right: 20,
                                              bottom: 20),
                                          child: Text(
                                            '₹  ${p_charges}',
                                            style: TextStyle(
                                                shadows: [
                                                  Shadow(
                                                    blurRadius:
                                                        10.0, // shadow blur
                                                    color: Color.fromARGB(
                                                        255,
                                                        223,
                                                        71,
                                                        45), // shadow color
                                                    offset: Offset(2.0,
                                                        2.0), // how much shadow will be shown
                                                  ),
                                                ],
                                                color: Color.fromARGB(
                                                    255, 223, 71, 45),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0,
                                              left: 15,
                                              right: 20,
                                              bottom: 20),
                                          child: ElevatedButton(
                                            child: Text('Delete',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () async {
                                              // print(dataload[position].cartId);
                                              Map<String, String>
                                                  requestHeaders = {
                                                'Accept': 'application/json',
                                                'Usertoken': token,
                                                'Userid': userid
                                              };

                                              final uri =
                                                  "https://new-demo.inkcdogs.org/api/cart/remove_cart_item";

                                              final responce = await http.post(
                                                  Uri.parse(uri),
                                                  body: {
                                                    "cart_id":
                                                        dataload[position]
                                                            .cartId
                                                            .toString(),
                                                  },
                                                  headers: requestHeaders);

                                              var data =
                                                  json.decode(responce.body);
                                              if (data['code'] == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Succesfully Deleted')));

                                                setState(() {});
                                              }

                                              // Navigator.pushReplacement(
                                              //     context;
                                              //     PageRouteBuilder(
                                              //         pageBuilder: (a; b; c) =>
                                              //             Search()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 231, 25, 25),
                                                textStyle: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: const Color.fromARGB(
                                                        255, 241, 236, 236),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Text(
                                //   "Show All Dogs",
                                //   style: TextStyle(color: Colors.black),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    SUBTOTAL = 0;
                    DELEVRY = 0;
                    CHECKTOTAL = 0;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              }),
        ),
        floatingActionButton: Visibility(
          visible: _isShow,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50, right: 18),
            child: DraggableFab(
              child: FloatingActionButton.extended(
                backgroundColor: Color.fromARGB(255, 29, 184, 76),
                foregroundColor: Color.fromARGB(255, 247, 240, 240),
                onPressed: () async {
                  String userId,
                      empFullName,
                      empTypeId,
                      empTypeName,
                      phoneNumber,
                      userVerification,
                      fontUserId,
                      fontEmpFullName,
                      fontEmpTypeId,
                      fontUserEmailId,
                      fontEmpTypeName,
                      fontPhoneNumber,
                      fontUserVerification,
                      fontKennelClubName,
                      fontMemberStatus,
                      userName,
                      userEmpId;
                  SharedPreferences sharedprefrence =
                      await SharedPreferences.getInstance();

                  userId = sharedprefrence.getString("Userid")!;
                  empFullName = sharedprefrence.getString("EmpFullName")!;
                  empTypeId = sharedprefrence.getString("EmpTypeId")!;
                  empTypeName = sharedprefrence.getString("EmpTypeName")!;
                  phoneNumber = sharedprefrence.getString("phoneNumber")!;
                  userVerification =
                      sharedprefrence.getString("UserVerification")!;
                  fontUserId = sharedprefrence.getString("FontUserid")!;
                  fontEmpFullName =
                      sharedprefrence.getString("FontEmpFullName")!;
                  fontEmpTypeId = sharedprefrence.getString("FontEmpTypeId")!;
                  fontUserEmailId =
                      sharedprefrence.getString("FontUserEmailId")!;
                  fontEmpTypeName =
                      sharedprefrence.getString("FontEmpTypeName")!;
                  fontPhoneNumber =
                      sharedprefrence.getString("FontPhoneNumber")!;
                  fontUserVerification =
                      sharedprefrence.getString("FontUserVerification")!;
                  fontKennelClubName =
                      sharedprefrence.getString("FontKennelClubStatus")!;
                  fontMemberStatus =
                      sharedprefrence.getString("FontMemberStatus")!;
                  userName = sharedprefrence.getString("UserName")!;
                  userEmpId = sharedprefrence.getString("UserEmpId")!;

                  mainjson = {
                    "user_id": userId,
                    "user_full_name": empFullName,
                    "emp_type_id": empTypeId,
                    "emp_type_name": empTypeName,
                    "user_phone_number": phoneNumber,
                    "user_verification": userVerification,
                    "front_user_id": fontUserId,
                    "front_user_full_name": fontEmpFullName,
                    "front_emp_type_id": fontEmpTypeId,
                    "front_user_email_id": fontUserEmailId,
                    "front_emp_type_name": fontEmpTypeName,
                    "front_user_phone_number": fontPhoneNumber,
                    "front_user_verification": fontUserVerification,
                    "front_kennel_club_status": fontKennelClubName,
                    "front_member_status": fontMemberStatus,
                    "emp_type_access": access_type,
                    "user_name": userName,
                    "user_employee_id": userEmpId,
                    "cart_total_cost": cart_total,
                    "cart_data_product": cart_data_product
                  };
                  String jsonMap = jsonEncode(mainjson);
                  //print(jsonMap);

                  showModalBottomSheet<void>(
                    enableDrag: false,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 250.sp,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.sp, top: 20.sp, right: 50.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CART TOTAL',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 95, 10, 10),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "SubTotal",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    '₹ ' + SUBTOTAL.toString(),
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 68, 16, 16),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    'Courier ₹   ' + DELEVRY.toString(),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 12, 9, 56),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    '₹ ' + (SUBTOTAL + DELEVRY).toString(),
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 68, 16, 16),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Divider(),
                              Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 80, 3, 3), // Background color
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  FinalCartPrice(
                                                    jsonMap: jsonMap,
                                                    SUBTOTAL:
                                                        SUBTOTAL.toString(),
                                                    DELEVRY: DELEVRY.toString(),
                                                    TOTAL: (SUBTOTAL + DELEVRY)
                                                        .toString(),
                                                  )));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'PROCEED TO CHECKOUT      ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                label: Text(
                  'Cart Total',
                  style: TextStyle(fontSize: 13.sp),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<List<CartList>> FetchData() async {
    print("abhi thik  kr ke deta hu");

    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    cart_id = "";
    p_id = "";
    p_name = "";
    p_quantity = "";
    p_charges = "";
    p_is_courier_required = "";
    p_pet_id = "";
    p_pet_birth_age = "";
    p_pet_registered_as = "";
    p_is_microchip_require = "";

    SUBTOTAL = 0;
    DELEVRY = 0;
    CHECKTOTAL = 0;
    chareges_ship = 1;

    cart_data_product.clear();
    cart_total_cost.clear();
    dataload.clear;
    mainjson = null;
    map = null;

    // print(token);

    final uri = "https://new-demo.inkcdogs.org/api/cart";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
    );
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    access_type = data['access_module'];
    dataload.clear();
    if (dataarray == false) {
      ifDataisnotavailavle = 'False';

      //_isShow = false;
      setState(() {
        _isShow = false;
      });
    } else {
      // _isShow = false;

      // setState(() {
      //   _isShow = true;
      // });
    }

    List sst = dataarray;
    if (data['data'].toString().isNotEmpty) {
      for (int j = 0; j < sst.length; j++) {
        if (data['data'][j]['cart_info'].toString().isNotEmpty) {
          String text = data['data'][j]['cart_info']
              .toString()
              .replaceAll("{", "")
              .replaceAll("}", "");
          String withoutquotesLine1 = text.replaceAll("\"", "");
          String withoutquotesLine2 = withoutquotesLine1.replaceAll(":", ",");

          List strArr = withoutquotesLine2.split(",");
          p_pet_id = "";
          for (int i = 0; i < strArr.length; i++) {
            if (strArr[i].toString() == "product_id") {
              p_id = strArr[i + 1];
            }

            if (strArr[i].toString() == "product_name") {
              p_name = strArr[i + 1];
            }

            if (strArr[i].toString() == "product_quantity") {
              p_quantity = strArr[i + 1];
            }

            if (strArr[i].toString() == "pet_id") {
              p_name = strArr[i - 4] + " " + strArr[i - 3];
            }

            if (strArr[i].toString() == "product_charges") {
              p_charges = strArr[i + 1];
            }

            if (strArr[i].toString() == "is_courier_required") {
              p_is_courier_required = strArr[i + 1];

              if (chareges_ship ==
                  int.parse(p_is_courier_required.toString())) {
                TOTAL = "50";
                DELEVRY = 50;
                CHECKTOTAL = 50;
                chareges_ship++;
              }
            }

            if (strArr[i].toString() == "pet_id") {
              p_pet_id = strArr[i + 1];
            }

            if (strArr[i].toString() == "pet_birth_age") {
              p_pet_birth_age = strArr[i + 1];
            }

            if (strArr[i].toString() == "pet_registered_as") {
              p_pet_registered_as = strArr[i + 1];
            }
            if (strArr[i].toString() == "is_microchip_require") {
              p_is_microchip_require = strArr[i + 1];
            }

            if (p_pet_id.isEmpty) {
              map = {
                "cart_id": data['data'][j]['cart_id'],
                "product_id": p_id,
                "product_name": p_name,
                "product_quantity": p_quantity,
                "product_charges": p_charges
              };
            } else {
              map = {
                "cart_id": data['data'][j]['cart_id'],
                "product_id": p_id,
                "product_name": p_name,
                "p_pet_id": p_pet_id,
                "pet_birth_age": p_pet_birth_age,
                "pet_registered_as": p_pet_registered_as,
                "is_microchip_require": p_is_microchip_require,
                "product_quantity": p_quantity,
                "product_charges": p_charges,
              };
            }
          }

          SUBTOTAL = SUBTOTAL + int.parse(p_charges.toString());
        }

        cart_data_product.add(map);
      }

      if (CHECKTOTAL == 50) {
        cart_total = {
          "sub_total_cost": SUBTOTAL.toString(),
          "product_id": p_id,
          "product_name": "Courier / Registered / Speed Post",
          "product_charges": 50,
          "total_cost": SUBTOTAL + 50,
        };
      } else {
        cart_total = {
          "sub_total_cost": SUBTOTAL.toString(),
          "total_cost": SUBTOTAL + 50,
        };
      }
      // String jsonMap = jsonEncode(cart_data_product);
      // print(jsonMap);
    }

    if (data['code'] == 200) {
      if (responce.statusCode == 200) {
        for (Map<String, dynamic> index in dataarray) {
          dataload.add(CartList.fromJson(index));
        }
        return dataload;
      } else {
        return dataload;
      }
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => Login()));
      return dataload;
    }
  }
}
