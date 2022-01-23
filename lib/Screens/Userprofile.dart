import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userprofile extends StatelessWidget {
  const Userprofile({Key? key}) : super(key: key);

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
              'Benutzerprofile',
              style:TextStyle(
                fontSize: 25,
              ),

            ),
                SizedBox(width:100,),
      FlatButton(
        color:Colors.indigo[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Userprofile()));
        },
        child: Text('Bearbeiten',
          style:TextStyle(
            fontSize: 20,
            color: Colors.green[300],

          ), ),
      ),],),
          ),
          backgroundColor: Colors.indigo[100],
          body: SafeArea(
            child:Center(
              child:SingleChildScrollView(
               child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    width:170,
                    height:170,
                    decoration: BoxDecoration(
                      shape:BoxShape.circle,
                      image:DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/Background.jpg'),
                      ),
                      border:Border.all(width:4,color: Colors.white),
                      boxShadow: [BoxShadow(spreadRadius:2, blurRadius: 9,)],
                    ),
                 
                  ),

                  SizedBox(height:20),
                  Container(
                    margin: EdgeInsets.all(10),
                    height:640,
                    decoration: BoxDecoration(
                      color: Colors.indigo[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height:50),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: EdgeInsets.all( 20),

                          ),
                        ),
                        SizedBox(height:50),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email-Adresse',
                            contentPadding: EdgeInsets.all( 20),

                          ),

                        ),
                        SizedBox(height:50),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Mobilenummer',
                            contentPadding: EdgeInsets.all( 20),

                          ),
                        ),
                        SizedBox(height:50),
                        TextField( decoration: InputDecoration(
                          hintText: 'Beschreibung',
                          contentPadding: EdgeInsets.all( 20),

                        ),),
                      ],
                    ),
                  ),],)
                ,
              ),
            ),

            ),

          ),

      ],
    );
  }
}



