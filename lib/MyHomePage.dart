import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import './MainPage/HomePage.dart';
import './MainPage/PersonalPage.dart';
import 'Constants.dart';
import 'MainPage/Map.dart';
class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    var _page = [
      HomePage(),
      PersonalPage(),
      Location()
    ];
    return SafeArea(
      child: Scaffold(
        
      body: 
        SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              _page[0],
              _page[1],
              _page[2]
            ],
          ),
        ),

       bottomNavigationBar: BottomNavyBar(
         showElevation: true,
         containerHeight: 50,
        iconSize: 30,
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            _currentIndex,
            duration: Duration(
              milliseconds: 200,
            ),
            curve: Curves.easeIn,
          );
        }, // new
        selectedIndex: _currentIndex,
        items: [
          BottomNavyBarItem(
            icon: new Icon(Icons.dashboard),
            title: new Text('Home'),
            activeColor: kPrimaryColor,
            inactiveColor: Colors.blueGrey[200],
            textAlign: TextAlign.center,
          ),
          
          BottomNavyBarItem(
            icon: new Icon(Icons.person_outline),
            title: new Text('Wall'),
            activeColor: kPrimaryColor,
            inactiveColor: Colors.blueGrey[200],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: new Icon(Icons.map),
            title: new Text('Map'),
            activeColor: kPrimaryColor,
            inactiveColor: Colors.blueGrey[200],
            textAlign: TextAlign.center,
          ),
        ] )
    ) );
  }
}