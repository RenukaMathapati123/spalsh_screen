import 'package:flutter/material.dart';

import 'package:flutter_project_4/models/spalsh_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: SpalshScreen(),
    debugShowCheckedModeBanner: false,
    );
  }
}

