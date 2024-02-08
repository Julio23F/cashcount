import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {

  // Récupérer l'utilisateur courant
  final currentUser = FirebaseAuth.instance.currentUser!;
  // currentUser.email pour afficher directement l'email dans le l'autentification de firebase


  // Récupérer les détails de l'utilisateur courant
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails () async {
    return await FirebaseFirestore.instance.collection("users")
        .doc(currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 25,
          right: 25
      ),
      child: Row(
        children: [

          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: CircleAvatar(child: Image.asset("assets/images/avatar.png")),
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome!", style: TextStyle(color: Colors.grey),),
              Text(currentUser.email!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff212529)),),
              FutureBuilder(
                  future: getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Erreur: ${snapshot.error}");
                    }
                    else if (snapshot.hasData) {
                      Map <String, dynamic>? user = snapshot.data!.data();
                      return Text(user!['pseudo'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff212529)),);
                    }
                    else {
                      return Text("No data");
                    }
                  }
              ),
            ],
          )
        ],
      ),
    );
  }
}

