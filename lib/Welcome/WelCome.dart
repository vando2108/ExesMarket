import 'package:ExesMarket/Welcome/SignIn.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'SignIn.dart';
import 'package:ExesMarket/Constants.dart';

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
    startTimer();
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
    body:Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
      children: [
        Positioned(
          top: 0,
          child:
         Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/cover.jpg"))
      ),)),
        Positioned(
          top: 500,
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/girlscoutCamp0810.jpg"))))),
      Positioned(
        top: 350,
        left: 100,
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/inline_image_preview.jpg"))))),
          Positioned(
            top: 100,
            left: 0,
        child: Container(
        height: 600,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/images (1).jfif"))))),
          Positioned(
            left: 100,
        child: Container(
        height: 700,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/images (2).jfif"))))),
          Positioned(
            left: 0, 
            top: 800,
        child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/images.jfif"))))),
    
       Stack(
         children:[
       Positioned(
         left: 24,
         top: MediaQuery.of(context).size.height * 0.5,
         child: Text("WELCOME", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.yellow))
       ),
        Positioned(
         left: 20,
         top: MediaQuery.of(context).size.height * 0.5,
         child: Text("WELCOME", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: kPrimaryColor))
       ),
         ]),
         Stack(children: [
 Positioned(
          left: 25,
         top: MediaQuery.of(context).size.height * 0.55,
         child: Text("ExesMarket", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.yellow))
       ),
        Positioned(
          left: 20,
         top: MediaQuery.of(context).size.height * 0.55,
         child: Text("ExesMarket", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: kPrimaryColor))
       )

         ],)
      ],)
    ));
  }
}

