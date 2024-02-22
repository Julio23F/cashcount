import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  // Récupérer l'utilisateur courant
  final currentUser = FirebaseAuth.instance.currentUser!;
  // currentUser.email pour afficher directement l'email dans le l'autentification de firebase

  // Stocker les détails de l'utilisateur courant une fois récupérés
  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    // Appeler getUserDetails lors de l'initialisation du widget
    getUserDetails().then((value) {
      setState(() {
        userDetails = value;
      });
    });
  }
  // Récupérer les détails de l'utilisateur courant
  Future<Map<String, dynamic>> getUserDetails() async {
    final document = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
    return document.data() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/avatar.png",
                    width: 70,
                  ),
                  SizedBox(height: 25,),
                  userDetails != null
                      ? Text(userDetails!['pseudo'],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0c3141)
                      ),
                      )
                      : FutureBuilder(
                      future: getUserDetails(),
                      builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          else if (snapshot.hasError) {
                            return Text("Erreur: ${snapshot.error}");
                          }
                          else if (snapshot.hasData) {
                            userDetails = snapshot.data as Map<String, dynamic>;
                            return Text(userDetails!['pseudo'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff212529)),);
                          }
                          else {
                            return Text("No data");
                          }
                      },
                    ),
                  Text(
                      "${currentUser.email}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                            backgroundColor: MaterialStatePropertyAll(Color(0xff409bfc))
                        ),
                        onPressed: (){

                        },
                        child: Text(
                            "Modifier profil",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            )
                        )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),

            // Info compte
            Container(
              margin: EdgeInsets.only(bottom: 7),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 18),
                      child: Icon(
                        Icons.comment_outlined,
                        size: 25,
                        color: Color(0xff409bfc),
                      )
                  ),
                  Text(
                    "Mon compte",
                    style: TextStyle(
                        color: Color(0xff0c3141),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Spacer(),
                  Container(
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                  ),
                ],
              ),
            ),


            // Info concernant l'application
            Container(
              margin: EdgeInsets.only(bottom: 7),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 18),
                      child: Icon(
                        Icons.info_outline,
                        size: 25,
                        color: Color(0xff409bfc),
                      )
                  ),
                  Text(
                    "À propos",
                    style: TextStyle(
                        color: Color(0xff0c3141),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Spacer(),
                  Container(
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                  ),
                ],
              ),
            ),

            // Mode Dark
            Container(
              margin: EdgeInsets.only(bottom: 7),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 18),
                      child: Icon(
                        Icons.wb_sunny_outlined,
                        size: 25,
                        color: Color(0xff409bfc),
                      )
                  ),
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                        color: Color(0xff0c3141),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Spacer(),
                  Container(
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                  ),
                ],
              ),
            ),

            // Déconexion
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Voulez-vous réellement vous déconnecter ?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Fermer le popup
                            Navigator.of(context).pop();
                          },
                          child: Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Fermer le popup
                            Navigator.of(context).pop();
                            // Se déconnecter
                            FirebaseAuth.instance.signOut();
                          },
                          child: Text('Confirmer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 7),
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 18),
                        child: Icon(
                          Icons.logout_outlined,
                          size: 25,
                          color: Color(0xff409bfc),
                        )
                    ),
                    Text(
                      "Déconnexion",
                      style: TextStyle(
                          color: Color(0xff0c3141),
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    Spacer(),
                    Container(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      )
    );
  }
}
