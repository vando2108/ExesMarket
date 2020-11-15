import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ExesMarket/Constants.dart';
final List<Article> imgList = [
  Article(
      thumb:
          'https://scontent.fsgn1-1.fna.fbcdn.net/v/t1.0-9/122359451_10208762950907440_1966410902730822508_o.jpg?_nc_cat=101&ccb=2&_nc_sid=8bfeb9&_nc_ohc=4tBFr1pdTzIAX9GdCvd&_nc_ht=scontent.fsgn1-1.fna&oh=a2a8767525431ad42090d87e492f9c55&oe=5FD56568',
      title: 'Xu hướng thời trang 2020 cho giới trẻ'),
  Article(
      thumb:
          'https://scontent.fsgn1-1.fna.fbcdn.net/v/t1.0-9/81034592_10207527239895437_7645434256696541184_o.jpg?_nc_cat=107&ccb=2&_nc_sid=8bfeb9&_nc_ohc=Ulls_LZG0tEAX8LPPUH&_nc_ht=scontent.fsgn1-1.fna&oh=7fc5cb70f68f015a362af5b74cdc2bdb&oe=5FD4A182',
      title:
          'Xu hướng mặc đồ theo phong cách thời trang vintage là gì .'),
  Article(
      thumb:
          'https://thietkenoithattaynguyen.com/upload/retro-2.jpg',
      title: 'Retro phong cách thiết kế nội thất - xu hướng của giới trẻ'),
  Article(
      thumb: 'https://znews-photo.zadn.vn/w1024/Uploaded/rohunwa/2020_06_08/CHI_PU_4.jpg',
      title:
          'Vì sao Chi Pu và giới trẻ Việt chuộng phong cách từ thời cha mẹ?'),
  Article(
      thumb:
          'https://anv.vn/wp-content/uploads/2020/10/phong-cach-retro.jpg',
      title:
          'Phong Cách Retro Và Sự Hoài Niệm Trong Cuộc Sống Hiện Đại'),
];

final List<Widget> imageSliders = imgList
    .map((item) => GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
            Container(
              width: 1000.0,
              height: 500.0,
              margin: EdgeInsets.only(left: 10.0, bottom: 15.0),
              decoration: BoxDecoration(
                color: kColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),

              )
            ),
            Container(
            height : 500.0,
            width: 1000.0, 
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item.thumb, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          '${item.title}',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
            ])))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? kPrimaryColor
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

class Article {
  String thumb;
  String title;

  Article({this.thumb, this.title});
}
