import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coach/Screens/Beitrag.dart';
import 'package:my_coach/Screens/Userprofile.dart';

class Mainview extends StatelessWidget {
   Mainview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.indigo[100],
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.indigo[200],
            title: Row(children: <Widget>[
              Text('Beiträge',
            style:TextStyle(
              fontSize: 25,
            ),),
      SizedBox(width: 180,),
              IconButton(onPressed: (){},
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),),
         IconButton(onPressed: () {
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => Beitrag()));

         },
             icon: Icon(
               Icons.add,
               color: Colors.white,
             ),
         ) ,
              IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Userprofile()));
              },
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),),

            ],),
          ),
          body: SafeArea(
            child: getbeitraegelist(),

          ),
        ),
      ],
    );
  }

}


Widget getbeitraegelist(){
  List post=["1","2","3","4","5"];
  return ListView.builder(
    itemCount: post.length,
      itemBuilder:(context,index){
    return Beitragcard();
  });
}
Widget Beitragcard(){
  return Card(
    child:Padding(
      padding: EdgeInsets.all(10),
      child: ListTile(
        title:Row(
          children: [
            Container(
              height: 150,
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white24,
              ),
               child:Column(
                 children:[
                   Text('Username',
                 style:TextStyle(
                   fontSize: 25,
                 ),
               ),
            Row(
              children: [
                TextButton(
                  onPressed: () {  },
                  child: Text("Kommentieren",
                  style: TextStyle(
                    decoration: TextDecoration.underline,

                  ),),
                ),
              ],
            ),
                 ],),
            ),
          ],
        ),
      ),

    ),

  );
}