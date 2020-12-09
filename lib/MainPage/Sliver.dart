import 'package:flutter/material.dart';
import '../Constants.dart';
import '../Components/Detail/Detail.dart';
import '../Network/NetworkHandle.dart';
import '../MyHomePage.dart';
import '../Components/UpdateItem.dart';

class ItemScroll extends StatelessWidget {
  final data;
  ItemScroll({this.data});
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size ;
    NetworkHandler network = NetworkHandler();
    return Container(
      width: size.width ,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        children:[
          Container(
            height : size.width * 0.85 * 0.5,
            width: size.width * 0.4,
            decoration: BoxDecoration(
              image: (data["image"][0].contains("http")) ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data["image"][0].toString())
              )
             : Container(color: kPrimaryColor)
          )),
          Container(
            width: size.width * 0.85 * 0.4,
            margin: EdgeInsets.only(left: 20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data["title"]}", maxLines: 3, style: TextStyle(color: kPrimaryColor.withOpacity(0.7), fontWeight: FontWeight.bold, fontSize: 25.0),),
              Container(
                child : Text("${data["address"]}", maxLines: 3, style: TextStyle(color: Colors.grey)),
              ),
              Text("${data["price"]} VND", style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor)),
              Text("${data["stock"]} items available", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            ],
          )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PopupMenuButton(
                itemBuilder: (context) => [
                   PopupMenuItem(
                    child: GestureDetector(
                      child: Text("Delete"),
                      onTap: (){
                  
                        network
                            .delete("/blogpost/delete/" +
                                data["_id"].toString())
                            .then((value) {
                          if (value.statusCode == 200) {
                            print("Delete success !");
                             Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false);
                          } else
                            throw Exception("Problem with deleting");
                        });
                      }
                      
                    )
                  ),
                   PopupMenuItem(
                    child: GestureDetector(
                      child :  Text("Edit"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateItem(val: data)));
                      },
                    )
                  )
                ]
              ),

              GestureDetector(
            child:  Icon(Icons.arrow_forward_ios, size: 20),
            onTap: (){
               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(val: data)));
            }
          )
            ],
          )
        ]
      )
    );
  }
}