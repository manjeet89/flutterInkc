import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  String? productId;
  String? productName;
  String? productCharges;
  String? petId;
  int? petBirthAge;
  String? petRegisteredAs;
  String? productQuantity;
  int? isMicrochipRequire;
  int? isCourierRequired;
  String? cartId;

  CartItem(
      {this.productId,
      this.productName,
      this.productCharges,
      this.petId,
      this.petBirthAge,
      this.petRegisteredAs,
      this.productQuantity,
      this.isMicrochipRequire,
      this.isCourierRequired,
      this.cartId});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productCharges = json['product_charges'];
    petId = json['pet_id'];
    petBirthAge = json['pet_birth_age'];
    petRegisteredAs = json['pet_registered_as'];
    productQuantity = json['product_quantity'];
    isMicrochipRequire = json['is_microchip_require'];
    isCourierRequired = json['is_courier_required'];
    cartId = json['cart_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_charges'] = this.productCharges;
    data['pet_id'] = this.petId;
    data['pet_birth_age'] = this.petBirthAge;
    data['pet_registered_as'] = this.petRegisteredAs;
    data['product_quantity'] = this.productQuantity;
    data['is_microchip_require'] = this.isMicrochipRequire;
    data['is_courier_required'] = this.isCourierRequired;
    data['cart_id'] = this.cartId;
    return data;
  }
}

class ViewReciept extends StatefulWidget {
  String orderdetail;
  ViewReciept({required this.orderdetail, super.key});

  @override
  State<ViewReciept> createState() => _ViewRecieptState();
}

class _ViewRecieptState extends State<ViewReciept> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addressCheck();
  }

  bool Currencyvalid = false;
  // addressCheck() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   // String? check = sharedprefrence.getString("First");
  //   String? ccountryheck = sharedprefrence.getString("CountryCode");

  //   if (ccountryheck == "101") {
  //     setState(() {
  //       Currencyvalid = false;
  //     });
  //   } else {
  //     setState(() {
  //       Currencyvalid = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Parse the JSON string.
    // print(map.toString());
    double screeniWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (widget.orderdetail.toString() == "\"\"") {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xEBA020F0),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Transactions Details",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            )),
        body: const Center(
          child: Text(
            "No Data",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      Map<String, dynamic> data = jsonDecode(widget.orderdetail);
      List<dynamic> cartRecords = data['cart_data_product'];

      // // Decode JSON string to a Map
      // Map<String, dynamic> jsonData = jsonDecode(widget.orderdetail);

      // // Extract total_cost
      // int totalCost = jsonData['cart_total_cost']['product_charges'];
      // // double amounts = double.parse(totalCost.toString());
      // print(totalCost.toString());

      // Calculate the total price in dollars.
      double totalDollarPrice = cartRecords.fold(0, (sum, item) {
        return sum + double.parse(item['product_charges'].toString());
      });

      return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xEBA020F0),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Transactions Details",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "      All product details.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 163, 5, 5),
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PRODUCTS",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, left: 10, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "      QUANTITY	",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AMOUNT",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true, // Ensures auto height
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartRecords.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartRecords[index];
                    return Card(
                      elevation: 3,
                      color: const Color.fromARGB(255, 254, 254, 255),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellow,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          // borderRadius: BorderRadius.all(Radius.circular(20),),
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Color.fromARGB(255, 41, 29, 70),
                          //     Color.fromARGB(255, 80, 29, 221)
                          //   ],
                          // ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //producat name
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 10, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screeniWith * 0.40,
                                          child: Text(
                                            maxLines: null,
                                            cartItem['product_name']
                                                .toString()
                                                .replaceAll("<br>", ""),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    235, 190, 0, 0),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 10, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screeniWith * 0.10,
                                          child: Text(
                                            cartItem['product_quantity']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    235, 190, 0, 0),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screeniWith * 0.15,
                                          child: Text(
                                            "INR (₹) ${cartItem['product_charges']}",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    235, 190, 0, 0),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // price
                            ],
                          ),
                        ),
                      ),
                    );

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(cartItem['cart_description']),
                    //     Text(
                    //       'Quantity: ${cartItem['cart_quantity']} | Price: \$${cartItem['cart_purchase_price_dollar']}',
                    //     ),
                    //   ],
                    //   // title:
                    //   // subtitle: Text(
                    //   //   'Quantity: ${cartItem['cart_quantity']} | Price: \$${cartItem['cart_purchase_price_dollar']}',
                    //   // ),
                    //   // trailing: cartItem['cart_is_paid'] == "1"
                    //   //     ? Icon(Icons.check_circle, color: Colors.green)
                    //   //     : Icon(Icons.pending, color: Colors.red),
                    // );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Price:  (₹) ${totalDollarPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

