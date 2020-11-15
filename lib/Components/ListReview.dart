import 'package:flutter/material.dart';
import '../Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ItemChild.dart';
import '../Network/NetworkHandle.dart';

class ListReview extends StatefulWidget {
  final List data;
  ListReview({this.data});
  @override
  _ListReviewState createState() => _ListReviewState();
}

class _ListReviewState extends State<ListReview> with TickerProviderStateMixin {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }
  NetworkHandler network  = NetworkHandler();
  TextEditingController textController = TextEditingController();
  TabController _tabController;
  ScrollController _controller;
  ScrollController control;
  FocusNode myFocusNode;
  bool check = false;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _controller = ScrollController();
    _tabController = TabController(initialIndex: 0, vsync: this, length: 3);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                    color: kPrimaryColor,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'VINTAGE CORNER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
                background: Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://laurelleaffarm.com/item-photos/windmill-wheel-quilt-block-table-runner-cloth-antique-vintage-cotton-fabric-patchwork-Laurel-Leaf-Farm-item-no-pw42474-7.jpg')))),
                  Column(
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                      Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => myFocusNode.requestFocus()
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.sortAmountDown),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () {},
                        ),
                        _filter()
                      ],
                    ),
                    ]
                    ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: _search(),
                        
                      ),
                      ])
                ])),
            pinned: true,
            floating: true,
            forceElevated: boxIsScrolled,
          ),
        ];
      },
      controller: _controller,
      body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return ItemChildBig(data: widget.data[index]);
          }),
    ));
  }

  Widget _search(){
    return Container(
            color: Colors.transparent, 
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: textController,
              focusNode: myFocusNode,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                  //fillColor: Colors.grey,
                  focusColor: Colors.grey,
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'What to wear today ?'),
              onChanged: (query) {
                print(query);
                setState((){
                  check = true;
                });

              },
            ),
          
      );
  }

  Widget _result() {
    if (check == true){
      network.post("/blogpost/getOne", {}).then((value) {

      });
    }

  }

  Widget _filter() {
    List choice = ["All","Studying","Stalking", "Dating"];
    String val = "All" ;
    return  DropdownButton<String>(
                    value: val,
                    icon: Icon(FontAwesomeIcons.sortAmountDown, color: Colors.black, size: 25),
                    items: choice.map<DropdownMenuItem<String>>((e){
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e, style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                      );
                    }).toList(),
                    onChanged: (String e) {
                      setState(() {
                        val = e;
                        print(val);
                      });
                    },
                  
                  
                );
  }
}

