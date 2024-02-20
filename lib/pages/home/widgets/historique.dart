import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:left_scroll_actions/cupertinoLeftScroll.dart';
import 'package:left_scroll_actions/global/actionListener.dart';
import 'package:left_scroll_actions/leftScroll.dart';

class HistoriqueSection extends StatelessWidget {
  const HistoriqueSection({super.key});


  Icon getArticleIcon(String articleId) {
    switch (articleId) {
      case 'BOYmy0TCpnnZL01JC5Xw':
      // PPN
        return Icon(Icons.restaurant_menu, color: Colors.blue,);
      case 'CorRqWgRV3MCC7LB5O2P':
      // PPN
        return Icon(Icons.star, color: Colors.yellow,);
      case 'N45g3YQbPtzZhwCe9RyR':
      // PPN
        return Icon(Icons.time_to_leave_rounded, color: Colors.deepOrange,);
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
      await FirebaseFirestore.instance.collection('depenses').doc(documentId).delete();


    } catch (e) {
      print('Erreur lors de la suppression de l\'élément : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

                child: Text("Historique", style: TextStyle(color: Color(0xff22223b), fontSize: 17, fontWeight: FontWeight.w600))
            ),

            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("depenses")
                    .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Text("Aucune dépense enregistrée");
                  }
                  else {
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

                        final name = depense["name"];
                        final categoriId = depense["categoriId"];

                        final prix = formatter.format(depense["prix"]);

                        final historiqueId = depense.reference.id;

                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: CupertinoLeftScroll(
                            key: Key(historiqueId),
                            closeTag: LeftScrollCloseTag(historiqueId),
                            buttonWidth: 80,
                            child: Container(
                              height: 60,
                              alignment: Alignment.center,
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
                                      // child: Icon(Icons.restaurant_menu, color: Colors.white, size: 30,),
                                      child: getArticleIcon(categoriId)
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${name}",
                                            style: TextStyle(
                                              color: Color(0xFF0d2360),
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                        Text(
                                          "Jan 2, 2024",
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: Text(
                                      "${prix} Ar",
                                      style: TextStyle(
                                          color: Color(0xff6dde58),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            buttons: <Widget>[
                              LeftScrollItem(
                                text: 'Supprimer',
                                color: Colors.red,
                                onTap: () {
                                  deleteItem(historiqueId);
                                },
                              ),
                            ],
                            onTap: () {
                              print('tap row');
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
        )
    );
  }
}
