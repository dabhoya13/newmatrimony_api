import 'dart:io';

import 'package:flutter/services.dart';
import 'package:newmatrimony_api/model/city_model.dart';
import 'package:newmatrimony_api/model/gender_model.dart';
import 'package:newmatrimony_api/model/usermodel.dart';
import 'package:newmatrimony_api/remote_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'mymatrimony.db');
    return await openDatabase(
      databasePath,
      version: 2,
    );
  }

  Future<void> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mymatrimony.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'mymatrimony.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
    }
  }

  Future<int> deleteUserFromUserTable(userID) async {
    Database db = await initDatabase();
    int deletedid =
        await db.delete('Tbl_User', where: 'UserID = ?', whereArgs: [userID]);
    return deletedid;
  }

  Future<void> updateFavouriteUser(int userID, favUser) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();
    map['FavouriteUser'] = favUser;
    if (userID != -1) {
      await db
          .update('Tbl_User', map, where: 'UserID = ?', whereArgs: [userID]);
    } else {
      await db.insert('Tbl_User', map);
    }
  }

  Future<List<CityModel>> getCityListFromTbl() async {
    List<CityModel> cityList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery('select * from City_Tbl');
    CityModel model = CityModel(CityName1: 'Select City', CityID1: -1);
    model.CityID = -1;
    model.CityName = 'Select City';
    cityList.add(model);
    for (int i = 0; i < data.length; i++) {
      model = CityModel(
          CityID1: data[i]['CityID'] as int,
          CityName1: data[i]['CityName'].toString());
      cityList.add(model);
    }
    return cityList;
  }

  Future<List<GenderModel>> getGenderFromTbl() async {
    List<GenderModel> genderList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery('select * from Gender_Tbl');
    GenderModel model =
        GenderModel(genderName1: 'Select Gender', genderID1: -1);
    model.genderID = -1;
    model.genderName = 'Select Gender';
    genderList.add(model);
    for (int i = 0; i < data.length; i++) {
      model = GenderModel(
          genderID1: data[i]['GenderID'] as int,
          genderName1: data[i]['GenderName'].toString());
      genderList.add(model);
    }
    return genderList;
  }
}
