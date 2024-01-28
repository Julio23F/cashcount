import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

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
          CircleAvatar(child: Image.asset("assets/images/avatar.png")),
          SizedBox(width: 15,),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome!", style: TextStyle(color: Colors.white70),),
              Text("FARALAHY Julio", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff212529)),)
            ],
          )
        ],
      ),
    );
  }
}
