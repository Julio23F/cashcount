import 'package:flutter/material.dart';

class RememberSection extends StatelessWidget {
  const RememberSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Se souvenir de moi"),
          Text(
              "Mot de passe oublié",
            style: TextStyle(
              fontSize: 17,
              color: Colors.blue
            ),
          ),
        ],
      ),
    );
  }
}
