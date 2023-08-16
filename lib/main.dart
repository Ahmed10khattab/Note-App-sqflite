import 'package:flutter/material.dart';
import 'package:noteapp/AddNote.dart';
import 'package:noteapp/Screens/showNote.dart';
import 'package:noteapp/Screens/Home.dart';
import 'package:noteapp/function/database.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      routes:{
       'addNote' :(context)=>AddNote(),
        'showNote' :(context)=>showNote(),
      } ,
      home: HomeScreen(),
    );
  }
}
