import 'package:cashcount/pages/home/widgets/category.dart';
import 'package:cashcount/pages/home/widgets/header.dart';
import 'package:cashcount/pages/home/widgets/money.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FF),
      body: SingleChildScrollView(
        child: const Column(
          children: [
            SizedBox(height: 15),
            HeaderSection(),
            MoneySection(),
            CategorySection()
          ],
        )
      ),



    );
  }
}
