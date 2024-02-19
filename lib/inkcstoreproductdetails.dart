import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
import 'package:inkc/bottom_nav_pages/more.dart';
import 'package:inkc/bottom_nav_pages/notification.dart';
import 'package:inkc/bottom_nav_pages/search.dart';
import 'package:inkc/inkcstore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class INKCDetails extends StatefulWidget {
  String image,
      productName,
      productfacePrice,
      productactualPrice,
      prductdescription,
      productId;
  INKCDetails(
      {required this.image,
      required this.productName,
      required this.productfacePrice,
      required this.productactualPrice,
      required this.prductdescription,
      required this.productId});

  @override
  State<INKCDetails> createState() => _INKCDetailsState(image, productName,
      productfacePrice, productactualPrice, prductdescription, productId);
}

String userid = "";
String token = "";
String image = "";
String dateset = "";

class _INKCDetailsState extends State<INKCDetails> {
  int i = 1;

  _INKCDetailsState(String image, String productName, String productfacePrice,
      String productactualPrice, String prductdescription, String productId);

  bool showSpinner = false;

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
    setState(() {
      showSpinner = false;
    });

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
                  'INKC Product Details',
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
                      fontSize: 20.sp,
                      decorationColor: Colors.red,
                      color: Color.fromARGB(255, 194, 97, 33),
                      // color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, position) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: [
                          Container(
                            height: 180.0.sp,
                            width: 250.0.sp,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 179, 168, 206),
                                  blurRadius: 7.0,
                                  spreadRadius: 10.0,
                                  offset: Offset(
                                    5,
                                    5,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(5.sp),
                              //set border radius to 50% of square height and width
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://www.inkc.in/${widget.image}"),
                                fit: BoxFit.cover, //change image fill type
                              ),
                            ),
                          ),
                          Container(
                            // width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      widget.productName,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '₹ ${widget.productfacePrice}',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12.sp,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '₹ ${widget.productactualPrice}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        //print("sanskar");
                                        // setState(() {
                                        showSpinner = true;
                                        // });
                                        SharedPreferences sharedprefrence =
                                            await SharedPreferences
                                                .getInstance();
                                        userid = sharedprefrence
                                            .getString("Userid")!;
                                        token =
                                            sharedprefrence.getString("Token")!;

                                        final uri =
                                            "https://www.inkc.in/api/cart/add_to_cart";
                                        Map<String, String> requestHeaders = {
                                          //'Accept': 'application/json',
                                          'Usertoken': token,
                                          'Userid': userid
                                        };

                                        print('${widget.productId} - $i');
                                        final responce = await http.post(
                                          Uri.parse(uri),
                                          headers: requestHeaders,
                                          body: {
                                            "product_id":
                                                widget.productId.toString(),
                                            "product_quantity":
                                                "${i.toString()}"
                                          },
                                        );

                                        var data = json.decode(responce.body);
                                        print(data);
                                        if (data['code'] == 200) {
                                          //RefreshCart();
                                          // setState(() {
                                          showSpinner = false;
                                          // });
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            title: 'Success...',
                                            text: 'Please Check your cart',
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text('Successfull...')));
                                          setState(() {
                                            RefreshCart();
                                          });
                                        } else {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text: 'Please login first .',
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Something went wring')));
                                        }

                                        // That's it to display an alert, use other properties to customize.
                                      },
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 231, 25, 25),
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: const Color.fromARGB(
                                                  255, 241, 236, 236),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 65.sp, right: 30.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Quantity",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Ink(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          50.0)), //<-- SEE HERE
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(10.0.sp),
                                    onTap: () {
                                      setState(() {
                                        if (i > 1) i--;
                                      });
                                      // Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0.sp),
                                          child: Icon(
                                            Icons.remove,
                                            size: 20.0.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  '$i',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Ink(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          50.0)), //<-- SEE HERE
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(10.0.sp),
                                    onTap: () {
                                      setState(() {
                                        if (i >= 1) i++;
                                      });
                                      //  Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0.sp),
                                          child: Icon(
                                            Icons.add,
                                            size: 20.0.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 180.0.sp,
                              width: double.infinity,
                              child: Text(
                                widget.prductdescription,
                                // 'A microchip is a radio-frequency identification transpnder that carries a unique identification number , and is roughly the size of a grain of rice',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
