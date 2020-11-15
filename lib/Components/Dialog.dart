import 'package:flutter/material.dart';

class DialogCard extends StatefulWidget {
  
  @override
  _DialogCardState createState() => _DialogCardState();
}

class _DialogCardState extends State<DialogCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Are you sure ?"),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("cancel")),
        FlatButton(
            onPressed: () {
              
            },
            child: Text("delete"))
      ],
    );
  }
}