import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SommeSection extends StatefulWidget {
  const SommeSection({Key? key});

  @override
  State<SommeSection> createState() => _SommeSectionState();
}

class _SommeSectionState extends State<SommeSection> {

  NumberFormat formatter = NumberFormat('#,###.##');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('revenus')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> revenusSnapshot) {
        if (revenusSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!revenusSnapshot.hasData) {
          return Text('Aucune donnée de revenus');
        }

        num revenusTotal = 0;
        for (DocumentSnapshot document in revenusSnapshot.data!.docs) {
          revenusTotal += document['montant'] ?? 0;
        }

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('depenses')
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> depensesSnapshot) {
            if (depensesSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!depensesSnapshot.hasData) {
              return Text('Aucune donnée de dépenses');
            }

            num depensesTotal = 0;
            for (DocumentSnapshot document in depensesSnapshot.data!.docs) {
              depensesTotal += document['prix'] ?? 0;
            }

            num somme = revenusTotal - depensesTotal;

            return Container(
              child: Text(
                "${formatter.format(somme)} Ar",
                style: TextStyle(color: Color(0xff0c3141), fontSize: 27, fontWeight: FontWeight.bold
                ),
              ),
            );
          },
        );
      },
    );
  }
}
