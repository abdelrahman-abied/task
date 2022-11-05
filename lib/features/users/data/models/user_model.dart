import 'dart:convert';

List<User> userFromMap(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToMap(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String? name;
  String? avatar;
  String? id;
  String? email;
  String? password;
  String? description;
  // List<String>? location;

  User({
    this.name,
    this.avatar,
    this.id,
    this.email,
    this.password,
    this.description,
    // this.location,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    id = json['id'];
    email = json['email'];
    password = json['password'];
    description = json['description'];
    // location = [];
    // location = json['location']?.forEach((v) {
    //       location?.add(v);
    //     }) ??
    //     [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['avatar'] = avatar;
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['description'] = description;
    // data['location'] = location;
    return data;
  }
}
