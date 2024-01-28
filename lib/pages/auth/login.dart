import 'package:cashcount/pages/auth/widgets/input.dart';
import 'package:cashcount/pages/auth/widgets/remember.dart';
import 'package:cashcount/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                top: 170,
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
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Login Page",
                              style: TextStyle(
                                color: Color(0xff222d56),
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          InputSection(),
                          InputSection(),
                          RememberSection(),
                          Container(
                            margin: EdgeInsets.only(top: 35),
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 66, 101, 224))
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => HomePage()
                                      )
                                  )
                                },
                                child: Text(
                                  "Envoyer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                  )
                                )
                            ),
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
