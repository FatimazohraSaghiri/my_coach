import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textinputwidget extends StatelessWidget {
  const Textinputwidget({
    Key? key,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  }) : super(key: key);
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
          color: Colors.indigo[300], borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
        ),
        keyboardType: inputType,
        textInputAction: inputAction,
      ),
    );
  }
}
