import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmatrimony_api/model/usermodel.dart';
import 'package:newmatrimony_api/remote_service.dart';

class ApiDemo extends StatefulWidget {
  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

String? stringResponse;
List<UserModel>? list;
var isdata = false;

class _ApiDemoState extends State<ApiDemo> {
  @override
  void initState() {
    super.initState();
    apiCall();
  }

  apiCall() async {
    list = await RemoteService().getPosts();
    if (list != null) {
      setState(() {
        isdata = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text('Call API'),
        ),
        body: Visibility(
          visible: isdata,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Text(list![index].userName.toString()),
              );
            },
            itemCount: list?.length,
          ),replacement: Center(child: CircularProgressIndicator(),),
        )));
  }

// Future<Map<String, dynamic>> callEntriesApi() async {
//   http.Response res = await http.get(Uri.parse(
//       'https://63ddf109f1af41051b0b5b72.mockapi.io/api/matrimony/TestApi'));
//   Map<String, dynamic> map = jsonDecode(res.body.toString());
//   return map;
// }
}
