import 'package:flutter/material.dart';
import '../../Constants.dart';

class ItemScroll extends StatelessWidget {
  final data;
  ItemScroll({this.data});
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size ;
    return Container(
      width: size.width * 0.85,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        children:[
          Container(
            height : size.width * 0.85 * 0.5,
            width: size.width * 0.4,
            decoration: BoxDecoration(
              image: (data["image"][0].contains("http")) ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data["image"][0].toString())
              )
             : Container(color: kPrimaryColor)
          )),
          Container(
            width: size.width * 0.85 * 0.5,
            margin: EdgeInsets.only(left: 20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data["title"]}", maxLines: 3, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 25.0),),
              Container(
                child : Text("${data["address"]}", maxLines: 3),
              ),
              Text("${data["price"]} VND", style: TextStyle(fontSize: 20)),
            ],
          )
          ),
          
        ]
      )
    );
  }
}