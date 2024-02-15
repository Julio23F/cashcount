import 'package:cashcount/pages/addRevenus/addRevenus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  late Stream<QuerySnapshot> _moneyStream;
  double totalMoney = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialiser le stream des revenus à partir de la base de données
    _moneyStream = FirebaseFirestore.instance
        .collection('revenus')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
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
                      Text(
                        "${totalMoney.toStringAsFixed(2)} Ar", // Affiche la somme des revenus
                        style: TextStyle(
                          fontSize: 35,
                        ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Liste de revenus",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder<QuerySnapshot>(
                    stream: _moneyStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      else if (!snapshot.hasData) {
                        return Center(child: Text("Aucun revenu trouvé"));
                      }
                      else {
                        List<DocumentSnapshot> revenus = snapshot.data!.docs;

                        print(totalMoney);
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: revenus.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot revenu = revenus[index];

                            // Récupérer la date pour chaque document
                            DateTime dateDebut = revenu['dateDebut'].toDate();
                            // Formater la date en un format précis
                            String formattedDate = DateFormat('MMM d, yyyy').format(dateDebut);


                            // Créer un objet NumberFormat pour formater le nombre
                            NumberFormat formatter = NumberFormat('#,###.##');

                            return Container(
                              margin: EdgeInsets.only(bottom: 15),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 18),
                                    child: Icon(Icons.credit_card_outlined, color: Colors.deepOrange, size: 40,),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            revenu['revenusName'],
                                            // Accédez au champ 'revenusName' du document
                                            style: TextStyle(
                                              color: Color(0xFF0d2360),
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                        Text(
                                          "$formattedDate",
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Text(
                                    "${formatter.format(double.parse(revenu['montant']))} Ar",
                                    style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                    ),
                                  )

                                ],
                              ),
                            );

                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}