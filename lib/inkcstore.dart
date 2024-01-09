import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'inkcstoreproductdetails.dart';
import 'model/storelistmodel.dart';

class INKCStore extends StatefulWidget {
  // const INKCStore({super.key});

  @override
  State<INKCStore> createState() => _INKCStoreState();
}

String userid = "";
String token = "";
String image = "";

class _INKCStoreState extends State<INKCStore> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<StoreListModel> dataload = [];

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back,
            //       color: Color.fromARGB(255, 223, 39, 39)),
            //   onPressed: () => Navigator.of(context).push(
            //       MaterialPageRoute(builder: (BuildContext context) => Home())),
            // ),
            title: Text(
              'INKC Store',
              style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 10.0, // shadow blur
                      color: Color.fromARGB(255, 223, 71, 45), // shadow color
                      offset: Offset(2.0, 2.0), // how much shadow will be shown
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
          body: FutureBuilder(
              future: FetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: dataload.length,
                    itemBuilder: (context, position) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                height: 100.0.sp,
                                width: 100.0.sp,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 178, 177, 189),
                                      blurRadius: 5,
                                      offset: Offset(
                                        5,
                                        5,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(50.sp),
                                  //set border radius to 50% of square height and width
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://new-demo.inkcdogs.org/${dataload[position].productImage}"),
                                    fit: BoxFit.cover, //change image fill type
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                width: 150.sp,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10, bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 5,
                                        dataload[position].productName,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '₹ ${dataload[position].actualPrice}',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 12.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '₹ ${dataload[position].nonMemberFee}',
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600),
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
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    INKCDetails(
                                                        image: dataload[position]
                                                            .productImage,
                                                        productName:
                                                            dataload[position]
                                                                .productName,
                                                        productfacePrice:
                                                            dataload[position]
                                                                .actualPrice,
                                                        productactualPrice:
                                                            dataload[position]
                                                                .nonMemberFee,
                                                        prductdescription:
                                                            dataload[position]
                                                                .productDescription,
                                                        productId:
                                                            dataload[position]
                                                                .productId)));
                                          },
                                          child: Text(
                                            "Details",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<List<StoreListModel>> FetchData() async {
    final uri = "https://new-demo.inkcdogs.org/api/home/store_list";

    final responce = await http.post(Uri.parse(uri));
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    //print(dataarray);

    if (data['code'].toString() == "200") {}
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(StoreListModel.fromJson(index));
      }
      //  print(dataarray);
      return dataload;
    } else {
      return dataload;
    }
  }
}
