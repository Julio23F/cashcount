import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';


class AddRevenusPage extends StatefulWidget {
  const AddRevenusPage({super.key});

  @override
  State<AddRevenusPage> createState() => _AddRevenusPageState();
}

class _AddRevenusPageState extends State<AddRevenusPage> {

  DateTime selectedConfDate = DateTime.now();

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
                      TextField(
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
                              child: TextField(
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
                              value: selectedConfDate,
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
                                  selectedConfDate = value!;
                                });
                              },

                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: DateTimeFormField(
                              decoration: const InputDecoration(
                                labelText: 'Date de fin',
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
                              firstDate: DateTime.now().toLocal(),
                              initialValue: DateTime.now(),
                              initialPickerDateTime: DateTime.now().add(const Duration(days: 30)),
                              onChanged: (DateTime? value) {
                                setState(() {
                                  selectedConfDate = value!;
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
