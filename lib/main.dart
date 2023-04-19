import 'package:flutter/material.dart';
import 'package:to_do_list/domain/repository/aplicatie_repository.dart';
import 'package:to_do_list/feature/home/home_page.dart';

DatabaseRepository databaseRepository = DatabaseRepository();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseRepository.getAppData();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
