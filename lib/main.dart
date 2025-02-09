import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes App",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity ,
            appBarTheme: AppBarTheme(color: Color.fromARGB(25, 26, 88, 98)),
      ),
      home: HomeScreen(),
    );
  }
}
