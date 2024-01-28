import 'package:flutter/material.dart';


class InputSection extends StatelessWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
        child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter Email',
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
        )
    );
  }
}
