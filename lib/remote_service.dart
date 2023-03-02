import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newmatrimony_api/model/usermodel.dart';
import 'package:http/http.dart' as http;

const String baseUrl =
    'https://63ddf109f1af41051b0b5b72.mockapi.io/api/matrimony';

class RemoteService {
  Future<List<UserModel>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://63ddf109f1af41051b0b5b72.mockapi.io/api/matrimony/Matrimony');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userModelFromJson(json);
    }
  }

  Future<List<UserModel>?> getFavUser() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://63ddf109f1af41051b0b5b72.mockapi.io/api/matrimony/Matrimony?FavUser=true');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      // print('response.body ::: ${response.body}');
      return userModelFromJson(json);
    }
  }

  Future<List<UserModel>?> getFemaleUser() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://63ddf109f1af41051b0b5b72.mockapi.io/api/matrimony/Matrimony?Gender=2');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      // print('response.body ::: ${response.body}');
      return userModelFromJson(json);
    }
  }
  Future<List<UserModel>?> getMaleUser() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://63ddf109f1af41051b0b5b72.mockapi.io/api/matrimony/Matrimony?Gender=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      // print('response.body ::: ${response.body}');
      return userModelFromJson(json);
    }
  }
  Future<dynamic> post(String api, dynamic object) async {
    var client = http.Client();
    var _header = {'Content-Type': 'application/json'};
    var uri = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var response = await client.post(uri, body: _payload, headers: _header);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {}
  }

  Future<List<UserModel>?> put(String api, dynamic object) async {
    var client = http.Client();
    var uri = Uri.parse(baseUrl + api);
    var _payload = object;

    var response = await client.put(uri, body: _payload);
    if (response.statusCode == 200) {
      // print('VALUE:::${response.body}');
      var json = response.body;
      return userModelFromJson(json);
    } else {}
  }

  Future<dynamic> delete(String api) async {
    var client = http.Client();
    var uri = Uri.parse(baseUrl + api);
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  Future<void> upsertIntoUserTable({
    cityId,
    userName1,
    dob,
    userId,
    gender1,
    mobileNo,
  }) async {
    Map<dynamic, dynamic> map = {};
    map['UserName'] = userName1.toString();
    map['Dob'] = dob.toString();
    map['CityID'] = cityId.toString();
    map['Gender'] = gender1.toString();
    map['Mobileno'] = mobileNo.toString();
    // print('USERID:::1:::$map');
    userId = int.parse(userId.toString());
    // print('USERID:::1:::$userId');
    if (userId != null && userId > 0) {
      var response = await RemoteService()
          .put(
            '/Matrimony/$userId',
            map,
          )
          .catchError((err) {});

      if (response == null) return;
      // debugPrint('successful:Edit');
    } else {
      var response1 =
          await RemoteService().post('/Matrimony', map).catchError((err) {});
      if (response1 == null) return;
      // debugPrint('successful:');
    }
  }

  Future<void> updateFavUser({userId, favUser}) async {
    Map<dynamic, dynamic> map = {};
    map['FavUser'] = favUser;
    // print('USERID:::1:::$map');
    userId = int.parse(userId.toString());
    if (userId != null && userId > 0) {
      var response = await RemoteService()
          .put(
            '/Matrimony/$userId',
            map,
          )
          .catchError((err) {});

      if (response == null) return;
      // debugPrint('successful:Edit');
    } else {}
  }
}
