import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkPlace{
  String baseUrl = "https://intense-everglades-28347.herokuapp.com/";

   Future<http.Response> post(Map body) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "token";
    final token = prefs.get(key) ?? 0;

    print(body);
    var response = await http.post(
      baseUrl,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }
}
class NetworkHandler {
  String baseurl = "https://desolate-wave-01147.herokuapp.com";
  // String baseurl = "http://localhost:5000/";
  
  Future get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "token";
    final token = prefs.get(key) ?? 0;
    url = formater(url);

    print(url);
    // /user/register
    var response = await http.get(
      url,
      headers: {'Accept': 'application/json', "Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);

      return json.decode(response.body);
    }
    print(response.body);
    print(response.statusCode);
  }

  Future<http.Response> post(String url, Map body) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "token";
    final token = prefs.get(key) ?? 0;
    url = formater(url);
    print(body);
    print(url);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

   Future<http.Response> patch(String url, Map body) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "token";
    final token = prefs.get(key) ?? 0;
    url = formater(url);
    print(body);
    print(url);
    var response = await http.patch(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    final prefs = await SharedPreferences.getInstance();
    url = formater(url);
    final key = "token";
    String token = prefs.get(key);
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = baseurl + "/blogpost" ;
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200){
      print("Complete loading data");
      return json.decode(response.body);
    }
    else throw("Cannot get data");
  }

  void addDataProducto(String _nameController, String _priceController, String _stockController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = baseurl + "/items";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$_nameController",
      "price": "$_priceController",
      "stock": "$_stockController"
    });
    final status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      save(data["token"]);
    }
  }

  void editarProduct( String _id, String name, String price, String stock) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$baseurl/item/$_id";
    http.put(myUrl, body: {
      "name": "$name",
      "price": "$price",
      "stock": "$stock"
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  //function save
  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  //function read
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

  //function for delete
  Future<void> removeRegister(String _id) async {
    String myUrl = "$baseurl/product/$_id";

    http.Response res = await http.delete("$myUrl");

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Can't delete post.";
    }
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String username) {
    String url = formater("/uploads//$username.jpg");
    return NetworkImage(url);
  }
}
