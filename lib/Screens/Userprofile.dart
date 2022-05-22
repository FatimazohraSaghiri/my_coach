import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Benutzer.dart';
import 'package:my_coach/Widgets/benutzerpriflibild.dart';

import 'Benutzerprofilbearbeiten.dart';

class Userprofile extends StatefulWidget {
  final benutzer ;
  const Userprofile({Key? key, required this.benutzer}) : super(key: key);

  @override
  _UserprofileState createState() => _UserprofileState(benutzer);
}

class _UserprofileState extends State<Userprofile> {
  var benutzer;
  _UserprofileState(this.benutzer);
  String currentbenutzer = "";
  String vorname = "";
  String nachname = "";
  String adresse = "";
  String beschreibung = "";
  String passwort ="";
  int betrid=0;
  var Profession;
String val="";

  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    OnReresh:true;
    getbenutzer();
    data(val);

  }

  Future getbenutzer() async {

    String url = "http://172.20.37.6:8081/${this.benutzer}";
    // final reponse = await  final response = await http.post(Uri.parse(url),
    try {
      print(url);
      setState(() async {
        final response = await http.get(Uri.parse(url));
        print(json.decode(response.body));
        Map<String, dynamic> data = new Map<String, dynamic>.from(
            json.decode(response.body));


        print(data['vorname']);
        vorname = data['vorname'];
        nachname = data['nachname'];
        adresse = data['adresse'];
        beschreibung = data['beschreibung'];
        Profession = data['professionEnum'];
        passwort=data['passwort'];
        this.betrid=data['id'];
        print(data['professionEnum']);
        print(data['id']);
      });
    } catch (err) {

    }
  }


  @override
  Widget build(BuildContext context) {
    getbenutzer();
    onRefresh:true;

    this.currentbenutzer = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    getbenutzer();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.indigo[200],
            title: Row(
              children: <Widget>[
                Text(
                  'Benutzerprofile',
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: RouteSettings(arguments:this.benutzer),
                            builder: (context) => Benutzerprofilbearbeiten()));
                  print(this.benutzer);},
                  child: Text('Bearbeiten',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[300],

                    ),),
                ),
              ],),
          ),
          backgroundColor: Colors.indigo[100],
          body: SafeArea(
    child: SingleChildScrollView(
    reverse:true,
            child: Column(
              children: [
                SizedBox(height: 35),
                benutzerprofilbild(),
                SizedBox(height: 20),

                Text(vorname + " " + nachname,
                    style: TextStyle(
                      fontSize: 30,
                    )),
                SizedBox(height: 27),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 640,
                  width: 520,
                  decoration: BoxDecoration(
                    color: Colors.indigo[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black54),
                  ),
                  child: Row(children: [Column(


                    children: [
                      SizedBox(height: 20),

                      beschreibungsCcontainer("Email-Adresse"),

                      data(adresse),
                      beschreibungsCcontainer("Profession"),
                      data(Profession),
                      beschreibungsCcontainer("Beschreibung"),
                      data(beschreibung)

                    ],
                  ),
                  ],),),
              ],
            ),
    ),
          ),

        ),

      ],
    );
  }

  Widget data(value) {
    getbenutzer();
    onRefresh:true;
    this.val=value;
    return Container(
      margin: EdgeInsets.all(20),
      height: 70,
      width: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(this.val== null ? '' : value,

            style: TextStyle(

              fontSize: 20,
            )),
      ),
    );
  }

  Widget beschreibungsCcontainer(value) {

    getbenutzer();
    return Container(
      height: 30,
      width: 450,
      margin: EdgeInsets.all(10),
      child: Text(value,
          style: TextStyle(

            fontSize: 25,
          )),
    );
  }
}



