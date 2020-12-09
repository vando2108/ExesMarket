import 'package:flutter/material.dart';
import '../../../Constants.dart';
import '../../AddHistory.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    Key key,
    @required this.data,
  }) : super(key: key);

   final data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
      width: MediaQuery.of(context).size.width* 0.8,
      child: Text("Buy", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 120),
      margin: EdgeInsets.only(bottom: 20, top: 15),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    ),
    onTap: (){
      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddHistory(data: data )));

    }
    );
  }
}