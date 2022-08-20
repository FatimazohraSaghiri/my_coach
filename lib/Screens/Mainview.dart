import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_coach/Screens/Beitraege.dart';
import 'package:my_coach/Screens/Kommentare.dart';
import 'package:my_coach/Screens/Userprofile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Mainview extends StatefulWidget {
  const Mainview({Key? key}) : super(key: key);
  @override
  _MainviewState createState() => _MainviewState();
}
class _MainviewState extends State<Mainview> {
  List Beitraegelist=[];
  String currentbenutzer="";
  String beitragsinhalt="";
  var anzahlStr= "anzahlStr";
  var rating=2.0;
  String gesuchtekategorie="";


  @override
  void initState() {
    setState(() {
      getbeitraegelist();
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
        Beitraegelist = jsonDecode(response.body);
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
      setState(() {
        Beitraegelist = jsonDecode(response.body);
      });
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
      setState(() {
        Beitraegelist = jsonDecode(response.body);
      });
      print(Beitraegelist);
    }catch(e){}
  }




Future beitragBewerten(beitrid,benutzerid)async{
  String url= "http://172.20.37.6:8081/bewertung/${beitrid}/${benutzerid}";
  try {
    print(anzahlStr);
    print(url);
    final response=await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    },
      body: jsonEncode(
      {
        "anzahlStr": rating
      },),);
    setState(() {
      print(rating);
    });
  }catch(e){}
}


  //Zeige Bewertung an
 Future getBeitragsbewertung(id) async{
    String url= "http://172.20.37.6:8081/bewerten/${id}";
    try{
      final response=await http.get(Uri.parse(url));
      setState(() {
        rating = jsonDecode(response.body);

      });
      print(rating);
    }catch(e){}
  }



  Future sucheBeitrag(kategorie) async{
    String url= "http://172.20.37.6:8081/beitraegeList/${kategorie}";
    try {
      final response=await http.get(Uri.parse(url));
      setState(() {
        Beitraegelist = jsonDecode(response.body);
      });
      print(Beitraegelist);
    }catch(e){}
  }


  // Ui design der Hauptübersicht
  @override
  Widget build(BuildContext context) {
    currentbenutzer= ModalRoute.of(context)!.settings.arguments as String;
    return Stack(
      children: [
     Scaffold(backgroundColor: Colors.indigo[100],
          appBar: AppBar(toolbarHeight: 80,
            backgroundColor: Colors.indigo[200],
            title: Row(children: <Widget>[
              Text('Beiträge', style:TextStyle(fontSize: 22,),),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              Flexible(child:Container(
                decoration: BoxDecoration(color: Colors.white24,
                    borderRadius: BorderRadius.circular(20)),
              child:TextFormField(
                //textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                  hintText: 'kategorie',),
                onChanged: (val) {
                  gesuchtekategorie = val.toUpperCase();
                  sucheBeitrag(gesuchtekategorie);},),),  ),
              IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(
                settings: RouteSettings(arguments:currentbenutzer),
                        builder: (context) => Beitraege()));},
                icon: Icon(Icons.add, color: Colors.white,),) ,
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(settings: RouteSettings(),
                        builder: (context) => Userprofile(benutzer:currentbenutzer)));},
                icon: Icon(Icons.account_circle, color: Colors.white,),),],),),
          body: SafeArea(
            child: getbeitraegelist(),

          ),)],
    );
  }



  Widget getbeitraegelist(){
    List post= Beitraegelist;
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
       flex: 2,
       backgroundColor: Colors.red,
       foregroundColor: Colors.white,
       icon: Icons.delete,
       label: 'löschen',
       onPressed: (BuildContext context) {
         setState(() {
           loescheBeitrag(Beitraegelist[index]['id']);
           Beitraegelist.removeAt(index);});},),
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

    child: new InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              settings: RouteSettings(),
              builder: (context) => Userprofile(benutzer:Beitraegelist[index]['benutzer']['adresse'])));

    print("tapped");
    },
    child: ListTile(
          title:Row(
            children: [
              Flexible(child:Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white24,),
                  child: Column(children:[
                      Row(children:[
                          if(Beitraegelist[index]['benutzer']['professionEnum']=='TRAINER')
                            CircleAvatar(backgroundColor: Colors.purpleAccent, radius: 33,
                              child: CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/userbild.jpg'),),),
                          if(Beitraegelist[index]['benutzer']['professionEnum']=='SPORTLER')
                            CircleAvatar(backgroundColor: Colors.deepPurpleAccent, radius: 33,
                              child: CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/userbild.jpg'),),),
                          SizedBox(width:10,),
                          Text(Beitraegelist[index]['benutzer']['vorname'],
                            style:TextStyle(fontSize: 25,),),
                          SizedBox(width:5,),
                          Text(Beitraegelist[index]['benutzer']['nachname'],
                            style:TextStyle(fontSize: 25,),),],),
                      SizedBox(height:10,),
                      Row(children:[
                        Expanded(child: Text(Beitraegelist[index]['inhalt'],
                          style:TextStyle(fontSize: 19,),)),],),
                      SizedBox(height:10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child:Row(children: [
                         Container(
                         child: SmoothStarRating(starCount:5 , rating: rating,
                            color:Colors.deepPurple,
                       onRated: (value) {
                         setState(() {
                           getBeitragsbewertung(Beitraegelist[index]['id']);

                           beitragBewerten(Beitraegelist[index]['id'], Beitraegelist[index]['benutzer']['id']);
                         rating = value;
                        // anzahlStr=value.toString();
                         });}
                          ),),
                          SizedBox(width: MediaQuery.of(context).size.width*0.10),
                          TextButton(onPressed: () {
                              print(Beitraegelist[index]['id']);
                              Navigator.push(context,
                                MaterialPageRoute(
                                  settings: RouteSettings(arguments: Beitraegelist[index]['id']),
                                    builder: (context) => Kommentare(id:Beitraegelist[index]['benutzer']['id'],benutzer:this.currentbenutzer))); },
                            child: Text("Kommentieren",
                              style: TextStyle(decoration: TextDecoration.underline,
                                fontSize: 20, color: Colors.indigo,),),),],
                      ),),
                    ],),
                ),
              ),
            ],
          ),
          ),

      ),
      ),
    );
  }

}




