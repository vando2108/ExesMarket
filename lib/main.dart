import 'package:ExesMarket/Welcome/WelCome.dart';
import 'package:flutter/material.dart';
import 'package:ExesMarket/Welcome/SignIn.dart';
import 'MyHomePage.dart';
import 'Welcome/WelCome.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen() // MyHomePage(),
    );
  }
}