import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class benutzerprofilbild extends StatelessWidget {
  const benutzerprofilbild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width:170,
        height:170,
        decoration: BoxDecoration(
          shape:BoxShape.circle,
          image:DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/userbild.jpg'),
          ),
          border:Border.all(width:4,color: Colors.white),
          boxShadow: [BoxShadow(spreadRadius:2, blurRadius: 9,)],
        ),

      ),
    );
  }
}
