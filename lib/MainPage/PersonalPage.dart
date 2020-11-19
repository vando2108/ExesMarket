import 'package:flutter/material.dart';
import '../Constants.dart';
import '../Components/Detail.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Network/NetworkHandle.dart';
import 'dart:convert';
import '../Components/CreateNew.dart';
import '../Components/UpdateItem.dart';
import '../Components/SubPage.dart';
import '../Components/CreateProfile.dart';
class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

      
  @override
  bool get wantKeepAlive => true;
  
  TabController _tabController;
  ScrollController _controller;
  NetworkHandler network = NetworkHandler();
  Future future;
  Future future1;
  @override
  void initState() {
    super.initState();
    future = network.get("/profile/getData");
    future1 = network.get("/blogpost/getOwnBlog");
    _controller = ScrollController();
    _tabController = TabController(initialIndex: 0, vsync: this, length: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          
          child:Column(
         children: [
           GestureDetector(
             onTap: (){
               
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SubPage(query: "buy" )));
              
             },
            child:  Container(
              width: 200,
              color: kPrimaryColor,
             padding: EdgeInsets.all(10),
             margin: EdgeInsets.symmetric(vertical: 10),
             child: Text("Buy history", style: TextStyle(color: Colors.white, fontSize: 25)),  
           )
           )
          ,
          GestureDetector(
            child:  Container(
               width: 200,
              color: kPrimaryColor,
              child: Text("Sell history", style: TextStyle(color: Colors.white, fontSize: 25)),
           padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.symmetric(vertical: 10),

           ),
           onTap: (){
 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SubPage(query: "sell" )));
           }

          )
         ],
        ),),
        floatingActionButton: SpeedDial(
            tooltip: 'Menu',
            marginRight: 20,
            marginBottom: 50,
            animatedIcon: AnimatedIcons.menu_close,
            foregroundColor: kPrimaryColor,
            backgroundColor: Colors.white,
            animatedIconTheme: IconThemeData(color: kPrimaryColor),
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            heroTag: 'speed-dial-hero-tag',
            children: [
              SpeedDialChild(
                  child: Icon(
                    Icons.mic,
                  ),
                  backgroundColor: kPrimaryColor,
                  label: "UP",
                  onTap: () {
                   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddItem())); 
                  }),
              
              SpeedDialChild(
                child: Icon(Icons.book),
                backgroundColor: kPrimaryColor,
                label: "CREATE PROFILE",
                onTap: () {
                   Navigator.push( context,MaterialPageRoute(
                                builder: (context) =>
                                    AddProfile()));
                },
              ),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(children: [
          DefaultTabController(
              length: 1,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool boxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 300.0,
                      automaticallyImplyLeading: false,
                      backgroundColor: kColor,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                         
                          background: Stack(children: [
                            Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://media.gq.com/photos/5e0514dc58165e000877d842/64:25/w_1984,h_775,c_limit/2020trends.jpg')))),
                            _info()
                          ])),
                      pinned: true,
                      floating: true,
                      forceElevated: boxIsScrolled,
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          indicatorColor: kPrimaryColor,
                          controller: _tabController,
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                                child: Text("Your merches",
                                    style: TextStyle(color: Colors.black))),
                         
                          ],
                        ),
                      ),
                    )
                  ];
                },
                controller: _controller,
                body: TabBarView(controller: _tabController, children: [
                  _gridview(),
                 
                ]),
              )),
        
          
        ]));
  }
  Widget _gridview(){
    return FutureBuilder(
    future: future1 ,
    builder: (context, snapshot){
      if (snapshot.hasData){
        var data = snapshot.data["data"];
        return GridView.builder(
        // primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          String image = data[index]["image"][0].toString();
          return GestureDetector(
            onLongPress: (){
              network.delete("/blogpost/delete/" + data[index]["_id"].toString()).then((value){
                if (value.statusCode == 200) {
                  print("Delete success !");
                }
                else throw Exception("Problem with deleting");
              });
            },
            onDoubleTap: (){
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateItem(val: data[index])));
            },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(val: data[index])));
              },
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        image:(image.contains("http")) ? DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(image)) : null)),
                (data[index]["image"].length > 1)
                    ? Icon(Icons.airline_seat_flat)
                    : Container()
              ]));
        });
      } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
      return CircularProgressIndicator();
    }
    );
  }
  Widget _info() {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mine = snapshot.data["data"];
            print(mine);
            return (mine.length > 0) ? Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 27.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            "https://media.foody.vn/res/g76/754195/prof/s/foody-upload-api-foody-mobile-thecoffeehouse-jpg-180627140337.jpg"),
                      ),
                  
                    ]),
                SizedBox(height: 15),
                //bio
                Text(
                  mine["name"],
                  maxLines: 5,
                ),
                
              ]),
              decoration: BoxDecoration(color: Colors.white),
            ) : Container(margin: EdgeInsets.symmetric(vertical: 50, horizontal : 100),
            child: Text("Data profile has not been added", style: TextStyle(

              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 40
            ))
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
