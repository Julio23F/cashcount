import 'package:cashcount/pages/home/widgets/category.dart';
import 'package:cashcount/pages/home/widgets/header.dart';
import 'package:cashcount/pages/home/widgets/money.dart';
import 'package:cashcount/pages/home/widgets/somme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final expenseController = TextEditingController();
  final priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    expenseController.dispose();
    priceController.dispose();
    super.dispose();
  }


  String? _selectedCategory;

  // Récupérer l'utilisateur courant
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future addDepense() async{
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator()
            );
          }
      );

      await FirebaseFirestore.instance
          .collection("depenses")
          .add({
        "userId" : currentUser.uid,
        "categoriId": _selectedCategory,
        "name": expenseController.text.trim(),
        "prix" : num.parse(priceController.text.trim()),

      });
      expenseController.clear();
      priceController.clear();

      Navigator.of(context).pop();
      Navigator.pop(context);
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
      backgroundColor: Color(0xFFF6F8FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            HeaderSection(),
            MoneySection(),
            CategorySection(),



          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),




    );
  }

  Future displayBottomSheet (BuildContext context) {
    return showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 0.9  ,
      context: context,
      anchors: [0, 0.5, 0.9],
      isSafeArea: true,
      bottomSheetBorderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      builder: _buildBottomSheet,
    );
  }




  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Form(
          key: _formkey,
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Votre contenu principal à gauche
                  Text(
                      "Ajouter une dépense",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23
                      ),
                  ),

                  // L'icône alignée à droite
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, size: 30,),
                  )
                ],
              ),

              SizedBox(height: 25,),

              // Intitulé de la dépense
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dépense',
                  labelStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey, // Nouvelle couleur du bord
                    ),
                  ),
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Dépense invalide";
                  }
                  return null;
                },
                controller: expenseController,
              ),

              SizedBox(height: 25,),

              // Prix de la dépense
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Montant en Ar',
                        labelStyle: const TextStyle(
                          color: Colors.black26,
                        ),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey, // Nouvelle couleur du bord
                          ),
                        ),
                      ),
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "Montant invalide";
                        }
                        return null;
                      },
                      controller: priceController,
                    ),

                  ),
                  SizedBox(width: 25,),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("");
                        }
                        List<DropdownMenuItem<String>> items = [];
                        for (var doc in snapshot.data!.docs) {
                          String categoryName = doc.get('name');
                          String categoryId = doc.id;
                          items.add(
                            DropdownMenuItem(
                              value: categoryId,
                              child: Text(categoryName),
                            ),
                          );
                        }
                        return DropdownButtonFormField(
                          value: _selectedCategory,
                          items: items,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value as String?;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Categories',
                            labelStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),


              // Envoyer
              Container(
                margin: EdgeInsets.only(top: 35),
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 66, 101, 224))
                    ),
                    onPressed: (){
                      if (_formkey.currentState!.validate()) {

                        // Ajouter une dépense dans firestore
                        addDepense();

                      }
                    },
                    child: Text(
                        "Ajouter",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        )
                    )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
