import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inkc/myhomepage.dart';
import 'package:lottie/lottie.dart';



final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // dataChech();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FireBaseApi().initNotification();

  runApp(const Splash());

  configLoading();
}

// void dataChech() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await FireBaseApi().initNotification();
// }

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );
//   runApp(const Splash());
//   configLoading();
// }

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

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INKC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      // initialRoute: '/',
      home: const SplashScreen(),
      // routes: {
      //   'SplashScreen': (context) => SplashScreen(),
      //   '/Events': (context) => Events(),
      // },
      //{'SplashScreen': (BuildContext context) => Events()},
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.network(
                'https://lottie.host/7478d65a-774b-4584-8b8f-6e35a487e1c0/NGCMs69Nh1.json', // Replace with the path to your Lottie JSON file
                fit: BoxFit.cover,
                width: 400, // Adjust the width and height as needed
                height: 400,
                repeat: true, // Set to true if you want the animation to loop
              ),
            ),
            const Center(
              child: Text(
                "Welcome to DoggyLocker",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
