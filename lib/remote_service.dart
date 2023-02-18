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
    var _header = {'Content-Type': 'application/json'};
    var uri = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var response = await client.post(uri, body: _payload, headers: _header);
    if (response.statusCode == 200) {
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

    Map<String, Object?> map = Map();
    map['UserName']=userName1;
    map['DOB']=dob;
    map['CityID']=cityId;
    map['Gender']=gender1;
    map['MobileNo']=mobileNo;
    // var user = UserModel(
    //     userName: userName1,
    //     gender: gender1,
    //     mobileno: mobileNo,
    //     cityId: cityId);
    print('USERID:::1:::$userId');
    if (userId!=null && int.parse(userId) > 0) {
      var response = await RemoteService()
          .put(
            '/Matrimony/$userId',
        map,
          )
          .catchError((err) {});
      if (response == null) return;
      debugPrint('successful:Edit');
    } else {
      var response = await RemoteService()
          .post('/Matrimony', map)
          .catchError((err) {});
      if (response == null) return;
      debugPrint('successful:');
    }
  }
}
