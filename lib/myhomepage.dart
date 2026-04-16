import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/ChatBot/pages/chatbot_page.dart';
import 'package:inkc/bottom_nav_pages/bar.dart';
import 'package:inkc/bottom_nav_pages/more.dart';
import 'package:inkc/bottom_nav_pages/search.dart';
import 'package:inkc/model/cartlist.dart';
import 'package:inkc/version_check/VersionChecker.dart';
import 'package:inkc/version_check/version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'bottom_nav_pages/home.dart';
import 'bottom_nav_pages/notification.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp(
    indexvalue: 0,
  ));
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
  final int indexvalue; // Declare the indexvalue as a final field
  const MyApp({super.key, required this.indexvalue});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'inck', indexvalue: indexvalue),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int indexvalue; // Declare the indexvalue as a final field
  const MyHomePage({super.key, required this.title, required this.indexvalue});

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
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.indexvalue; // Initialize currentPageIndex with indexvalue

    _checkForUpdate();
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
    const HomePages(),
    const Barpage(),
    const NotificationPage(),
    const Search(),
    const More(),
    const ChatBotPage(),
  ];

  int currnetIndec = 0;
  int _selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      currnetIndec = index;
      _selectedIndex = index;
    });
  }

  bool _hasShownUpdateDialog = false;

  Future<void> _checkForUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    // Fetch latest version from Play Store
    final latestVersion = await VersionChecker.getAndroidVersionFromGooglePlay();

    if (latestVersion != null) {
      final current = Version.parse(currentVersion);
      final latest = Version.parse(latestVersion);

      print("${currentVersion}nothing");
      print(latestVersion.toString());

      if (current < latest) {
        _showUpdateDialog();
      }
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text('Update Available', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        content: const Text(
          'A newer version is available. Please update your app.',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _hasShownUpdateDialog = true; // Ensure dialog is shown only once
            },
            child: const Text('Close', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
          TextButton(
            onPressed: () async {
              var url = Uri.parse(
                  "https://play.google.com/store/apps/details?id=net.inkcdogs.doggylocker");
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              } // Ensure dialog is shown only once
            },
            child: const Text('Update', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // if (_selectedIndex != 0) {
    //   setState(() {
    //     _selectedIndex = 0;
    //   });
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final navigator = Navigator.of(context);

        // ✅ 1. If inner screen exists → go back
        if (navigator.canPop()) {
          navigator.pop();
          return;
        }

        // ✅ 2. If not on Home → go to Home
        if (currentPageIndex != 0) {
          setState(() {
            currentPageIndex = 0;
          });
          return;
        }

        // ✅ 3. If already on Home → exit app
        SystemNavigator.pop();
      },
      child: Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            elevation: 0,
            indicatorColor: Colors.green,
            backgroundColor: Colors.white,
            selectedIndex: currentPageIndex,
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            destinations: const <Widget>[
              NavigationDestination(
                label: '',
                icon: Icon(Icons.home),
              ),
              NavigationDestination(
                label: '',
                icon: Icon(Icons.supervisor_account_outlined),
              ),
              // NavigationDestination(
              //   icon: Badge(child: Icon(Icons.pets)),
              //   label: 'My Pets',
              // ),
              NavigationDestination(
                selectedIcon: Icon(Icons.more_horiz_outlined, color: Colors.white),
                label: '',
                icon: Icon(Icons.notifications),
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.more_horiz_outlined, color: Colors.white),
                label: '',
                // icon: badges.Badge(
                //   badgeContent: Text(
                //     dataload.length.toString(),
                //     style: const TextStyle(color: Colors.white),
                //   ),
                //   child:
                icon: Icon(Icons.shopping_cart),
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.more_horiz_outlined, color: Colors.white),
                label: '',
                icon: Icon(Icons.person),
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.more_horiz_outlined, color: Colors.white),
                label: '',
                icon: Icon(Icons.star_border_purple500_rounded),
              ),

              // NavigationDestination(
              //   icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
              //   label: 'Messages',
              // ),
            ],
          ),
          body: <Widget>[
            const HomePages(),
            const Barpage(),
            const NotificationPage(),
            const Search(),
            const More(),
            const ChatBotPage(),
          ][currentPageIndex]),
    );
    // return WillPopScope(
    //   onWillPop: () async {
    //     // Check if there are pages in the Navigator stack
    //     if (Navigator.of(context).canPop()) {
    //       Navigator.of(context).pop();
    //       return false; // Prevent default behavior
    //     }

    //     // If no pages in the stack, navigate to home page
    //     if (currnetIndec != 0) {
    //       setState(() {
    //         currnetIndec = 0;
    //       });
    //       return false; // Prevent the app from closing
    //     }

    //     return true; // Allow the app to close
    //   },
    //   child: Scaffold(
    //     body: pages[currnetIndec],
    //     bottomNavigationBar: BottomNavigationBar(
    //         type: BottomNavigationBarType.shifting,
    //         backgroundColor: Colors.black,
    //         onTap: onTap,
    //         currentIndex: currnetIndec,
    //         selectedItemColor: Colors.black,
    //         unselectedItemColor: Colors.grey.withOpacity(1.0),
    //         showSelectedLabels: false,
    //         showUnselectedLabels: false,
    //         elevation: 0,
    //         items: [
    //           const BottomNavigationBarItem(
    //             label: 'Home',
    //             icon: Icon(Icons.home),
    //             backgroundColor: Colors.white,
    //           ),
    //           const BottomNavigationBarItem(
    //             label: 'Our Serves',
    //             icon: Icon(Icons.supervisor_account_outlined),
    //             backgroundColor: Colors.white,
    //           ),
    //           const BottomNavigationBarItem(
    //             label: 'Notification',
    //             icon: Icon(Icons.notifications),
    //             backgroundColor: Colors.white,
    //           ),
    //           BottomNavigationBarItem(
    //               label: 'Cart',
    //               icon: badges.Badge(
    //                 badgeContent: Text(
    //                   dataload.length.toString(),
    //                   style: const TextStyle(color: Colors.white),
    //                 ),
    //                 child: const Icon(Icons.shopping_cart),
    //               )),
    //           const BottomNavigationBarItem(
    //             label: 'More',
    //             icon: Icon(Icons.person),
    //             backgroundColor: Colors.white,
    //           ),
    //           const BottomNavigationBarItem(
    //             label: 'Chatbot',
    //             icon: Icon(Icons.star_border_purple500_rounded),
    //             backgroundColor: Colors.white,
    //           ),
    //         ]),
    //   ),
    // );
  }

  Future<List<CartList>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    print("$token --- $userid");

    const uri = "https://new-demo.inkcdogs.org/api/cart";

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
