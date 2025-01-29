import 'dart:convert';

import 'package:flutter/material.dart' hide CarouselController;

import 'package:http/http.dart' as http;
import 'package:inkc/ResponciveWidget.dart';
import 'package:inkc/model/mytransactionmodel.dart';
import 'package:inkc/myhomepage.dart';
import 'package:inkc/view_reciept.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTransactions extends StatefulWidget {
  const MyTransactions({super.key});

  @override
  State<MyTransactions> createState() => _MyTransactionsState();
}

String userid = "";
String token = "";

class _MyTransactionsState extends State<MyTransactions> {
  List<MyTransactionModel> dataload = [];

  int i = -1;
  var ifDataisnotavailavle;

  Future<List<MyTransactionModel>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    print(userid + "----" + token);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    const uri = "https://new-demo.inkcdogs.org/api/user/my_transactions";

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    print(data.toString());

    var messageforlgout = data['message'];

    if (messageforlgout.toString() == "Invalid user request") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove("Token");
      await preferences.remove("LastName");
      await preferences.remove("First");
      await preferences.remove("UserEmailId");
      await preferences.remove("Userid");
      await preferences.remove("usermobilenumber");
      await preferences.remove("UserLogincheck");
      await preferences.remove("Couponbox");
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => LogOut_Page(
      //               backparam: '0',
      //             )));
    }
    var dataarray = data['data']['order_record'];
    if (dataarray == false) {
      ifDataisnotavailavle = 'False';
    }