//   @override
//   Widget build(BuildContext context) {
//     // var datas = widget.orderdetail;
//     // var data = json.decode(datas);

//     final String jsonString = widget.orderdetail.toString();

//     final Map<String, dynamic> jsonData = jsonDecode(jsonString);

//     // Extract the cart records.
//     final List<dynamic> cartRecords =
//         jsonData['payment_order_details']['cart_record'];
//     List<CartItem> cartItems =
//         cartRecords.map((item) => CartItem.fromJson(item)).toList();

//     // final List<Map<String, dynamic>> cartData =
//     //     data['payment_order_details']['cart_record'];

//     // print(cartData.toString());

//     // print(cartData);

//     // List<CartItem> cartItems =
//     //     cartData.map((item) => CartItem.fromJson(item)).toList();
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Color(0xEBA020F0),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back,
//                 color: Color.fromARGB(255, 255, 255, 255)),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text(
//             "Transactions Details",
//             style: TextStyle(
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18),
//           )),
//       body: Column(
//         children: [
//           Container(
//             color: Color.fromARGB(255, 255, 255, 255),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Text(
//                     "      All product details.",
//                     style: TextStyle(
//                         color: const Color.fromARGB(255, 163, 5, 5),
//                         fontWeight: FontWeight.w700,
//                         fontSize: 15),
//                   ),
//                 ),
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0, left: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "PRODUCTS",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 8.0, left: 10, bottom: 8),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "      QUANTITY	",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0, left: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "AMOUNT",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           ListView.builder(
//               shrinkWrap: true, // Ensures auto height
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];

//                 // try{
//                 //     print(datas['payment_order_details']);
//                 // }catch(e){

//                 // }
//                 return Text(
//                   'Quantity: ${item.cartQuantity} | Price: \$${item.cartPurchasePriceDollar}',
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }

// class CartScreen extends StatelessWidget {
//   // final List<Map<String, dynamic>> cartData = [
//   //   {
//   //     "cart_id": 18,
//   //     "cart_user_id": 22,
//   //     "cart_product_id": 1,
//   //     "cart_description": "Individual Registration | massi",
//   //     "cart_details": {"cat_id": "109886"},
//   //     "cart_quantity": 1,
//   //     "cart_purchase_price": 500,
//   //     "cart_purchase_price_dollar": 7,
//   //     "is_in_cart": 1,
//   //     "cart_is_paid": 0,
//   //     "is_cart_api": 0,
//   //     "cart_user_currency": 2,
//   //     "cart_created_on": "2024-08-14 11:56:53"
//   //   },
//   //   {
//   //     "cart_id": 19,
//   //     "cart_user_id": 22,
//   //     "cart_product_id": 2,
//   //     "cart_description": "Individual Registration with Microchip | mak",
//   //     "cart_details": {"cat_id": "109889"},
//   //     "cart_quantity": 1,
//   //     "cart_purchase_price": 800,
//   //     "cart_purchase_price_dollar": 10,
//   //     "is_in_cart": 1,
//   //     "cart_is_paid": 0,
//   //     "is_cart_api": 0,
//   //     "cart_user_currency": 2,
//   //     "cart_created_on": "2024-08-14 12:05:56"
//   //   }
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     // List<CartItem> cartItems =
//     //     cartData.map((item) => CartItem.fromJson(item)).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           final item = cartItems[index];
//           return ListTile(
//             title: Text(item.cartDescription),
//             subtitle: Text(
//               'Quantity: ${item.cartQuantity} | Price: \$${item.cartPurchasePriceDollar}',
//             ),
//             trailing: item.cartIsPaid
//                 ? Icon(Icons.check_circle, color: Colors.green)
//                 : Icon(Icons.pending, color: Colors.red),
//           );
//         },
//       ),
//     );
//   }
// }
