import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';


class AddRevenusPage extends StatefulWidget {
  const AddRevenusPage({super.key});

  @override
  State<AddRevenusPage> createState() => _AddRevenusPageState();
}

class _AddRevenusPageState extends State<AddRevenusPage> {

  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();

  final formKey = GlobalKey<FormState>();
  final revenusController = TextEditingController();
  final montantController = TextEditingController();

  @override
  void dispose() {
    revenusController.dispose();
    montantController.dispose();
    super.dispose();
  }

  // Récupérer l'utilisateur courant
  final currentUser = FirebaseAuth.instance.currentUser!;

  // Enregistrer dans cloud firestore
  Future addRevenus() async{
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator()
            );
          }
      );
      if(currentUser != null){

        await FirebaseFirestore.instance
            .collection("revenus")
            .add({
              "userId" : currentUser.uid,
              "revenusName": revenusController.text.trim(),
              "montant": montantController.text.trim(),
              "dateDebut" : dateDebut,
              "dateFin" : dateFin

        });
        revenusController.clear();
        montantController.clear();

        Navigator.of(context).pop();
      }
    }on FirebaseException catch (e) {
      Navigator.of(context).pop();
      // Gérer les erreurs (par exemple, e-mail en double, mot de passe faible, etc.)
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Ajouter un revenus",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                  ),
              ),
              SizedBox(height: 35,),
              Form(
                key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Revenus",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          hintText: "Intitulé du revenus",
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          filled: true,
                          fillColor: Color(0xfff6f4fa),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff6f4fa), // Nouvelle couleur du bord
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff6f4fa), // couleur du bord
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: revenusController,
                        validator: (value){
                          if(value == null || value.isEmpty ){
                            return "Invalide";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      // Montant du revenus
                      Text(
                        "Montant",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                  hintText: "Montant",
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xfff6f4fa),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xfff6f4fa), // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xfff6f4fa), // couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: montantController,
                                validator: (value){
                                  if(value == null || value.isEmpty ){
                                    return "Invalide";
                                  }
                                  return null;
                                },
                              ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "Ar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 35,),

                      // Date de début et de fin

                      Row(
                        children: [
                          Expanded(
                            child: DateTimeField(
                              value: dateDebut,
                              decoration: const InputDecoration(
                                  labelText: 'Date de début',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xfff6f4fa), // Nouvelle couleur du bord
                                    ),

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xfff6f4fa), // couleur du bord
                                    ),

                                  ),
                                ),
                              mode: DateTimeFieldPickerMode.date,
                              onChanged: (DateTime? value) {
                                setState(() {
                                  dateDebut = value!;
                                });
                              },

                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: DateTimeField(
                              value: dateFin,
                              decoration: const InputDecoration(
                                labelText: 'Date de début',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xfff6f4fa), // Nouvelle couleur du bord
                                  ),

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xfff6f4fa), // couleur du bord
                                  ),

                                ),
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              onChanged: (DateTime? value) {
                                setState(() {
                                  dateFin = value!;
                                });
                              },

                            ),
                          ),
                        ],
                      ),

                      // Boutton d'envoie

                      Container(
                        margin: EdgeInsets.only(top: 35),
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                                backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 66, 101, 224))
                            ),
                            onPressed: (){
                              if (formKey.currentState!.validate()) {

                                // Ajouter les revenus dans firestore
                                addRevenus();
                              }

                            },
                            child: Text(
                                "Enregistrer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                )
                            )
                        ),
                      ),

                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
