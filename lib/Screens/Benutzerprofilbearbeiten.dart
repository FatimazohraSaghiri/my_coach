import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Benutzerprofilbearbeiten extends StatefulWidget {
  const Benutzerprofilbearbeiten({Key? key}) : super(key: key);

  @override
  _BenutzerprofilbearbeitenState createState() => _BenutzerprofilbearbeitenState();
}

class _BenutzerprofilbearbeitenState extends State<Benutzerprofilbearbeiten> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Scaffold(
    appBar: AppBar(
    toolbarHeight: 80,
      backgroundColor: Colors.indigo[200],
      title: Row(
        children: <Widget>[
        Text(
        'Profilbearbeiten',
        style: TextStyle(
          fontSize: 25,
        ),

      ),
          SizedBox(width: 100,),
          FlatButton(
            color: Colors.indigo[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            onPressed: () {
            },
            child: Text('Speichern',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[300],

              ),),
          ),
        ],), ),
          backgroundColor: Colors.indigo[100],
          body: SafeArea(
            child: Column(
              children:[
                Container(
                  margin: EdgeInsets.all(20),
                  child:  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email- Adresse',
                      contentPadding: EdgeInsets.all( 20),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child:  TextField(
                    decoration: InputDecoration(
                      labelText: 'Passwort',
                      contentPadding: EdgeInsets.all( 20),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child:  TextField(
                    decoration: InputDecoration(
                      labelText: 'Beschreibung',
                      contentPadding: EdgeInsets.all( 20),

                    ),
                  ),
                ),


              ],
            ),

          ),


        ), ],
    );
  }


}
