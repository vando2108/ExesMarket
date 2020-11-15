import 'package:flutter/material.dart';
import '../Constants.dart';
import '../Components/Detail.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Network/NetworkHandle.dart';

class WallUser extends StatefulWidget {
  final info;
  final items;
  WallUser({this.info, this.items});
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
  @override
  void initState() {
    super.initState();

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
                                            'https://ductan.me/wp-content/uploads/2018/11/2018-03-16-09.05.jpg')))),
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
  Widget _gridview(){
    return GridView.builder(
        // primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        itemCount: widget.items.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          String image = widget.items[index]["image"][0].toString();
          return GestureDetector(
              onTap: () {
                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(val: widget.items[index])));
              },
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(image)))),
                (widget.items[index]["image"].length > 1)
                    ? Icon(Icons.airline_seat_flat)
                    : Container()
              ]));
        });
      
  }
  Widget _info() {
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
                  widget.info[0]["name"],
                  maxLines: 5,
                ),
                
              ]),
              decoration: BoxDecoration(color: Colors.white),
            );
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
