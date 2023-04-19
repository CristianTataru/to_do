import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/domain/repository/aplicatie_repository.dart';
import 'package:to_do_list/feature/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseRepository databaseRepository = DatabaseRepository();
  Database? myDatas = await databaseRepository.getAppData();
  if (myDatas != null) {
    database = myDatas;
  }
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
