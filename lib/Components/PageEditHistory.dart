import 'package:flutter/material.dart';
import '../Network/NetworkHandle.dart';
import 'package:ExesMarket/MyHomePage.dart';

class PageEditHistory extends StatefulWidget {
  final data;
  PageEditHistory({this.data});
  @override
  _PageEditHistoryState createState() => _PageEditHistoryState();
}

class _PageEditHistoryState extends State<PageEditHistory>  {
final _globalkey = GlobalKey<FormState>();
  TextEditingController _stock = TextEditingController();
  TextEditingController _status = TextEditingController();
  TextEditingController _address = TextEditingController();

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
        actions: <Widget>[],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            stockTextField(),
            SizedBox(
              height: 20,
            ),
            statusTextField(),
            SizedBox(
              height: 20,
            ),
            addressTextField(),
            SizedBox(
              height: 20,
            ),
           addButton(),
          ],
        ),
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
            return "Stock can't be empty";
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
          labelText: "New stock",
        ),
        maxLines: null,
      ),
    );
  }

  Widget statusTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _status,
        validator: (value) {
          if (value.isEmpty) {
            return "status";
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
          labelText: "status",
        ),
        maxLines: null,
      ),
    );
  }

  Widget addressTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _address,
        validator: (value) {
          if (value.isEmpty) {
            return "item's address should not be empty";
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
          labelText: "Provide address's material",
        ),
        maxLines: null,
      ),
    );
  }


  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (_globalkey.currentState.validate()) {
          var id = widget.data["_id"];
          var response = await networkHandler.patch("/history/update/" + id.toString(), {
              "stock":  _stock.text,
              "status": _status.text,
              "address": _address.text,
             
          });
          print(response.statusCode);

          if (response.statusCode == 200 || response.statusCode == 201) {
            print("Success update new item");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false);
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
            "Update history",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}