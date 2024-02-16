import 'package:flutter/material.dart';

import 'historique.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key});

  final List<Map<String, dynamic>> categories = const [
    {
      'icon': Icons.restaurant_menu,
      'color': Colors.blue,
      'name': 'PPN',
      'total' : "55.4K Ar",
      'pourcentage' : '56 %'
    },
    {
      'icon': Icons.time_to_leave_rounded,
      'color': Colors.deepOrange,
      'name': 'Transport',
      'total' : "25.5K Ar",
      'pourcentage' : '20 %'
    },
    {
      'icon': Icons.home,
      'color':  Colors.purple,
      'name': 'Loyer',
      'total' : "23.5K Ar",
      'pourcentage' : '10 %'
    },
    {
      'icon': Icons.star,
      'color':  Colors.yellow,
      'name': 'Autres',
      'total' : "18.1K Ar",
      'pourcentage' : '15 %'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Couleur de l'ombre
            spreadRadius: 5, // Étendue de l'ombre
            blurRadius: 15, // Flou de l'ombre
            offset: Offset(0, 3), // Décalage de l'ombre (X, Y)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text("Catégories", style: TextStyle(color: Color(0xff22223b), fontSize: 17, fontWeight: FontWeight.w600))
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                width: 105,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF6F8FF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: categories[index]["color"] as Color,
                      ),
                      child: Icon(
                        categories[index]['icon'],
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text(
                      categories[index]['pourcentage'],
                      style: TextStyle(
                          color: Color(0xff9692fc),
                          fontWeight: FontWeight.bold,
                          fontSize: 11
                      ),
                    ),
                    Text(
                      categories[index]['total'],
                      style: const TextStyle(
                          color: Color(0xFF0d2360),
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    Text(
                      categories[index]['name'],
                      style: const TextStyle(
                          color: Color(0xFFa2a8bd),
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 20),
              itemCount: categories.length,
            ),
          ),
          SizedBox(height: 10,),
          HistoriqueSection()
        ],
      ),
    );
  }
}
