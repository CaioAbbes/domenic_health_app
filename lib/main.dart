import 'package:domenic_health/views/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Exer Saúde',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Home()
    );
  }
}