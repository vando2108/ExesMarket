import '../Network/NetworkHandle.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../MyHomePage.dart';
class AddHistory extends StatefulWidget {
  final data;
  AddHistory({Key key, this.data}) : super(key: key);

  @override
  _AddHistoryState createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistory> {
  int stock = 0 ;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _tele = TextEditingController();
  TextEditingController _body = TextEditingController();
  TextEditingController _stock = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController  _district = TextEditingController();
  //ImagePicker _picker = ImagePicker();
  //PickedFile _imageFile;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
        /*  FlatButton(
            onPressed: () {
              if (_imageFile.path != null &&
                  _globalkey.currentState.validate()) {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => OverlayCard(
                        imagefile: _imageFile,
                        title: _title.text,
                      )),
                );
              }
            },
            child: Text(
              "Preview",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )*/
        ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            addressTextField(),
            bodyTextField(), // message from buyer to user
            stockTextField(),          
            telephoneTextField(),
            districtTextField(),
            SizedBox(height: 20),

            addButton(),
          ],
        ),
      ),
    );
  }

  Widget addressTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _address,
        
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide your address",
         
        ),
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _body,
       
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Type here if you have any message",
        ),
        maxLines: null,
      ),
    );
  }
  
  Widget telephoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _tele,
        validator: (value) {
          if (value.isEmpty) {
            return "Telephone can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide your telephone number",
        ),
        maxLines: null,
      ),
    );
  }
  
  Widget districtTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
                vertical: 10,
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _district,
        validator: (value) {
          if (value.isEmpty) {
            return "Provide district";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide district",
        ),
        maxLines: null,
      ),
    );
  }
   Widget stockTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _stock,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
          } else if (int.parse(value) >  widget.data["stock"] ) {
            return "Invalid stocks.";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Number of items",
         
        ),
        maxLines: null,
      ),
    );
  }
  Widget addButton() {

    return InkWell(
      onTap: () async {
       var now = new DateTime.now();
       if (_globalkey.currentState.validate()) {
          var response = await networkHandler.post("/history/add"
              ,{
                "seller": widget.data["username"],
                "title": widget.data["title"],
                "address": _address.text,
                "telephone": _tele.text,
                "stock": _stock.text,
                "body": _body.text,
                "time": now.toString(),
                "status": "buy",
                "district": _district.text
              } );
          print(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            var response2 = await networkHandler.post(
                "/history/addSellUser", {
                
                "username": widget.data["username"],
                "seller": widget.data["username"],
                "title": widget.data["title"],
                "address": _address.text,
                "telephone": _tele.text,
                "stock": _stock.text,
                "body": _body.text,
                "time": now.toString(),
                "status": "sell",
                "district": _district.text

                });
            print(response2.statusCode);
            if (response2.statusCode == 200 ||
                response2.statusCode == 201) {
                  print("Success add to history");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            }
          }
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Add Blog",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  /*void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }*/
}