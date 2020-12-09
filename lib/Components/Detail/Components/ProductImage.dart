import 'package:flutter/material.dart';
import '../../../Constants.dart';

class ProductImage extends StatefulWidget {
  ProductImage({Key key, this.image}) : super(key: key);

  final List image;
  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(children: [
          SizedBox(height: 20),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                setState(() {
                  if (index < widget.image.length - 1) index++;
                });
              } else if (details.delta.dx < 0) {
                setState(() {
                  if (index > 0) index--;
                });
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 10),
                    blurRadius: 0,  
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ],
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image[index].toString()),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 20),
            child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemCount: widget.image.length,
            itemBuilder: (context, idx){

              return Container(
                decoration: BoxDecoration(
                  border: (idx == index)? Border.all(color: kPrimaryColor) : Border.all(color: Colors.white),
                ),
                padding: EdgeInsets.all(3.0),
                child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.image[idx].toString()),
                  )
                )
              )
              )  ;
            } )
          )
        ]));
  }
}