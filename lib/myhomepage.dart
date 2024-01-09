import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:inkc/bottom_nav_pages/bar.dart';
import 'package:inkc/bottom_nav_pages/more.dart';
import 'package:inkc/bottom_nav_pages/search.dart';
import 'package:inkc/credential/login.dart';
import 'package:inkc/model/cartlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'bottom_nav_pages/home.dart';
import 'bottom_nav_pages/notification.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'inck'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int count = 0;

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  late double _progress;

  List<CartList> dataload = [];

  String userid = "";
  String token = "";
  String image = "";
  String dateset = "";

  @override
  void initState() {
    super.initState();
    FetchData();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    //EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  List pages = [
    HomePages(),
    Barpage(),
    NotificationPage(),
    Search(),
    More(),
  ];

  int currnetIndec = 0;

  void onTap(int index) {
    setState(() {
      currnetIndec = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currnetIndec],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.black,
          onTap: onTap,
          currentIndex: currnetIndec,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(1.0),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              label: 'Our Serves',
              icon: Icon(Icons.supervisor_account_outlined),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              label: 'Notification',
              icon: Icon(Icons.notifications),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
                label: 'Cart',
                icon: badges.Badge(
                  badgeContent: Text(
                    dataload.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(Icons.shopping_cart),
                )),
            BottomNavigationBarItem(
              label: 'More',
              icon: Icon(Icons.person),
              backgroundColor: Colors.white,
            ),
          ]),
    );
  }

  Future<List<CartList>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    print(token);

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
    dataload.clear();

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(CartList.fromJson(index));
      }
      count = dataload.length;
      print(count);
      return dataload;
    } else {
      return dataload;
    }
  }
}
