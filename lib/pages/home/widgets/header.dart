import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
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
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        children: [
          CircleAvatar(child: Image.asset("assets/images/avatar.png")),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("Welcome!", style: TextStyle(color: Colors.grey, fontSize: 13),),
                // Afficher le pseudo stocké
                userDetails != null
                    ? Text(userDetails!['pseudo'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff212529)),)
                    : FutureBuilder(
                        future: getUserDetails(),
                        builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text("Erreur: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              userDetails = snapshot.data as Map<String, dynamic>;
                              return Text(userDetails!['pseudo'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff212529)),);
                            } else {
                              return Text("No data");
                            }
                        },
                ),
            ],
          )
        ],
      ),
    );
  }
}
