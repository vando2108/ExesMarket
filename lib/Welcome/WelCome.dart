import 'package:ExesMarket/Welcome/SignIn.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'SignIn.dart';

class SplashScreen extends StatefulWidget {
@override
 _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  int _start = 4;

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
               Navigator.push(context, MaterialPageRoute(
            builder: (context) => SignInPage()));
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }
  @override
  void initState(){
   // startTimer();
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
    body:SingleChildScrollView(
      child: Stack(
      children: [
         Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/cover.jpg"))
      ),),
        Positioned(
          top: 500,
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/girlscoutCamp0810.jpg"))))),
      Positioned(
        top: 500,
        left: 100,
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/inline_image_preview.jpg"))))),
          Positioned(
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/images (1).jfif"))))),
          Positioned(
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/images (2).jfif"))))),
          Positioned(
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/images.jfif"))))),
    
    
      ],)
    ));
  }
}

