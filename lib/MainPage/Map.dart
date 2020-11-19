import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import '../Network/NetworkHandle.dart';
import 'dart:convert';
import '../Constants.dart';
import '../Components/ItemChild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>
    with AutomaticKeepAliveClientMixin {
  NetworkPlace net = NetworkPlace();
  NetworkHandler network = NetworkHandler();
  TextEditingController textcontrol = TextEditingController(text: " ");
  TextEditingController distanceControl = TextEditingController();
  var lat = 10.767207, lng = 106.694078;
  var listOfResult = [];
  String val = "District 1";
  bool loading = false;
  bool check = false;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Marker> markers = [
    Marker(
      width: 20.0,
      height: 20.0,
      point: LatLng(10.767207, 106.694078),
      builder: (ctx) => Container(
        child: FlutterLogo(
          key: ObjectKey(Colors.blue),
        ),
      ),
    ),
    Marker(
      width: 20.0,
      height: 20.0,
      point: LatLng(10.767539, 106.694119),
      builder: (ctx) => Container(
        child: FlutterLogo(
          key: ObjectKey(Colors.green),
        ),
      ),
    ),
    Marker(
      width: 20.0,
      height: 20.0,
      point: LatLng(10.768191, 106.695126),
      builder: (ctx) => Container(
        child: FlutterLogo(
          key: ObjectKey(Colors.purple),
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      FlutterMap(
        options: MapOptions(
          center: LatLng(lat, lng),
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            tileProvider: NonCachingNetworkTileProvider(),
          ),
          new MarkerLayerOptions(
            markers: markers,
          ),
        ],
      ),
      _search()
    ]));
  }

  Widget _search() {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: textcontrol,
          autofocus: true,
          style: TextStyle(color: kPrimaryColor),
          decoration: InputDecoration(
              icon: Icon(Icons.search),
              focusColor: Colors.grey,
              border: OutlineInputBorder(),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'What do you want to eat?'),
          onChanged: (query) {
            /*setState(() {
              check = true;
            });*/
            print(query);
            net.post({"image_name": textcontrol.text}).then((value) {
              if (value.statusCode == 200) {
                print("Ok");

                var res = json.decode(value.body);
                if (res != null) {
                  setState(() {
                    lat = res["lat"];
                    lng = res["lng"];
                  });
                }
              } else {
                print("No result return !");
                return;
              }
            });
          },
        ),
      ),
          Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: distanceControl,
          style: TextStyle(color: kPrimaryColor),
          decoration: InputDecoration(
              icon: Icon(Icons.search),
              focusColor: Colors.grey,
              border: OutlineInputBorder(),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'How far you want to go?'),
          onChanged: (query) {},
        ),
      ),
      _filter(),
      
      GestureDetector(
        child: Container(
          color: kPrimaryColor,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Text("Search", style: TextStyle(color: Colors.white)),
        ),
        onTap: () {
          setState(() {
            loading = true;
            
          });

          network.post("/blogpost/getSome/Distance", {
            "distance": double.parse(distanceControl.text),
            "lat": lat,
            "lng": lng,
            "district": val
          }).then((value) {
            if (value.statusCode == 200) {
              print("Good fetch");
              print(value.body);
              setState(() {
                listOfResult = json.decode(value.body)["data"];
              });
            } else {
              print("Bad request. Try again");
            }
          });
          
          markers.add(
            Marker(
              width: 20.0,
              height: 20.0,
              point: LatLng(lat, lng),
              builder: (ctx) => Container(
                child: FlutterLogo(
                  key: ObjectKey(Colors.purple),
                ),
              ),
            ),
          );
          setState(() {
            loading = false;
            check = true;
          });
        },
      ),
      _result()
    ]));
  }
  
  Widget _result() {
    if (check == false && loading == false) return Text("Choose your location");
    else if (check == true && loading == false && listOfResult.length == 0) return Text("No destinations found");

    else if (loading == false && check == true)return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: listOfResult.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(3.0),
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                  child: Text("${listOfResult[index]["address"]}")

                );
              },
            );
    return CircularProgressIndicator();
  }
  Widget _filter() {
    List choice = [
      "District 1",
      "District 2",
      "District 3",
      "District 4",
      "District 5",
      "District 6",
      "District 7",
      "District 8",
      "District 9",
      "District 10",
      "District 11",
      "District 12",
      "Thu Duc",
      "Binh Thanh",
      "Binh Tan",
      "Tan Binh",
      "Go Vap","Phu Nhuan","Tan Phu", "Binh Chanh", "Can Gio", "Cu Chi","Hoc Mon", "Nha Be"

    ];
    return DropdownButton<String>(
      value: val,
      icon:
          Icon(FontAwesomeIcons.sortAmountDown, color: Colors.black, size: 25),
      items: choice.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(
            e,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      onChanged: (String e) {
        setState(() {
          val = e;
          print(val);
        });
      },
    );
  }
}
