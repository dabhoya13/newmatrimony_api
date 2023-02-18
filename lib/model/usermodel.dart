// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class
UserModel {
  UserModel({
    this.userName,
    this.dob,
    this.gender,
    this.mobileno,
    this.cityId,
    this.images,
    this.favUser,
    this.id,
  });

  String? userName;
  String? dob;
  int? gender;
  String? mobileno;
  int? cityId;
  String? images;
  bool? favUser;
  String? id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["UserName"],
    dob: json["Dob"],
    gender: json["Gender"],
    mobileno: json["Mobileno"],
    cityId: json["CityID"],
    favUser: json["FavUser"],
    images: json["Images"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "Gender": gender,
    "Mobileno": mobileno,
    "CityID": cityId,
  };
}
