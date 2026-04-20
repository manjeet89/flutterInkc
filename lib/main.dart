import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:inkc/KennelClub/kennelclubname.dart';
import 'package:inkc/NewPageForLoginModule/FirstUpdateProfile.dart';
import 'package:inkc/Updated_pages_dogs_registered/single_dog_registration_process.dart';
import 'package:inkc/Updated_pages_litter_registration/litter_registration_home_page.dart';
import 'package:inkc/VerificationOtpController/OtpGet.dart';
import 'package:inkc/app/routes/app_pages.dart';
import 'package:inkc/bottom_nav_pages/bar.dart';
import 'package:inkc/credential/Verification.dart';
import 'package:inkc/events/events.dart';
import 'package:inkc/inkcstore.dart';
import 'package:inkc/mydoginfo.dart';
import 'package:inkc/myhomepage.dart';
import 'package:inkc/profile.dart';
import 'package:inkc/profile_update.dart';
import 'package:lottie/lottie.dart';

// At the top of your main.dart file
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
  // runApp(
  //   GetMaterialApp(
  //     title: "Application",
  //     initialRoute: AppPages.INITIAL,
  //     getPages: AppPages.routes,
  //     debugShowCheckedModeBanner: false,
  //   ),
  // );
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
      routes: {
        '/home': (context) => MyApp(indexvalue: 0),
        '/HomeVerification': (context) => HomeVerification(),
        '/home4': (context) => MyApp(indexvalue: 4),
        '/service': (context) => Barpage(),
        '/profile': (context) => SettingsUI(),
        '/Updateprofile': (context) => ProfileUpdates(
            name: "", lastname: "", gender: "", dob: "", phone: "", email: "", address: "")
        // final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

        // return ProfileUpdates(
        //   address: args?['addresss'] ?? "",
        //   dob: args?['dobs'] ?? "",
        //   email: args?['emails'] ?? "",
        //   gender: args?['genders'] ?? "",
        //   lastname: args?['lastnames'] ?? "",
        //   name: args?['names'] ?? "",
        //   phone: args?['phones'] ?? "",
        // );
        ,
        '/MyDogInfo': (context) => MyDogInfo(),
        '/SingleDogRegistrationProcess': (context) => SingleDogRegistrationProcess(
              eventname: '',
              eventstal: "",
              eventtype: "",
              is_participate_with_event: "",
              pariticaipate_for_event: "",
              participate_event_id: "",
              register_for_event: "",
              register_with_event: "",
            ),
        '/addDog': (context) => MyDogInfo(),
        '/litterRegis': (context) => LitterRegistrationHomePage(),
        '/KennelClubName': (context) => KennelClubName(),
        '/INKCStore': (context) => INKCStore(),
        '/Events': (context) => Events(),
        //update profile new 
        '/Firstupdateprofile': (context) => Firstupdateprofile(),
      },
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
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(
                      indexvalue: 0,
                    ))));
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
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
