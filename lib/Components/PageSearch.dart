import 'package:flutter/material.dart';
import '../Constants.dart';
import 'ItemChild.dart';
class PageSearch extends StatefulWidget{
  final String query;
  final List data;
  PageSearch({this.query, this.data});
  @override
  _PageSearchState createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  
  @override
  Widget build(BuildContext context){  
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
                Center(child: Text("${widget.query}", style: TextStyle(color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold)),)
              ]
            ),
           ListView.builder(
             shrinkWrap: true,
             primary: false,
             itemCount: widget.data.length,
             itemBuilder :(context, index){
               return ItemChildBig(
                 data: widget.data[index]
               );
             }
           )
      //Result of search query
          ]
        )
      )
    ));
  }
}