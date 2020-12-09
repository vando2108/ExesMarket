import '../Network/NetworkHandle.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../MyHomePage.dart';

class AddProfile extends StatefulWidget {
  AddProfile({Key key}) : super(key: key);

  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  int stock = 0;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _DOB = TextEditingController();
  TextEditingController _titleline = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _hastag = TextEditingController();
  TextEditingController _phone = TextEditingController();
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
            nameTextField(),
            
            professionTextField(),
            
            titlelineTextField(),
            
            hastagTextField(),
            
            dobTextField(),
            
            aboutTextField(),
            
            phoneTextField(),
            
            addButton(),
          ],
        ),
      ),
    );
  }

  Widget nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _name,
        validator: (value) {
          if (value.isEmpty) {
            return "Name can't be empty";
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
          labelText: "Provide your name",
        ),
        maxLines: null,
      ),
    );
  }

  Widget professionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
                vertical: 10,

      ),
      child: TextFormField(
        controller: _profession,
        validator: (value) {
          if (value.isEmpty) {
            return "Provide your work ";
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
          labelText: "Provide your work",
        ),
        maxLines: null,
      ),
    );
  }

  Widget titlelineTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
                vertical: 10,

      ),
      child: TextFormField(
        controller: _titleline,
        validator: (value) {
          if (value.isEmpty) {
            return "Titleline should not be empty";
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
          labelText: "Provide your titleline",
        ),
        maxLines: null,
      ),
    );
  }

  Widget dobTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,        vertical: 10,

      ),
      child: TextFormField(
        controller: _DOB,
        validator: (value) {
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
          labelText: "Provide your date of birth",
        ),
        maxLines: null,
      ),
    );
  }

  Widget aboutTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _about,
        validator: (value) {
          if (value.isEmpty) {
            return "Background can't be empty";
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
          labelText: "Provide your background info",
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

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _phone,
        validator: (value) {
          if (value.isEmpty) {
            return "Phone number can't be empty";
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
          labelText: "Provide your phonenumber",
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
          var response = await networkHandler.post("/profile/add", {
              "name":  _name.text,
              "profession": _profession.text,
              "DOB":  _DOB.text,
              "titleline": _titleline.text,
              "about": _about.text,
              "phone": _phone.text,
              "hastag":[_hastag.text],
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
