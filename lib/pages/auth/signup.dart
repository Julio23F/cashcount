import 'package:cashcount/pages/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {

  final _formkey = GlobalKey<FormState>();

  final confEmailController = TextEditingController();
  final confMDPController = TextEditingController();
  final confPseudoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    confEmailController.dispose();
    confMDPController.dispose();
    confPseudoController.dispose();
  }

  Future signUp() async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .add({
          "pseudo": confPseudoController.text.trim(),
        });

        // Créer l'utilisateur
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: confEmailController.text,
          password: confMDPController.text,
        );

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Votre compte a été créé", textAlign: TextAlign.center,),
              );
            }
        );

      } on FirebaseException catch (e) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/auth.png'), // Remplacez par le chemin de votre image
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 130,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6F8FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Créer un compte",
                              style: TextStyle(
                                color: Color(0xff222d56),
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Pseudo',
                                  hintText: 'Votre pseudo',
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey, // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey, // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value){
                                  if(value == null || value.isEmpty ){
                                    return "Invalide";
                                  }
                                  return null;
                                },
                                controller: confPseudoController,
                              )
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Votre adresse email',
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey, // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey, // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value){
                                  if(value == null || value.isEmpty ){
                                    return "Adresse email invalide";
                                  }
                                  return null;
                                },
                                controller: confEmailController,
                              )
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  hintText: 'Votre mot de passe',
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey, // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey, // Nouvelle couleur du bord
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value){

                                  if(value!.length < 5){
                                    return "Le mot de passe doit contenir au moins 6 caractères";
                                  }
                                  return null;
                                },
                                controller: confMDPController,
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 35),
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 66, 101, 224))
                                ),
                                onPressed: signUp,
                                child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18
                                    )
                                )
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Vous avez déjà compte ?"),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) => LoginPage()
                                          )
                                      );
                                    },
                                    child: Text(
                                      "Connexion",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueAccent
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


