import 'package:ExesMarket/Constants.dart';

import '../Network/NetworkHandle.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../MyHomePage.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddItem extends StatefulWidget {
  AddItem({Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  int stock = 0;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  TextEditingController _material = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _stock = TextEditingController();
  TextEditingController _hastag = TextEditingController();
  TextEditingController _price = TextEditingController();
  //ImagePicker _picker = ImagePicker();
  //PickedFile _imageFile;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();

  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  ColorSwatch _mainColor = Colors.blue;
  List sex = ["male", "female", "unisex"];
  List color = [Colors.redAccent, Colors.redAccent,Colors.redAccent];

   List size = ["S", "M", "L", "XL", "XXL" ];
  List colorSize = [Colors.redAccent, Colors.redAccent,Colors.redAccent,Colors.redAccent,Colors.redAccent];
  String _sex;
  String _size;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _mainColor = _tempMainColor;
                }
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: _mainColor,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

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
            titleTextField(),
            SizedBox(
              height: 20,
            ),
            bodyTextField(),
            SizedBox(
              height: 20,
            ),
            materialTextField(),
            SizedBox(
              height: 20,
            ),
            imageTextField(),
            SizedBox(
              height: 20,
            ),
            stockTextField(),
            SizedBox(
              height: 20,
            ),
            hastagTextField(),
            SizedBox(
              height: 20,
            ),
            priceTextField(),
            SizedBox(
              height: 20,
            ),
            choiceGender(),
            choiceSize(),
           Row(
             children: [
               Container(
                 margin: EdgeInsets.only(left: 30),

                 width:30 , height:30, color: _tempMainColor),
                 SizedBox(width: 30),
                OutlineButton(
              onPressed: _openFullMaterialColorPicker,
              child: const Text('Show full material color picker'),
            ),
             ],
           ),
            SizedBox(height: 20),
            addButton(),
          ],
        ),
      ),
    );
  }
  
  Widget choiceGender(){
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: sex.length,
        itemBuilder: (context, index){
          return Padding(padding: EdgeInsets.all(15),
          
          child:  Column(
        children: [
      GestureDetector(
        child: Container(height: 15, width: 15, color: color[index],),
        onTap: (){
          setState((){
            for (var i = 0; i < 3;++i) color[i] = Colors.redAccent;
            color[index] = kPrimaryColor;

            _sex = sex[index];

          });
        }
      ),
      Text("${sex[index]}")

    ],)
    );} ));
  }

  Widget choiceSize(){
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: size.length,
        itemBuilder: (context, index){
          return Padding(padding: EdgeInsets.all(15),
          
          child:  Column(
        children: [
      GestureDetector(
        child: Container(height: 15, width: 15, color: colorSize[index],),
        onTap: (){
          setState((){
            for (var i = 0; i < 5;++i) colorSize[i] = Colors.redAccent;
            colorSize[index] = kPrimaryColor;

            _size = size[index];

          });
        }
      ),
      Text("${size[index]}")

    ],)
    );} ));
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _title,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
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
        validator: (value) {
          if (value.isEmpty) {
            return "Type here if you have any messages";
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
          labelText: "Type here if you have any messages",
        ),
        maxLines: null,
      ),
    );
  }

  Widget materialTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _material,
        validator: (value) {
          if (value.isEmpty) {
            return "item's material should not be empty";
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
          labelText: "Provide item's material",
        ),
        maxLines: null,
      ),
    );
  }

  Widget imageTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _image,
        validator: (value) {
          if (value.isEmpty) {
            return "Type here if you have any messages";
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
          labelText: "Provide some images for better visuality",
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

  Widget hastagTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _hastag,
        validator: (value) {
          if (value.isEmpty) {
            return "Hastag can't be empty";
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
          labelText: "Hastag is needed",
        ),
        maxLines: null,
      ),
    );
  }

  Widget priceTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _price,
        validator: (value) {
          if (value.isEmpty) {
            return "Price can't be empty";
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
          labelText: "Price of item",
        ),
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (_globalkey.currentState.validate()) {
          print("haha");
          var response = await networkHandler.post("/blogpost/Add", {
              "title":  _title.text,
              "body": _body.text,
              "material": _material.text,
              "image":  [_image.text],
              "stock": _stock.text,
              "hastag": [_hastag.text],
              "price": _price.text,
              "color": _tempMainColor.toString(),
              "sex": _sex,
              "size": _size
          });
          print(response.statusCode);

          if (response.statusCode == 200 || response.statusCode == 201) {
            print("Success add new item");
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
            "Add item",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
