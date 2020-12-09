import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../Detail/Detail.dart';
import '../../Network/NetworkHandle.dart';
import 'dart:convert';
import 'ItemScroll.dart';

class WallUser extends StatefulWidget {
  final username; // profile
  WallUser({this.username});
  @override
  _WallUserState createState() => _WallUserState();
}

class _WallUserState extends State<WallUser>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  ScrollController _controller;
  NetworkHandler network = NetworkHandler();
  Future futureinfo;
  Future futureitems;

  @override
  void initState() {
    super.initState();
    futureinfo =
        network.post("/profile/getOne", {"username": widget.username});
    futureitems =
        network.post("/blogpost/getOne", {"username": widget.username});
    _controller = ScrollController();
    _tabController = TabController(initialIndex: 0, vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(children: [
          DefaultTabController(
              length: 2,
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
                                   color: kPrimaryColor
                                   )),
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
                                child: Icon(Icons.apps)),
                                     Tab(
                                child: Icon(Icons.article_outlined)),
                          ],
                        ),
                      ),
                    )
                  ];
                },
                controller: _controller,
                body:TabBarView(controller: _tabController, children: [
                   _gridview(),
                  _listview()            
                  
                ])
                
              )),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            IconButton(
              icon: Icon(Icons.menu),
              iconSize: 25.0,
              color: Colors.black,
              onPressed: () {},
            ),
          ])
        ]));
  }

  Widget _gridview() {
    return FutureBuilder(
        future: futureitems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = json.decode(snapshot.data.body)["data"];
            return GridView.builder(
                // primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                itemCount: items.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  String image = items[index]["image"][0].toString();
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(val: items[index])));
                      },
                      child: Stack(children: [
                        Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(image)))),
                        (items[index]["image"].length > 1)
                            ? Icon(Icons.amp_stories)
                            : Container()
                      ]));
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator()
            )
          );
        });
  }

  Widget _listview() {
    return FutureBuilder(
        future: futureitems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var items = json.decode(snapshot.data.body)["data"];
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ItemScroll(data: item);
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator()
            )
          );
        });
  }

  Widget _info() {
    return FutureBuilder(
        future: futureinfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var info = json.decode(snapshot.data.body)["data"];
            return Container(
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
                  info[0]["name"],
                  maxLines: 5,
                ),
              ]),
              decoration: BoxDecoration(color: Colors.white),
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
    return new  Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                   borderRadius: BorderRadius.only(topRight:  Radius.circular(40), topLeft: Radius.circular(20)),
                  ),
                  child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
