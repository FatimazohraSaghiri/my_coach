import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Benutzer.dart';
import 'package:my_coach/Screens/anmelden.dart';
import 'package:my_coach/Widgets/benutzerpriflibild.dart';
import 'Benutzerprofilbearbeiten.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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




  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      onRefresh:true;
      getbenutzer();
      data(val);
    });


  }


  Future getbenutzer() async {

    String url = "http://172.20.37.6:8081/${this.benutzer}";
    // final reponse = await  final response = await http.post(Uri.parse(url),
    try {
      print(url);
      setState(() async {
        onRefresh:true;
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
    return  ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
         return Stack(
          children: [
    Scaffold(
    appBar: AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.indigo[200],
    leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
    ),

    title: Row(
    children: <Widget>[
    Text(
    'Benutzerprofile',
    style: TextStyle(
    fontSize: 22,
    ),

    ),
    SizedBox(width:MediaQuery.of(context).size.width*0.2,),
    //if(this.currentbenutzer== benutzer)
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
    fontSize: 18,
    color: Colors.green[300],

    ),),
    ),
    // if(this.currentbenutzer==true)
    IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(
    builder: (context) => anmelden()));},
    icon: Icon(Icons.logout, color: Colors.white,),) ,],),
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
    margin: EdgeInsets.all(5),
    //
    height: MediaQuery.of(context).size.height*0.62,
   width:MediaQuery.of(context).size.width*0.95,
    decoration: BoxDecoration(
    color: Colors.indigo[200],
    borderRadius: BorderRadius.circular(15),
    border: Border.all(color: Colors.black54),
    ),
    child:Row(children: [Column(


    children: [
    SizedBox(height: 20),

    beschreibungsCcontainer("Email-Adresse"),
      SizedBox(height: 11),

    data(adresse),
    beschreibungsCcontainer("Profession"),
      SizedBox(height: 11),
    data(Profession),
    beschreibungsCcontainer("Beschreibung"),
      SizedBox(height: 11),
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
    },);
  }




  Widget data(value) {
    onRefresh:true;
    getbenutzer();
    this.val=value;
     return Container(
        margin: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.width*0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black54),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text(this.val == null ? '' : value,

              style: TextStyle(
                fontSize: 20,
              )),
        ),
                );
    }




  Widget beschreibungsCcontainer(value) {

    getbenutzer();
    return ScreenUtilInit(
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context , child) {
          return Container(
    height: 30,
    margin: EdgeInsets.all(5),
    child: Text(value,
    style: TextStyle(

    fontSize: 25,
    )),
    );
    });
  }
}



