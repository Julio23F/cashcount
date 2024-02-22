import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:left_scroll_actions/left_scroll_actions.dart';

class HistoriqueRevenus extends StatelessWidget {
  const HistoriqueRevenus({super.key});

  Icon getArticleIcon(String articleId) {
    switch (articleId) {
      case 'BOYmy0TCpnnZL01JC5Xw':
        // PPN
        return Icon(
          Icons.restaurant_menu,
          color: Colors.blue,
        );
      case 'CorRqWgRV3MCC7LB5O2P':
        // PPN
        return Icon(
          Icons.star,
          color: Colors.yellow,
        );
      case 'N45g3YQbPtzZhwCe9RyR':
        // PPN
        return Icon(
          Icons.time_to_leave_rounded,
          color: Colors.deepOrange,
        );
      case 'tEwkATormoFmtOwAP4kL':
        // PPN
        return Icon(Icons.home, color: Colors.purple);
      default:
        return Icon(Icons.error_outline);
    }
  }


  Future<void> deleteItem(documentId) async {
    try {
      // Accéder à Firestore et supprimer le document avec l'ID spécifié
      await FirebaseFirestore.instance.collection('revenus').doc(documentId).delete();


    } catch (e) {
      print('Erreur lors de la suppression de l\'élément : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15),
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
        SizedBox(
          height: 20,
        ),
        Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("revenus")
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Text("Aucune dépense enregistrée");
              } else {
                List<dynamic> depenses = [];
                snapshot.data!.docs.forEach((element) {
                  depenses.add(element);
                });
                return ListView.builder(
                  // Pour empecher l'effetr scroll par défaut
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: depenses.length,
                  itemBuilder: (context, index) {
                    NumberFormat formatter = NumberFormat('#,###.##');

                    final depense = depenses[index];

                    final name = depense["revenusName"];

                    final prix = formatter.format(depense["montant"]);

                    final revenusId = depense.reference.id;


                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      // child: CupertinoLeftScroll(
                      //   buttonWidth: 60,
                      //   child: Container(
                      //     height: 60,
                      //     color: Colors.white,
                      //     alignment: Alignment.center,
                      //     child: Text('👈 Try Scroll Left(iOS style)'),
                      //   ),
                      //   buttons: <Widget>[
                      //     LeftScrollItem(
                      //       text: 'Delete',
                      //       color: Colors.red,
                      //       onTap: () {
                      //         print('delete');
                      //       },
                      //     ),
                      //     LeftScrollItem(
                      //       text: 'Edit',
                      //       color: Colors.orange,
                      //       onTap: () {
                      //         print('edit');
                      //       },
                      //     ),
                      //   ],
                      //   onTap: () {
                      //     print('tap row');
                      //   },
                      // ),
                      child: CupertinoLeftScroll(
                        key: Key(revenusId),
                        closeTag: LeftScrollCloseTag(revenusId),
                        buttonWidth: 80,
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFFF6F8FF),
                                  ),
                                  child: Icon(
                                    Icons.credit_card_outlined,
                                    color: Colors.deepOrange,
                                    size: 35,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${name}",
                                          style: TextStyle(
                                            color: Color(0xFF0d2360),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Text(
                                        "Jan 2, 2024",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "${prix} Ar",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )
                              ],
                            ),
                          ),
                        ),
                        buttons: <Widget>[
                          LeftScrollItem(
                            text: 'edit',
                            color: Colors.orange,
                            onTap: () {
                              print('Modifier');
                            },
                          ),
                          LeftScrollItem(
                            text: 'Supprimer',
                            color: Colors.red,
                            onTap: () {
                              deleteItem(revenusId);
                            },
                          ),
                        ],
                        onTap: () {
                          print('tap dza');
                        },
                      ),
                    );

                  },
                );
              }
            },
          ),
        ),
      ],
    ));
  }
}
