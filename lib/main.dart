import 'package:cashcount/pages/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cashcount',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
