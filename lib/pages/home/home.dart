import 'package:cashcount/pages/home/widgets/category.dart';
import 'package:cashcount/pages/home/widgets/header.dart';
import 'package:cashcount/pages/home/widgets/money.dart';
import 'package:chip_list/chip_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String selectedConfType = 'PPN';

  String? _selectedCategory;

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
        tooltip: 'Incrémenter',
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
                    ),
                  ),
                  SizedBox(width: 25,),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        List<DropdownMenuItem<String>> items = [];
                        for (var doc in snapshot.data!.docs) {
                          String categoryName = doc.get('name');
                          items.add(
                            DropdownMenuItem(
                              value: categoryName,
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

              // Column(
              //   // Julio
              //   children: [
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     ChipList(
              //       listOfChipNames: _dogeNames,
              //       activeBgColorList: [Theme.of(context).primaryColor],
              //       inactiveBgColorList: [Colors.white],
              //       activeTextColorList: [Colors.white],
              //       inactiveTextColorList: [Theme.of(context).primaryColor],
              //       listOfChipIndicesCurrentlySeclected: [_currentIndex],
              //       extraOnToggle: _updateCurrentIndex,
              //     ),
              //
              //   ],
              // ),


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
