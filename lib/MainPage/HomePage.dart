import 'package:ExesMarket/Welcome/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Constants.dart';
import 'package:ExesMarket/Components/Slider.dart';
import '../Components/ListItem.dart';
import 'package:flutter_tags/flutter_tags.dart';
import '../Components/PageSearch.dart';
import '../Network/NetworkHandle.dart';
import 'dart:convert';
import '../Components/SubPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  NetworkHandler network = NetworkHandler();
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.shoppingBag,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.clock,
  ];

  List<String> _items = [
    "male",
    "female",
    "unisex"
  ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? kColor : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index ? kPrimaryColor : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  Future future_1;
  Future future_2;
  Future future_4;
  bool isOn = false;
  
  @override
  void initState() {
    future_1 = network.post("/blogpost/getSomeFun", {"hastag": "Vintage"});
    future_2 = network.post("/blogpost/getSomeFun", {"hastag": "Interview"});
    future_4 = network.post("/blogpost/getSomeFun", {"hastag": "Dating"});
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _justList = [
      _page1(),
      _page1(),
      _page1(),
    ];
    return Scaffold(
      drawer: Drawer(
          
          child:Column(
         children: [
           Padding(
             padding: EdgeInsets.all(15),
             child: Text("Buy history"),
           
           ),
           Padding(child: Text("Sell history"),
           padding: EdgeInsets.all(15.0)
           )
         ],
        ),),
        body: SingleChildScrollView(
            child: Column(children: [
      Stack(
        children: [
          Padding(
        padding: EdgeInsets.only(left: 20.0, right: 120.0, top: 20.0),
        child: Text(
          'What would you like to find?',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Positioned(
        top: 20,
        right: 20,
        child: IconButton(
        
        icon: Icon(Icons.local_cafe, color: kPrimaryColor),
        onPressed: (){
           Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                  (route) => false);
            }
        ,
      )
      ),
     ]),
      SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _icons
            .asMap()
            .entries
            .map(
              (MapEntry map) => _buildIcon(map.key),
            )
            .toList(),
      ),
      SizedBox(height: 15),
      CarouselWithIndicatorDemo(),
      _trendingTag(),
      _justList[_selectedIndex]
    ])));
  }

  Widget _page1() {
    return Column(children: [
      CategoryScroller(topic: "Vintage", future: future_1),
      CategoryScroller(topic: "Interview", future: future_2),
      CategoryScroller(topic: "Dating", future: future_4),
    

    ]);
  }

//item people are noticing
  Widget _trendingTag() {
    return Container(
        child: Tags(
      key: _tagStateKey,

      itemCount: _items.length, // required
      itemBuilder: (int index) {
        final item = _items[index];

        return ItemTags(
            key: Key(index.toString()),
            index: index, // required
            title: item,
            active: false,
            activeColor: Colors.white,
            textActiveColor: Colors.black,
            //customData: item.customData,
            textStyle: TextStyle(
              fontSize: 15,
            ),
            combine: ItemTagsCombine.withTextBefore,
            image: ItemTagsImage(image: AssetImage("assets/images/img.png")),
            onPressed: (item) {
              print(item);
              network.post('/blogpost/getSomeFunny', {"sex": item.title}).then(
                  (value) {
                var data = json.decode(value.body);
                data = data['data'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PageSearch(query: item.title, data: data)));
              });

              //Navigate to a new subpage to search items, query is item. displaying result
            });
      },
    ));
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  _getAllItem() {
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if (lst != null)
      lst.where((a) => a.active == true).forEach((a) => print(a.title));
  }
}
