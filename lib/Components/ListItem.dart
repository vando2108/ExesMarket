import 'package:flutter/material.dart';
import '../Constants.dart';
import 'ListReview.dart';
import 'WallUser.dart';
import 'dart:convert';
import 'Detail.dart';

class CategoryScroller extends StatelessWidget {
  final String topic;
  final Future future;
  CategoryScroller({this.topic, this.future});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              future: future,
              builder : (context, snapshot){
                if (snapshot.hasData){
                  var mine = json.decode(snapshot.data.body)["data"];
                  return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              children: [
                Text("$topic", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                GestureDetector(
                  onTap : (){
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListReview(data: mine)));
                  },
                  child: Text("More", style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold
                  ))
                )
              ],
            )
          ),
      
        Container(
                       height: MediaQuery.of(context).size.height * 0.27,

            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:  ListView.builder(
                    scrollDirection: Axis.horizontal,                 
                    itemCount: (mine.length > 3 ) ? 3 : mine.length,
                    itemBuilder: (context, index){
                      final val = mine[index];
                      return ItemChild(val: val);
                    }
                  ))]);
                } else if (snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
            ) ;           
  }
}

class ItemChild extends StatelessWidget{
  final val;
  ItemChild({this.val});
  @override
  Widget build(BuildContext context){
    return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 150,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: kPrimaryColor,
                                image: val["image"][0].toString()
                                        .contains("http")
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                           val["image"][0].toString()))
                                    : null),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                  "${val["title"]}",
                                  maxLines: 2,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600))),
                          Container(
                              margin: EdgeInsets.only(top: 3, bottom: 7),
                              child: Text(
                                  "${val["body"]}",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.grey[500]))),
                           Container(
                              margin: EdgeInsets.only(top: 3, bottom: 10),
                              child: Text(
                                  "${val["username"]}",
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.grey[500]))),
                          GestureDetector(
                              onTap: () {
                                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(val: val)));
                              },
                              child: Container(
                                  width: 105,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 32),
                                  child: Text("Detail",
                                      style: TextStyle(color:kPrimaryColor)),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      border:
                                          Border.all(color:kPrimaryColor))))
                        ]));
  }
}