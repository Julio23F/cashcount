import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'historique.dart';

class CategorySection extends StatelessWidget {
  CategorySection({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {
      'icon': Icons.restaurant_menu,
      'color': Colors.blue,
      'name': 'PPN',
      'gategoriId' : 'BOYmy0TCpnnZL01JC5Xw',
    },
    {
      'icon': Icons.time_to_leave_rounded,
      'color': Colors.deepOrange,
      'name': 'Transport',
      'gategoriId' : 'N45g3YQbPtzZhwCe9RyR',
    },
    {
      'icon': Icons.home,
      'color':  Colors.purple,
      'name': 'Loyer',
      'gategoriId' : 'tEwkATormoFmtOwAP4kL',
    },
    {
      'icon': Icons.star,
      'color':  Colors.yellow,
      'name': 'Autres',
      'gategoriId' : 'CorRqWgRV3MCC7LB5O2P',
    },

  ];
  NumberFormat formatter = NumberFormat('#,###.##');
  String formatNumber(num number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double num = number / 1000;
      return '${num.toStringAsFixed(num.truncateToDouble() == num ? 0 : 1)}K';
    } else {
      double num = number / 1000000;
      return '${num.toStringAsFixed(num.truncateToDouble() == num ? 0 : 1)}M';
    }
  }


  Future<Widget> getTotalExpenses(String categoriId) async {
    num total = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('depenses')
        .where('categoriId', isEqualTo: categoriId)
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    querySnapshot.docs.forEach((doc) {
      // Suppose que le champ 'montant' existe dans les documents
      total += doc['prix'];
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //     "10 %",
        //     style: TextStyle(
        //         color: Color(0xff9692fc),
        //         fontWeight: FontWeight.bold,
        //         fontSize: 11
        //     ),
        // ),
        Text(
            "${formatNumber(total)} Ar",
            style: const TextStyle(
                color: Color(0xFF0d2360),
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
        ),
      ],
    ); // Retourne un widget de texte avec la valeur totale
  }



  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 35),
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 128,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                width: 95,
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
                    SizedBox(height: 12,),
                    FutureBuilder<Widget>(
                      future: getTotalExpenses(categories[index]['gategoriId']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("");
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Container(
                            // Affiche le widget de texte avec la valeur totale
                            child: snapshot.data,
                          );
                        }
                      },
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
