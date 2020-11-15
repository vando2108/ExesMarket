import 'Item.dart';
import 'DOB.dart';
import 'History.dart';

class User {
  final String email;
  final String username;
  final String password;
  final String bio;
  final List<Item> items;
  final DOB dob;  
  final List<String> hastag;
  final String follower;
  final String following;
  final List<History> history;
  final String phone;
  User(
      {this.email,
      this.password,
      this.username,
      this.dob,
      this.bio,
      this.items,
      this.hastag,
      this.follower,
      this.following, 
      this.history,
      this.phone
    });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      dob: json['dob'],
      items: json['items'] != null
          ? new List<Item>.from(json['items'])
          : null,
      hastag : json['hastag'] != null 
          ? new List<String>.from(json['hastag'])
          : null,
      follower: json['follower'],
      following: json['following'],
      history: json['history'] != null
          ? new List<History>.from(json['history'])
          : null,
      phone: json['phone'],
      bio: json['bio']
          );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['bio'] = this.bio;
    if (this.items != null) {
      data['items'] = this.items;
    }
    data['phone'] = this.phone;
    data['follower']= this.follower;
    data['following'] = this.following;
    if (this.history != null){
      data['history'] = this.history;
    }
    data['dob'] = this.dob;
    if (this.hastag != null){
      data['hastag'] = this.hastag;
    }
    return data;
  }
}