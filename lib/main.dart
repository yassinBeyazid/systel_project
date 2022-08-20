import 'package:flutter/material.dart';
import 'package:systel_project/model/authentication.dart';
import 'package:systel_project/model/db_queries.dart';
import 'package:systel_project/view/login/Login.dart';

void main() {
  runApp(MyApp());
  Authentication.initializeParse();
  DBQueries.createDatabase();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