    // print(dataarray);
    dataload.clear();
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(MyTransactionModel.fromJson(index));
      }
      // Reverse the order of the dataload list
      dataload = dataload.reversed.toList();

      return dataload;
    } else {
      return dataload;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screeniWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 216, 22, 22)),
            onPressed: () =>  Navigator.of(context).pop(),
          ),
          title: Text(
            "Transaction",
            style: TextStyle(
                color: Color.fromARGB(255, 175, 21, 21),
                fontWeight: FontWeight.w600,
                fontSize: 18),
          )),

      body: WillPopScope(
        onWillPop: () async {
          // Control back button behavior here
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => const MyApp()),
          //   (Route<dynamic> route) => false,
          // );

          Navigator.of(context).pop();

          // return false;
          return false; // Allows default action if there's nothing to pop
        },
        child: FutureBuilder(
            future: FetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child:
                        Text("No transactions")); //'Error: ${snapshot.error}'
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No transaction.'));
              } else if (snapshot.hasData) {
                return Responcivewidget(
                  mobile: Container(
                    margin: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: ListView.builder(
                        itemCount: dataload.length,
                        itemBuilder: (context, index) {
                          // i++;

                          DateTime dateTime = DateTime.parse(
                              dataload[index].paymentCreatedOn.toString());

                          // Format the date to remove time
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(dateTime);

                          // Decode JSON string to a Map
                          Map<String, dynamic> jsonData = jsonDecode(
                              dataload[index].orderDetails.toString());

                          // Extract total_cost
                          int totalCost =
                              jsonData['cart_total_cost']['total_cost'];

                          double amounts =
                              double.parse(totalCost.toString()) ;
                          // print(dataload[index]
                          //     .paymentTransactionAmount
                          //     .toString());

                          // double amounts = double.parse(dataload[index]
                          //     .paymentTransactionAmount
                          //     .toString());
                          //  /
                          // 100.0;

                          return InkWell(
                            onTap: () {},
                            child: Card(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              elevation: 8,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  // gradient: LinearGradient(
                                  //   colors: [
                                  //     Color.fromARGB(255, 41, 29, 70),
                                  //     Color.fromARGB(255, 80, 29, 221)
                                  //   ],
                                  // ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              "       Date:                ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              "       Amount:          ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              amounts
                                                  .toString()
                                                  .replaceAll(".0", ""),
                                              // dataload[index]
                                              //     .paymentTransactionAmount
                                              //     .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(235, 240, 91, 32),
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 236, 236),
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ViewReciept(
                                                            orderdetail: dataload[
                                                                    index]
                                                                .orderDetails
                                                                .toString())));
                                            // SharedPreferences sharedprefrence =
                                            //     await SharedPreferences
                                            //         .getInstance();
                                            // String userid = sharedprefrence
                                            //     .getString("Userid")!;
                                            // String token = sharedprefrence
                                            //     .getString("Token")!;

                                            // // print(dataload[position].cartId);
                                            // Map<String, String> requestHeaders =
                                            //     {
                                            //   'Accept': 'application/json',
                                            //   'Usertoken': token,
                                            //   'Userid': userid,
                                            //   'Usercurrency': "1"
                                            // };

                                            // final uri =
                                            //     "https://affcats.com/api/cat/send_payment_receipt_email";

                                            // final responce = await http.post(
                                            //     Uri.parse(uri),
                                            //     body: {
                                            //       "payment_id": dataload[index]
                                            //           .paymentId
                                            //           .toString()
                                            //     },
                                            //     headers: requestHeaders);

                                            // var data =
                                            //     json.decode(responce.body);
                                            // if (data['code'] == 200) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(SnackBar(
                                            //           content: Text(data[
                                            //                       'message']
                                            //                   .toString() +
                                            //               " send to email")));
                                            //   print(data['message'].toString());

                                            //   // setState(() {});
                                            // } else {
                                            //   print(data['message'].toString());

                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(SnackBar(
                                            //           content: Text(
                                            //               data['message']
                                            //                   .toString())));
                                            // }
                                          },
                                          child: const Text(
                                            "View receipt",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  tab: Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    margin: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: dataload.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                              dataload[index].paymentCreatedOn.toString());

                          // Format the date to remove time
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(dateTime);

                          // Decode JSON string to a Map
                          Map<String, dynamic> jsonData = jsonDecode(
                              dataload[index].orderDetails.toString());

                          // Extract total_cost
                          int totalCost =
                              jsonData['cart_total_cost']['total_cost'];

                          double amounts =
                              double.parse(totalCost.toString());
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              elevation: 10,
                              margin: const EdgeInsets.all(10),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Date: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              "Amount: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              amounts.toString(),
                                              // dataload[index]
                                              //     .paymentTransactionAmount
                                              //     .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xEBA020F0),
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 236, 236),
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ViewReciept(
                                                            orderdetail: dataload[
                                                                    index]
                                                                .orderDetails
                                                                .toString())));

                                            // print(dataload[index]
                                            //     .paymentOrderDetails
                                            //     .toString());

                                            // SharedPreferences sharedprefrence =
                                            //     await SharedPreferences
                                            //         .getInstance();
                                            // String userid = sharedprefrence
                                            //     .getString("Userid")!;
                                            // String token = sharedprefrence
                                            //     .getString("Token")!;

                                            // // print(dataload[position].cartId);
                                            // Map<String, String> requestHeaders =
                                            //     {
                                            //   'Accept': 'application/json',
                                            //   'Usertoken': token,
                                            //   'Userid': userid,
                                            //   'Usercurrency': "1"
                                            // };

                                            // final uri =
                                            //     "https://affcats.com/api/cat/send_payment_receipt_email";

                                            // final responce = await http.post(
                                            //     Uri.parse(uri),
                                            //     body: {
                                            //       "payment_id": dataload[index]
                                            //           .paymentId
                                            //           .toString()
                                            //     },
                                            //     headers: requestHeaders);

                                            // var data =
                                            //     json.decode(responce.body);
                                            // if (data['code'] == 200) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(SnackBar(
                                            //           content: Text(data[
                                            //                       'message']
                                            //                   .toString() +
                                            //               " send to email")));
                                            //   print(data['message'].toString());

                                            //   // setState(() {});
                                            // } else {
                                            //   print(data['message'].toString());

                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(SnackBar(
                                            //           content: Text(
                                            //               data['message']
                                            //                   .toString())));
                                            // }
                                          },
                                          child: const Text(
                                            "Receipt",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
