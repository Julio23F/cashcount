import 'package:cashcount/pages/addRevenus/julio.dart';
import 'package:cashcount/pages/addRevenus/widgets/historiqueRevenus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../home/widgets/historique.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 16.0),
        child: Container(
          child: AppBar(
            title: Text(
              "Mes cartes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.deepOrange,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: AddRevenusPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFF6F8FF),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Column(
                    children: [
                      Text(
                        "Revenus total",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                        StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('revenus')
                            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // Affichage d'un indicateur de chargement en attendant les données
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Une erreur s\'est produite');
                          }
                          // Calcul de la somme des montants
                          double somme = 0.0;
                          snapshot.data!.docs.forEach((doc) {
                            // On ajoute le montant du document à la somme (si le montant est null, on ajoute 0.0)
                            somme += doc['montant'] ?? 0.0;
                          });
                          return Text(
                            // Affiche la somme des revenus
                            "${somme.toStringAsFixed(2)} Ar",
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          );
                        },
                      ),


                      SizedBox(height: 50),
                      Divider(
                        color: Color(0xffabbbde),
                        height: 1,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HistoriqueRevenus(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
