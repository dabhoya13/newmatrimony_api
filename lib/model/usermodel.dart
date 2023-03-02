// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.userName,
    this.dob,
    this.gender,
    this.mobileno,
    this.cityId,
    this.favUser,
    this.images,
    this.id,
  });

  String? userName;
  String? dob;
  String? gender;
  String? mobileno;
  String? cityId;
  String? favUser;
  String? images;
  String? id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["UserName"].toString(),
    dob: json["Dob"].toString(),
    gender: json["Gender"].toString(),
    mobileno: json["Mobileno"].toString(),
    cityId: json["CityID"].toString(),
    favUser: json["FavUser"].toString(),
    images: json["Images"].toString(),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "Dob": dob,
    "Gender": gender,
    "Mobileno": mobileno,
    "CityID": cityId,
    "FavUser": favUser,
    "Images": images,
    "id": id,
  };
}
