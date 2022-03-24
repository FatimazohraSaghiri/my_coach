

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_coach/Models/Beitrag.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Benutzer.dart';
import 'package:my_coach/Screens/anmelden.dart';



class Beitraege extends StatefulWidget {
  const Beitraege({Key? key}) : super(key: key);

  @override
  _BeitraegeState createState() => _BeitraegeState();
}
@override
class _BeitraegeState extends State<Beitraege> {


  Beitrag beitrag= Beitrag("","","","");
  List KategorieListe= [];
  String? selectedValue= "TANZEN";
  String Beitragtitel="";
  String Beitragsinhalt="";

  String currentbenutzer= "";


  // Liste der Verfügbaren Kategorien
  Future getKategorieliste()async {
    String url = "http://172.20.37.6:8081/kategorieListe";
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        List data;
        data=json.decode(response.body);
        print(data);

        setState(() {
          KategorieListe = data;
        });

        debugPrint(KategorieListe.toString());
      }
    } catch (err) {}
  }

@override
void initState(){
    super.initState();
    getKategorieliste();
}




//post methode für einen Neuen Beitrag
  Future neuesBeitrag()async{
    try{
 //http://172.20.37.6:8081/anmelden
    String url = "http://172.20.37.6:8081/beitrag/add/${this.currentbenutzer}";

    //add/? x=benutzer.adresse

    print('zeige url: '+ url);
    print('peint benutzer:');
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type':'application/json;charset=UTF-8',},
        body: json.encode({
          'titel': Beitragtitel,
          'inhalt':Beitragsinhalt,
          'kategorie': selectedValue,
          'Benutzer':currentbenutzer
        }));
    print(response);
      print(response.body);
    } catch(e){
      print('succesful added?');
    throw Exception('irgenwas ist schief gelaufen. Bitte versuchen sie es nochmal ');
  }}

// Deseign der Beitrag UI
  @override
  Widget build(BuildContext context) {
 this.currentbenutzer= ModalRoute.of(context)!.settings.arguments as String;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: Colors.indigo[200],

              title: Row(
                children: <Widget>[
                  Text(
                    'Neues Beitrag',
                    style:TextStyle(
                      fontSize: 25,
                    ),

                  ),

                  SizedBox(width: 150),
                  FlatButton(
                    color:Colors.indigo[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: (){

                      getKategorieliste();
                      neuesBeitrag();
                    },
                    child: Text('Posten',
                      style:TextStyle(
                        fontSize: 20,
                        color: Colors.green[300],

                      ), ),
                  ),
                ],
              )
          ),
          backgroundColor: Colors.indigo[100],
          body:SafeArea(
            child: SingleChildScrollView(
              reverse:true,
              child:Column(
              children: [
                SizedBox(height:70),
                Padding(
                  padding: EdgeInsets.all(10),
                  child:Align(
                    alignment: Alignment.topLeft,
                    child: Text("Title",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 80,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:Colors.white30,

                  ),

                  child: TextFormField(
                    controller: TextEditingController(text: beitrag.titel),
                    onChanged: (val){
                      beitrag.titel = val;
                      Beitragtitel= beitrag.titel;
                    },
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Bitte beschreiben sie ihren Wunsch';
                      }
                        return'';
                      },
                    decoration: InputDecoration(
                      hintText: 'title',
                      contentPadding: EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height:40,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child:Align(
                    alignment: Alignment.topLeft,
                    child: Text("Inhalt",
                      style: TextStyle(
                        fontSize: 30,

                      ),
                    ),
                  ),
                ),
                Container(
                  height:250,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:Colors.white30,
                  ),
                  child: TextFormField(
                    controller: TextEditingController(text: beitrag.inhalt),
                    onChanged: (val){
                      beitrag.inhalt = val;
                      Beitragsinhalt=  beitrag.inhalt;
                    },
                    validator: (value){
                      if(value!.isEmpty){return 'Bitte beschreiben sie ihren Wunsch';}
                      return'';
                    },
                    decoration: InputDecoration(
                      hintText: 'inhalt',
                      contentPadding: EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),

                ),
                SizedBox(height:40,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child:Align(
                    alignment: Alignment.topLeft,
                    child: Text("Kategorie",
                      style: TextStyle(
                        fontSize: 30,

                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 520,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:Colors.white30,
                  ),

                    child:Padding(

                    padding:EdgeInsets.all(20) ,
          child: DropdownButton(
                    underline: DropdownButtonHideUnderline(
                        child: Container()),
            dropdownColor: Colors.indigo[300],
             value: selectedValue,
             onChanged: (newValue){
            setState(() {
            selectedValue = newValue as String?;
            });
            },
            items: KategorieListe.map((ktg) {
              return DropdownMenuItem(
                child: new Text(ktg),

                value:ktg,
              );
            }).toList(),

                  ),
                )
                ),],),
            ),

          ),
        ),
      ],
    );
  }








}


