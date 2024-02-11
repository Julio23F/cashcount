import 'package:flutter/material.dart';

class HistoriqueSection extends StatelessWidget {
  const HistoriqueSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Historique", style: TextStyle(color: Color(0xff22223b), fontSize: 17, fontWeight: FontWeight.w600)),
            SizedBox(height: 25),

            Column(
             children: [
               Container(
                 child: Row(
                   children: [
                     Container(
                       height: 50,
                       width: 50,
                       margin: EdgeInsets.only(right: 18),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xFFef4539),
                       ),
                       child: Icon(Icons.restaurant_menu, color: Colors.white, size: 30,),
                     ),
                     const Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                                 "Nouriture et PPN",
                                 style: TextStyle(
                                   color: Color(0xFF0d2360),
                                   fontWeight: FontWeight.bold,
                                 )
                             ),
                             Text(
                               "Jan 2, 2024",
                               style: TextStyle(
                                   color: Colors.grey
                               ),
                             )
                           ],
                         ),
                     ),

                     Text(
                         "2 550 Ar",
                          style: TextStyle(
                            color: Color(0xff6dde58),
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                     )

                   ],
                 ),
               )
             ],
           ),

          ],
        )
    );
  }
}
