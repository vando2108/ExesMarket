import 'package:ExesMarket/Constants.dart';
import 'package:ExesMarket/Network/NetworkHandle.dart';
import 'package:flutter/material.dart';
import '../Network/NetworkHandle.dart';
import 'dart:convert';
import 'Dialog.dart';
import 'PageEditHistory.dart';

class SubPage extends StatefulWidget {
  final String query;
  SubPage({this.query});
  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future future;
  NetworkHandler network = NetworkHandler();
  @override
  void initState() {
    super.initState();
    future = network.post("/history/getAllBuy", {"status": widget.query});
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var mine = json.decode(snapshot.data.body)["data"];

                return ListView.builder(
                    itemCount: mine.length,
                    itemBuilder: (context, index) {
                      return ItemChild(child: mine[index]);
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }),
        Positioned(
          top: 20,
          left: 20,
          child: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
      ],
    ));
  }
}

class ItemChild extends StatelessWidget {
  final child;
  ItemChild({this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text("SELLER : ",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text("${child["seller"]}",
                    maxLines: 2, style: TextStyle(fontSize: 17)),
              ]),
              Row(children: [
                Text("BUYER : ",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text("${child["buyer"]}",
                    maxLines: 2, style: TextStyle(fontSize: 17)),
              ]),
              Row(
                children: [
                  Text("PRODUCT : ",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text("${child["title"]}",
                      maxLines: 2, style: TextStyle(fontSize: 17)),
                ],
              ),
              Row(children: [
                Text("STOCK : ",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
                Text("${child["stock"]}",
                    maxLines: 2, style: TextStyle(fontSize: 17)),
              ]),
              Row(children: [
                Text("ADDRESS : ",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
                Text("${child["address"]}",
                    maxLines: 2, style: TextStyle(fontSize: 17)),
              ]),
              Row(
                children: [
                  Text("DISTRICT : ",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text("${child["district"]}",
                      maxLines: 2, style: TextStyle(fontSize: 17)),
                ],
              ),
              Row(
                children: [
                  Text("TIME : ",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text("${child["time"]}",
                      maxLines: 2, style: TextStyle(fontSize: 17)),
                ],
              ),
              (child["sellled"] == false)
                  ? Text("THE TRADE IS STILL",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold))
                  : Text("THE TRADE IS ENDED",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text("STATUS : ",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text("${child["status"]}",
                      maxLines: 2, style: TextStyle(fontSize: 17)),
                ],
              ),
              Row(
                children: [
                  Text("MESSAGE FROM BUYER : ",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text("${child["body"]}", style: TextStyle(fontSize: 17)),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PageEditHistory(data: child)));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: Icon(Icons.directions, color: Colors.white),
                      decoration: BoxDecoration(
                        color: kPrimaryColor, 
                        
                      )
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      AlertDialog(
                        title: Text("Are you sure ?"),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("cancel")),
                          FlatButton(onPressed: () {}, child: Text("delete"))
                        ],
                      );
                    },
                    child: Container(
                                            margin: EdgeInsets.only(right: 20, top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Icon(Icons.delete, color: Colors.white),
                      decoration: BoxDecoration(
                        color: Colors.red,

                      ),
                    ),
                    
                  )
                ],
              )
            ])),
      ],
    );
  }
}
