import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class passwortinput extends StatelessWidget {
  const passwortinput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
          color: Colors.indigo[300], borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Passwort',
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
