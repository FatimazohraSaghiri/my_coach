import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_coach/Screens/Beitraege.dart';
import 'package:my_coach/Screens/Kommentare.dart';
import 'package:my_coach/Screens/Userprofile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:my_coach/Models/Beitrag.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Benutzer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Mainview extends StatefulWidget {
  const Mainview({Key? key}) : super(key: key);
  @override
  _MainviewState createState() => _MainviewState();
}
class _MainviewState extends State<Mainview> {
  List Beitraegelist=[];
  String currentbenutzer="";
  String beitragsinhalt="";

  @override
  void initState() {
    setState(() {
      onRefresh:getbeitraegelist();
      getalleBeitraege();
    });
    super.initState();
  }

  // Zeigt alle verfügbaren Beiträge in der Datenbank
  Future getalleBeitraege()async{

    String url= "http://172.20.37.6:8081/beitraege";
    try {
      final response=await http.get(Uri.parse(url));
      setState(() {
        Beitraegelist.add(jsonDecode(response.body));
      });
      print(Beitraegelist);
    }catch(e){}
  }


  // zum Löschen eines Beitrag
  Future loescheBeitrag(beitrid)async{
    String url= "http://172.20.37.6:8081/beitrag/${beitrid}";
    try {
      print(url);
      final response=await http.delete(Uri.parse(url),
      );
      Beitraegelist= jsonDecode(response.body);
      print(Beitraegelist);
    }catch(e){}
  }

  // zum Aktualisieren des Beitrags
  Future aktualisiereBeitrag(updid)async{
    String url= "http://172.20.37.6:8081/beitrag/aktualisiren/${updid}";
    try {
      print(url);
      final response=await http.put(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(<String, String>{
          'inhalt':beitragsinhalt,

        }),);
      Beitraegelist= jsonDecode(response.body);
      print(Beitraegelist);
    }catch(e){}
  }




  // Ui design der Hauptübersicht
  @override
  Widget build(BuildContext context) {

    currentbenutzer= ModalRoute.of(context)!.settings.arguments as String;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.indigo[100],
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.indigo[200],
            title: Row(children: <Widget>[
              Text('Beiträge', style:TextStyle(fontSize: 25,),),
              SizedBox(width: 180,),
              IconButton(onPressed: (){},
                icon: Icon(Icons.filter_alt,
                  color: Colors.white,
                ),),
              IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(
                settings: RouteSettings(arguments:currentbenutzer),
                        builder: (context) => Beitraege()));

              },
                icon: Icon(Icons.add, color: Colors.white,),) ,
              IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Userprofile()));
              },
                icon: Icon(Icons.account_circle, color: Colors.white,),),
            ],),
          ),
          body: SafeArea(

            child: getbeitraegelist(),

          ),
        ),
      ],
    );
  }
  Widget getbeitraegelist(){

    List post= Beitraegelist;
    onRefresh:getalleBeitraege();
    return ListView.builder(

        itemCount: post.length,
        itemBuilder:(context,index){
          return Beitragcard(Beitraegelist,index);
        });
  }
  Widget Beitragcard(Beitraegelist,index){


    return Slidable(

   endActionPane: ActionPane(motion: ScrollMotion(),

   children: [

     if(Beitraegelist[index]['benutzer']['adresse']== currentbenutzer)
     SlidableAction(
       // An action can be bigger than the others.
       flex: 2,
       backgroundColor: Colors.red,
       foregroundColor: Colors.white,
       icon: Icons.delete,
       label: 'löschen',
       onPressed: (BuildContext context) {
         setState(() {
           loescheBeitrag(Beitraegelist[index]['id']);
           Beitraegelist.removeAt(index);
         });
         },
     ),
     if(Beitraegelist[index]['benutzer']['adresse']== currentbenutzer)
     SlidableAction(
       // An action can be bigger than the others.
       flex: 2,
       backgroundColor: Colors.green,
       foregroundColor: Colors.white,
       icon: Icons.edit,
       label: 'bearbeiten',
       onPressed: (BuildContext context) {

         setState(() {
           showDialog(context: context, builder: (context){
             return AlertDialog(
               title: Text('AlertDialog Title'),

               content: TextField(onChanged: (value){
      setState(() {Beitraegelist[index]['inhalt']=value;
    beitragsinhalt=Beitraegelist[index]['inhalt'];});

               },),
               actions:<Widget>[
             FlatButton(
             child: Text("OK"),
             onPressed: () {
               aktualisiereBeitrag(Beitraegelist[index]['id']);
               Navigator.pop(context);
             },
             ),
                 FlatButton(
                   child: Text("abbrechen"),
                   onPressed: () {
                     Navigator.pop(context);
                   },
                 ),
               ],

             );
           });


         });
       },
     ),
   ],),
      child:Card(

        child: ListTile(
          title:Row(
            children: [
              Flexible(
                child:Container(
                  height: MediaQuery.of(context).size.height/5,
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                  ),
                  child:Column(
                    children:[

                      Row(
                        children:[
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage('assets/userbild.jpg'),

                          ),
                          SizedBox(width:10,),
                          Text(Beitraegelist[index]['benutzer']['vorname'],
                            style:TextStyle(
                              fontSize: 25,),),
                          SizedBox(width:5,),
                          Text(Beitraegelist[index]['benutzer']['nachname'],
                            style:TextStyle(
                              fontSize: 25,),),],),
                      SizedBox(height:10,),
                      Row(children:[
                        Expanded(child: Text(Beitraegelist[index]['inhalt'],
                          style:TextStyle(fontSize: 19,),)),],),
                      SizedBox(height:10,),
                      Row(
                        children: [
                          SmoothStarRating(
                            starCount:5 ,
                            rating:2.5,
                            color:Colors.deepPurple,
                          ),
                          SizedBox(width: 130),
                          TextButton(
                            onPressed: () {  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  settings: RouteSettings(arguments: Beitraegelist[index]['id']),
                                    builder: (context) => Kommentare())); },
                            child: Text("Kommentieren",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                                color: Colors.indigo,
                              ),),
                          ),
                        ],
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }

}




