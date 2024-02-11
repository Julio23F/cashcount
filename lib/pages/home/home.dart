import 'package:cashcount/pages/home/widgets/category.dart';
import 'package:cashcount/pages/home/widgets/header.dart';
import 'package:cashcount/pages/home/widgets/money.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FF),
      body: SingleChildScrollView(
        child: const Column(
          children: [
            SizedBox(height: 15),
            HeaderSection(),
            MoneySection(),
            CategorySection()

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
      maxHeight: 1,
      context: context,
      anchors: [0, 0.5, 1],
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Form(
          child: ListView(
            controller: scrollController,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, size: 30,),
                  )
              ),

              SizedBox(height: 25,),

              // Intitulé de la dépense
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Intitulé de la dépense",
                  hintStyle: const TextStyle(
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Montant en Ar",
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey, // Nouvelle couleur du bord
                    ),
                  ),
                ),
              ),

              // Catégorie



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
