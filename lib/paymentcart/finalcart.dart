import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class FinalCartPrice extends StatefulWidget {
  final String jsonMap, SUBTOTAL, DELEVRY, TOTAL;
  FinalCartPrice(
      {required this.jsonMap,
      required this.SUBTOTAL,
      required this.DELEVRY,
      required this.TOTAL});

  @override
  State<FinalCartPrice> createState() => _FinalCartPriceState();
}

class _FinalCartPriceState extends State<FinalCartPrice> {
  TextEditingController email = new TextEditingController();
  TextEditingController address = new TextEditingController();
  String? FontPhoneNumber;

  insert() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();

    String fulladdress = sharedprefrence.getString("fulladdress")!;
    String FontUserEmailId = sharedprefrence.getString("FontUserEmailId")!;
    FontPhoneNumber = sharedprefrence.getString("FontPhoneNumber")!;

    email.value = TextEditingValue(text: FontUserEmailId.toString());
    address.value = TextEditingValue(text: fulladdress.toString());
  }

  create_order_id() async {
    String keyId = "rzp_live_nU6fTpMrFHPTY1";
    String keySecreste =
        "RZDbsZE5vKJT24W1Get8qHZ1"; //"RZDbsZE5vKJT24W1Get8qHZ1";  //543LAwFTauwRyw0Tw2PPBbG5
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$keyId:$keySecreste'))}';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': basicAuth
    };

    Map<String, dynamic> oder = {
      'amount': int.parse(widget.TOTAL) * 100,
      'currency': "INR",
      'receipt': 'recptid_11'
    };

    var res = await http.post(Uri.https("api.razorpay.com", "v1/orders"),
        headers: requestHeaders, body: jsonEncode(oder));
    if (res.statusCode == 200) {
      print(" i amw wating" + res.body.toString());
      RazorpayRun(jsonDecode(res.body)['id']);
    } else {
      print(" i amw wating");
    }
  }

  RazorpayRun(String orderid) async {
    var options = {
      'key':
          'rzp_live_nU6fTpMrFHPTY1', //rzp_live_nU6fTpMrFHPTY1  // rzp_test_tk6cduSzgywMwB
      'amount': (int.parse(widget.TOTAL) * 100)
          .toString(), //in the smallest currency sub-unit.
      'name': 'DoggyLocker',
      'order_id': orderid,
      //     'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      // 'description': 'Fine T-Shirt',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': FontPhoneNumber.toString(),
        'email': email.text.toString()
      }
    };
    _razorpay.open(options);
  }

  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    insert();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds

    print("payment done     " +
        response.orderId.toString() +
        " - " +
        response.paymentId.toString() +
        " - " +
        response.signature.toString());

    var ordertotal = {
      'razorpay_payment_id': response.paymentId.toString(),
      'razorpay_order_id': response.orderId.toString(),
      'razorpay_signature': response.signature.toString()
    };
    String Orders = jsonEncode(ordertotal);

    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    print("Toal Check Data" +
        widget.jsonMap.toString() +
        "Ring " +
        Orders.toString());

    final uri = "https://www.inkc.in/api/store/success_fullpayment";

    final responce = await http.post(Uri.parse(uri),
        body: {
          "payment_details": Orders.toString(),
          "order_details": widget.jsonMap.toString(),
        },
        headers: requestHeaders);
    var data = json.decode(responce.body);
    print(data);

    if (data['code'] == 200) {
      print(data['message']);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Successfull Payment')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Successfull Payment',
        style: TextStyle(color: Color.fromARGB(255, 12, 2, 2)),
      ),
      backgroundColor: Color.fromARGB(255, 236, 234, 241),
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment falied");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Payment Failed',
      style: TextStyle(color: Colors.white),
    )));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle Android hardware back button press
        Navigator.pop(context);
        return false; // Prevent default behavior
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Billing Details',
              style: TextStyle(
                fontSize: 20,
                decorationColor: Colors.red,
                color: Color.fromARGB(255, 22, 22, 21),
                // color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: 450.sp,
              child: Container(
                margin: EdgeInsets.only(left: 10.sp, top: 20.sp, right: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp),
                        controller: email,

                        // obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.sp)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.green),
                          ),
                          labelText: 'Email Address',
                          hintText: 'Rajbhar',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp),
                        controller: address,
                        enabled: false,
                        maxLines: 4,
                        // obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.sp)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.green),
                          ),
                          labelText: ' Address',
                          hintText: 'Rajbhar',
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'CART TOTAL',
                        style: TextStyle(
                            color: Color.fromARGB(255, 8, 83, 1),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 28.0, right: 48, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SubTotal",
                            style: TextStyle(
                                color: Color.fromARGB(255, 153, 4, 4),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            '₹ ' + widget.SUBTOTAL,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 153, 4, 4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 153, 4, 4),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            'Courier ₹ ' + widget.DELEVRY.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 153, 4, 4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 28.0, top: 5, right: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 153, 4, 4),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            '₹ ' + widget.TOTAL.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 153, 4, 4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Divider(),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(
                                255, 8, 83, 1), // Background color
                          ),
                          onPressed: () {
                            create_order_id();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PROCEED TO CHECKOUT      ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.white)
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    // TODO: implement dispose
    super.dispose();
  }
}
