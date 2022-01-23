import 'package:flutter/material.dart';
import 'package:my_coach/Screens/Beitrag.dart';
import 'package:my_coach/Screens/Userprofile.dart';

import 'Screens/anmelden.dart';
import 'Screens/registrieren.dart';
import 'Screens/Mainview.dart';
import 'Widgets/Backgroundpicture.dart';

void main() => runApp(MyApp());

class MyApp  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Coach',
     initialRoute: '/',
     routes: {
       // When navigating to the "/" route, build the FirstScreen widget.
       '/': (context) =>  Mainview(),
       '/registrieren':(context)=> registrieren(),
       '/Mainview':(context)=>Mainview(),
       'Beitrag':(context)=> Beitrag(),
       '/Userprofile': (context)=>Userprofile(),


     },



   );
  }
}
