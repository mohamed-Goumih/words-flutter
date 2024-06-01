import 'package:flutter/material.dart';
import 'random_words.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme:ThemeData(primaryColor: Colors.red) ,
      home:RandomWords());
  }
}




