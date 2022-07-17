import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class Kommentare extends StatefulWidget {
  final id ;
  final benutzer;
  const Kommentare({Key? key, required this.id, required String this.benutzer}) : super(key: key);


  @override
  _KommentareState createState() => _KommentareState(id,benutzer);
}

class _KommentareState extends State<Kommentare> {

  @override
  void initState() {
    setState(() {
     // getkommentrarliste();
      getbenutzer();
      kommentarview();
    });
    super.initState();
  }

  var id;
  var benutzer;
  _KommentareState(this.id, this.benutzer);
  String kommentarinhalt="";
  List Anfragelist=[];
  var beitrid;
  String newvalue="";
  var benutzerid;



  Future getbenutzer() async {
    String url = "http://172.20.37.6:8081/${benutzer}";

    try {
      print(url);
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
  Future getkommentrarliste()async{
    String url = "http://172.20.37.6:8081/kommentars/${beitrid}";
    try{
      onRefresh:true;
      final response = await http.get(Uri.parse(url));

      setState(() {
        onRefresh:true;
        Anfragelist= jsonDecode(response.body);
      });
     // print(Anfragelist);
    }catch(e){

    }
  }

  Future neueskommentar(beitrid, inhalt)async{
 //   getkommentrarliste();
    String url = "http://172.20.37.6:8081/kommentar/add/${beitrid}/${benutzerid}";
    try{
      //http://172.20.37.6:8081/anmelden

      print('zeige url: '+ url);
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type':'application/json;charset=UTF-8',},
          body: json.encode({
            'inhalt':inhalt

          }));

     // getkommentrarliste();

    //  print(response.body);

    } catch(e){
      print('irgenwas ist schief gelaufen. Bitte versuchen sie es nochmal');

    }}


  /*void schreibekommentar(String value){
    setState(() {
      getkommentrarliste();
      kommentarinhalt= value;

      getkommentrarliste();
      onRefresh:true;

    });
  }*/

  Future Kommentarloeschen(id)async{
  String url = "http://172.20.37.6:8081/kommentar/delete/${id}";
    try{
  final response = await http.delete(Uri.parse(url));
  setState(() {
    Anfragelist= jsonDecode(response.body);
  });
  }catch(e){

    }
}




Future aktualisiereKommentar(id) async{
    String url = "http://172.20.37.6:8081/kommentar/aktualisieren/${id}";
  try{
    print(url);
    final response=await http.put(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'inhalt':newvalue,

      }),);

  setState(() {
  Anfragelist= jsonDecode(response.body);
  print(Anfragelist);
  });

  }catch(e){

  }
}




  @override
  Widget build(BuildContext context) {

    this.beitrid= ModalRoute.of(context)!.settings.arguments ;
    print(beitrid);
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
    backgroundColor: Colors.indigo[100],
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.indigo[200],
              title:Row(children: <Widget>[
              Text("Kommentare",
                style:TextStyle(fontSize: 25,),),
            ]),
          ),
        body: SafeArea(
          child:
        Column(
          children: [
           Expanded(child:kommentarview(),),
           TextField(

             onSubmitted: (String komment){
               neueskommentar(beitrid,komment);
               getkommentrarliste();
             //schreibekommentar(komment);

             controller: TextEditingController(text:komment);


           },
           decoration: InputDecoration(
             contentPadding: EdgeInsets.all(20.0),
             focusColor: Colors.grey,
             hintText: "kommentieren",

           ),),

          ],
        ),),
        ), ],


    );

  }
  Widget kommentarview() {
    getkommentrarliste();
    return
      ListView.builder(
        itemCount:Anfragelist.length,
        itemBuilder: (context, index) {
          return kommentarcard(Anfragelist[index]['inhalt'],index);
        });
  }
  Widget kommentarcard(String comment,index){
    
    return Slidable(

        endActionPane: ActionPane(motion: ScrollMotion(),

          children: [
          // if(Anfragelist[index]['benutzerid']== id)
            if(Anfragelist[index]['benutzer']['adresse']== benutzer)
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'löschen',
                onPressed: (BuildContext context) {
                  setState(() {
                    Kommentarloeschen(Anfragelist[index]['id']);
                    Anfragelist.removeAt(index);
                  });
                },
              ),
            if(Anfragelist[index]['benutzer']['adresse']== benutzer)
              SlidableAction(

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
                          setState(() {
                            Anfragelist[index]['inhalt']=value;
                           newvalue=Anfragelist[index]['inhalt'];

                          });

                        },),
                        actions:<Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              setState(() {
                              aktualisiereKommentar(Anfragelist[index]['id']);
                              Navigator.pop(context);
                              });
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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Row(
            children:[
              Flexible(child: Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white24,
                ),
                child:Row(children:[
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/userbild.jpg'),

                  ),
                  SizedBox(width:5),
                  Text(Anfragelist[index]['benutzer']['vorname']+ " "+Anfragelist[index]['benutzer']['nachname'],
                  style:TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width:5),
                  Expanded(child:Text(comment),),

                ],),)
               ),
            ],
          ),
        ),
      ),
        ),  );
  }

}



