import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coach/Screens/Beitraege.dart';
import 'package:my_coach/Screens/Userprofile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:my_coach/Models/Beitrag.dart';
import 'package:http/http.dart' as http;
import 'package:my_coach/Models/Benutzer.dart';

class Mainview extends StatefulWidget {
  const Mainview({Key? key}) : super(key: key);
  @override
  _MainviewState createState() => _MainviewState();
}
class _MainviewState extends State<Mainview> {
  List Beitraegelist=[];

  Future getalleBeitraege()async{
    String url= "http://172.20.37.6:8081/beitraege";
    try {
      final response=await http.get(Uri.parse(url));
      Beitraegelist= jsonDecode(response.body);
      print(Beitraegelist);
    }catch(e){}
  }
  Future deletebeitrag()async{
    String url= "http://172.20.37.6:8081/beitraege";
    try {
      final response=await http.delete(Uri.parse(url));
      Beitraegelist= jsonDecode(response.body);
      print(Beitraegelist);
    }catch(e){}
  }











  @override
  Widget build(BuildContext context) {
    String currentbenutzer= ModalRoute.of(context)!.settings.arguments as String;
    getalleBeitraege();
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
    return ListView.builder(
        itemCount: post.length,
        itemBuilder:(context,index){
          return Beitragcard(Beitraegelist,index);
        });
  }
  Widget Beitragcard(Beitraegelist,index){


    return Card(
      child:Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title:Row(
            children: [
              Flexible(
                child:Container(
                  height: 220,
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                  ),
                  child:Column(
                    children:[

                      Row(
                        children:[
                          Text('Username',
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
                            onPressed: () {  },
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




