import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../database/database.dart';

class DatabaseRepository {
  Future<Database?> getAppData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? appDataJson = prefs.getString('myApp');
    if (appDataJson == null) {
      return null;
    }
    Database myData = Database.fromJson(jsonDecode(appDataJson));
    return myData;
  }

  void saveAppData(Database data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('myApp', jsonEncode(data));
  }
}
