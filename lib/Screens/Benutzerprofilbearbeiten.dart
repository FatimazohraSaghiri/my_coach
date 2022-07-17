import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Benutzer.dart';

class Benutzerprofilbearbeiten extends StatefulWidget {



  const Benutzerprofilbearbeiten({Key? key}) : super(key: key);

  @override
  _BenutzerprofilbearbeitenState createState() => _BenutzerprofilbearbeitenState();
}

class _BenutzerprofilbearbeitenState extends State<Benutzerprofilbearbeiten> {

  String currentbenutzer="";
  var benutzerid;
  Benutzer benutzer = Benutzer("", "", "", "", "","");


  @override
  void initState() {
    super.initState();
    getbenutzer();
  }


  Future aktualisiereKommentar() async{
    String url = "http://172.20.37.6:8081/benutzer/${this.benutzerid}";


    try{
      print(url);
      final response=await http.put(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(<String, String>{
          'adresse': benutzer.adresse,
          'passwort':benutzer.passwort,
          'beschreibung':benutzer.beschreibung,
        }),);
    }catch(e){
    }
  }

  Future getbenutzer() async {
    String url = "http://172.20.37.6:8081/${this.currentbenutzer}";
    print(currentbenutzer +" after link");
    try {
      print(url +" link");
      setState(() async {
        final response = await http.get(Uri.parse(url));
        print(json.decode(response.body));
        Map<String, dynamic> data = new Map<String, dynamic>.from(
            json.decode(response.body));
        print(data['id']);
        this.benutzerid=data['id'];
        print(benutzerid);
      });
    } catch (err) {

    }
  }
  @override
  Widget build(BuildContext context) {
    this.currentbenutzer= ModalRoute.of(context)!.settings.arguments as String;
    print(this.currentbenutzer +" befor");
    getbenutzer();
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
          fontSize: 22,
        ),
      ),
          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          FlatButton(
            color: Colors.indigo[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              aktualisiereKommentar();},
            child: Text('Speichern',
              style: TextStyle(
                fontSize: 18,
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
                    onChanged: (val) {
                      benutzer.adresse = val;

                    }, ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child:  TextField(
                    decoration: InputDecoration(
                      labelText: 'passwort',
                      contentPadding: EdgeInsets.all( 20),

                    ),
                    onChanged: (val) {
                      benutzer.passwort = val;
                    }, ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child:  TextField(
                    decoration: InputDecoration(
                      labelText: 'Beschreibung',
                      contentPadding: EdgeInsets.all( 20),

                    ),
                    onChanged: (val) {
                      benutzer.beschreibung = val;

                    },),
                ),


              ],
            ),

          ),


        ), ],
    );
  }



}
