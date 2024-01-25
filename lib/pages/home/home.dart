import 'package:cashcount/pages/home/widgets/category.dart';
import 'package:cashcount/pages/home/widgets/header.dart';
import 'package:cashcount/pages/home/widgets/historique.dart';
import 'package:cashcount/pages/home/widgets/money.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3cadfc),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Transform(
                transform: Matrix4.identity()..rotateZ(20),
                origin: Offset(150, 50),
                child: Image.asset("assets/images/bg_liquid.png", width: 200,),
            ),
            Positioned(
                top: 200,
                right: 0,
                child: Transform(
                  transform: Matrix4.identity()..rotateZ(20),
                  origin: Offset(150, 50),
                  child: Image.asset("assets/images/bg_liquid.png", width: 200,),
                ),
            ),

            const Column(
              children: [
                SizedBox(height: 35),
                HeaderSection(),
                MoneySection(),
                CategorySection()
              ],
            )
          ],
        )
      ),

      bottomNavigationBar: NavigatorBar(),
    );
  }
}

Widget NavigatorBar(){
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'TodoList'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Revenus'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres'
        ),

      ]
  );
}
