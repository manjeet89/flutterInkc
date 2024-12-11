import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inkc/myhomepage.dart';
import 'package:lottie/lottie.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );
//   runApp(const SplashScreen());
//   configLoading();
// }

// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false;
//   // ..customAnimation = CustomAnimation();
// }

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
        const Duration(seconds: 10),
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
                'https://lottie.host/a75cf6af-da8b-4f2d-8e00-5fba30ea82f7/YyPdKBiS70.json', // Replace with the path to your Lottie JSON file
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
