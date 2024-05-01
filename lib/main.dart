
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ridesharingapp/HomeScreen/findaRide.dart';
import 'package:ridesharingapp/HomeScreen/homeScreen.dart';
import 'package:ridesharingapp/Profile/profile.dart';
import 'package:ridesharingapp/auth/otpHome.dart';
import 'package:ridesharingapp/auth/otpPage.dart';
import 'package:ridesharingapp/auth/registerUser.dart';
import 'package:ridesharingapp/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userName = await prefs.getString("userName");
  runApp(MyApp(screen: (userName==null) ? OtpHome() : HomeScreen()));
}


class MyApp extends StatelessWidget {
  final Widget? screen;
  MyApp({this.screen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share MyRide',
      //test phase
      home: screen,
      routes: {
        '/otphome' : (context) => OtpHome(),
        '/otppage' : (context) => OtpPage(),
        '/homescreen' : (context) => HomeScreen(),
        '/register'   : (context) => SignUp(),
        '/profile'    : (context) => ProfilePage(),
        '/findaride' : (context) => FindaRide(),
      },
    );
  }
}
