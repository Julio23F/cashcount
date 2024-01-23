import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key});

  final List<Map<String, dynamic>> categories = const [
    {
      'icon': Icons.track_changes_outlined,
      'color':  Colors.purple,
      'name': 'PPN',
      'total' : "25.5 Ar",
      'pourcentage' : '56 %'
    },
    {
      'icon': Icons.track_changes_outlined,
      'color': Colors.deepOrange,
      'name': 'Loyer',
      'total' : "25.5 Ar",
      'pourcentage' : '56 %'
    },
    {
      'icon': Icons.track_changes_outlined,
      'color': Colors.blue,
      'name': 'Déplacement',
      'total' : "25.5 Ar",
      'pourcentage' : '56 %'
    },


  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 535,
      decoration: const BoxDecoration(
        color: Color(0xFFF6F8FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(15),
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFe8ebfc),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: categories[index]["color"] as Color,
                      ),
                      child: Icon(
                        categories[index]['icon'],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      categories[index]['pourcentage'],
                      style: TextStyle(
                          color: Color(0xff9692fc),
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    Text(
                      categories[index]['total'],
                      style: const TextStyle(
                          color: Color(0xFF0d2360),
                          fontWeight: FontWeight.bold,
                          fontSize: 28
                      ),
                    ),
                    Text(
                      categories[index]['name'],
                      style: const TextStyle(
                          color: Color(0xFFa2a8bd),
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 33),
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
