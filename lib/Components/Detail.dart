import 'package:ExesMarket/Components/addItem.dart';
import 'package:ExesMarket/MainPage/PersonalPage.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'WallUser.dart';
import '../Network/NetworkHandle.dart';
import 'dart:convert';
import 'addItem.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        Column(
          children: <Widget>[
            ImageAndIcons(size: size, image: widget.val['image']),
            _titleAndprice(),
            SizedBox(height: kDefaultPadding),
            Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddBlog(data: widget.val )));
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.2,
                          vertical: size.height * 0.05),
                      width: size.width / 2,
                      child: Text(
                        "Buy",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.05),
                      width: size.width / 2,
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 20, color: kPrimaryColor),
                      ),
                    ))
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ]),
    ));
  }

  Widget _titleAndprice() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        width: 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (true) {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PersonalPage()));
                }
                network.post("/profile/getOne",
                    {"username": widget.val["username"]}).then((value) {
                  if (value.statusCode == 200) {
                    print("OK");
                    network.post("/blogpost/getOne",
                        {"username": widget.val["username"]}).then((val) {
                      if (val.statusCode == 200) {
                        print("Fetch ok with blogpost of username");
                        var info = json.decode(value.body)["data"];
                        var items = json.decode(val.body)["data"];
                        print(info);
                        print(items);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WallUser(info: info, items: items)));
                      }
                    });
                  } else {
                    print(widget.val);
                  }
                });
              },
              child: Text(widget.val["username"],
                  style: TextStyle(color: kPrimaryColor, fontSize: 15)),
            ),
            Text(widget.val["title"],
                style: TextStyle(color: kPrimaryColor, fontSize: 30)),
            SizedBox(height: 10),
            Text("'${widget.val["body"]}'",
                style: TextStyle(color: kPrimaryColor, fontSize: 15)),
            SizedBox(height: 10),
            Text("Color: ${widget.val["color"]}",
                style: TextStyle(color: kPrimaryColor, fontSize: 20)),
            SizedBox(height: 10),
            Text("Material: ${widget.val["material"]}",
                style: TextStyle(color: Colors.black, fontSize: 20))
          ],
        ));
  }
}

class ImageAndIcons extends StatefulWidget {
  ImageAndIcons({Key key, @required this.size, this.image}) : super(key: key);

  final Size size;
  final List image;
  @override
  _ImageAndIconsState createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
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
              height: widget.size.height * 0.6,
              width: widget.size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(63),
                  bottomLeft: Radius.circular(63),
                  topRight: Radius.circular(63),
                  bottomRight: Radius.circular(63),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 60,
                    color: kPrimaryColor.withOpacity(0.29),
                  ),
                ],
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image[index].toString()),
                ),
              ),
            ),
          )
        ]));
  }
}

class IconCard extends StatelessWidget {
  const IconCard({
    Key key,
    this.icon,
  }) : super(key: key);

  final String icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: EdgeInsets.all(kDefaultPadding / 2),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 22,
            color: kPrimaryColor.withOpacity(0.22),
          ),
          BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 20,
            color: Colors.white,
          ),
        ],
      ),
      child: SvgPicture.asset(icon),
    );
  }
}
