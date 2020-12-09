import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../../Network/NetworkHandle.dart';
import 'Components/ProductImage.dart';
import 'Components/ProductDescription.dart';
import 'Components/BuyButton.dart';

class DetailsScreen extends StatefulWidget {
  final val;
  DetailsScreen({this.val});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  NetworkHandler network = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        Column(
          children: [
            ProductImage(image: widget.val['image']),
            ProductDescription(product: widget.val),
            BuyButton(data : widget.val)
          ]
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ]),
    ));
  }
}



