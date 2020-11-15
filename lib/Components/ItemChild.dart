import 'package:ExesMarket/Components/Detail.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'WallUser.dart';

class ItemChildBig extends StatelessWidget {
  final data;
  ItemChildBig({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        padding: EdgeInsets.symmetric(vertical:10),
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            //height: MediaQuery.of(context).size.height * 0.25,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kPrimaryColor,
                image: data["image"][0]
                        .contains("http")
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            data["image"][0]))
                    : null),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              width: 150,
                child: Text("${data["title"]}",
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600))),
            Container(
              width: 100,
                margin: EdgeInsets.only(top: 3, bottom: 7),
                child: Text(
                    "${data["body"]}",
                    maxLines: 3,
                    style: TextStyle(color: Colors.grey[500]))),
                     Container(
              width: 100,
                margin: EdgeInsets.only(top: 3, bottom: 7),
                child: Text(
                    "${data["username"]}",
                    maxLines: 3,
                    style: TextStyle(color: Colors.grey[500]))),
            GestureDetector(
                onTap: () {

                   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(val: data)));
                },
                child: Container(
                    width: 105,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 32),
                    child:
                        Text("Detail", style: TextStyle(color: kPrimaryColor)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: kPrimaryColor))))
          ])
        ]));
  }
}