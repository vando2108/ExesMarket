import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../WallUser/WallUser.dart'; 
import 'package:flutter_tags/flutter_tags.dart';

class ProductDescription extends StatelessWidget {
   ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);

  final product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width* 0.85,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
             Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WallUser(username: product["username"])));
          },
          child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Text("${product["username"]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        )
        ),
        Container(
          child: Text("${product["title"]}", style: TextStyle(fontSize: 30, color: kPrimaryColor, fontWeight: FontWeight.bold))
        ),
        Container(
                  width: MediaQuery.of(context).size.width * .85,

          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 2.0) ,
            borderRadius: BorderRadius.all(Radius.circular(10.0))

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text("Description", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),

             Container(
               margin: EdgeInsets.only(top: 10),
          child: Text("${product["body"]}")
        ),
            ]
          )
        ),
        SizedBox(height: 10),
       Container(
         padding: EdgeInsets.all(3.0),
        width: MediaQuery.of(context).size.width * .85,
         decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
         ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85 / 2,
              child :  Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.article_outlined),
                SizedBox(width: 3.0),
                Text("Stock ")
              ]
            ),
            SizedBox(height: 3.0),
            Text("${product["stock"]}", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ]
        ),
       
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.free_breakfast_outlined),
                SizedBox(width: 3.0),
                Text("Material ")
              ]
            ),
            SizedBox(height: 3.0),
            Text("${product["material"]}", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ]
        ),
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.money),
                SizedBox(width: 3.0),
                Text("Price ")
              ]
            ),
            SizedBox(height: 3.0),
            Text("${product["price"]}" + " VND", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ]
        ),
       

           ],
         ),
            ),
         Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

           children: [
              Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 3.0),
                Text("Address ")
              ]
            ),
            SizedBox(height: 3.0),
            Container(
              width: MediaQuery.of(context).size.width* 0.80/2,
              child: Text("${product["address"]}", maxLines: 4, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
            )
          ]
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_4_sharp),
                SizedBox(width: 3.0),
                Text("Size ")
              ]
            ),
            SizedBox(height: 3.0),
            Text("${product["size"]}", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ]
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline),
                SizedBox(width: 3.0),
                Text("Sex ")
              ]
            ),
            SizedBox(height: 3.0),
            Text("${product["sex"]}", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ]
        ),
           ]
         )
           ]
         )
       ),
       _trendingTag()
        
      ],
    )
    );
  }
   Widget _trendingTag() {
    return Container(
        child: Tags(
      key: _tagStateKey,
      itemCount: product["hastag"].length,
      itemBuilder: (int index) {
        final item = product["hastag"][index];

        return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            active: false,
            activeColor: Colors.white,
            textActiveColor: Colors.black,
            textStyle: TextStyle(
              fontSize: 15,
            ),
            combine: ItemTagsCombine.withTextBefore,
            image: ItemTagsImage(image: AssetImage("assets/images/img.png")),
            onPressed: (item) {
             /* print(item);
              network.post('/blogpost/getSomeFunny', {"sex": item.title}).then(
                  (value) {
                var data = json.decode(value.body);
                data = data['data'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PageSearch(query: item.title, data: data)));
              });*/
            });
      },
    ));
  }
    final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
}