

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coach/Models/Beitragsmodel.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Beitragsmodel.dart';
import 'package:my_coach/Models/Benutzer.dart';

class Beitrag extends StatefulWidget {
  const Beitrag({Key? key}) : super(key: key);

  @override
  _BeitragState createState() => _BeitragState();
}
@override
class _BeitragState extends State<Beitrag> {
  Benutzer benutzer = Benutzer("", "", "", "", "");

  Beitragsmodel beitrag= Beitragsmodel("","","");

  Future neuesBeitrag()async{
    String url = "http://172.20.37.6:8081/beitrag/add/{benutzer.adresse}";
    print('neues Beitrag ');
    final response = await http.post(Uri.parse(url),
    headers: {'Content-Type':'application/json;charset=UTF-8',},
        body: json.encode({
          'title':beitrag.title,
          'Inhalt':beitrag.inhalt,
          'kategorie':beitrag.kategorie,
        }));
    print('adding');
    if (response.statusCode == 200) {
      print(response.body);
    } else
      print('succesful added?');
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: TextEditingController(text: beitrag.title),
                    onChanged: (val){
                      beitrag.title = val;
                    },
                    validator: (value){
                      if(value!.isEmpty){return 'Bitte beschreiben sie ihren Wunsch';}
                      return'';
                    },
                    decoration: InputDecoration(
                      hintText: 'Title',
                      contentPadding: EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),),
                SizedBox(height:60,),
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
                    },
                    validator: (value){
                      if(value!.isEmpty){return 'Bitte beschreiben sie ihren Wunsch';}
                      return'';
                    },
                    decoration: InputDecoration(
                      hintText: 'Inhalt',
                      contentPadding: EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),

                ),
                SizedBox(height:60,),
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
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:Colors.white30,
                  ),

                  child: TextFormField(
           controller: TextEditingController(text: beitrag.kategorie),
            onChanged: (val){
            beitrag.kategorie = val;
                     },
               validator: (value){
              if(value!.isEmpty){return 'Bitte Kategorie eingeben';}
               return'';
               },
                    decoration: InputDecoration(
                      hintText: 'Kategorie',
                      contentPadding: EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                )],),
            ),

          ),
        ),
      ],
    );
  }
}


