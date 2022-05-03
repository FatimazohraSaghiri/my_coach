import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coach/Models/Benutzer.dart';
import 'package:my_coach/Screens/anmelden.dart';
import 'package:my_coach/Widgets/Backgroundpicture.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';

class registrieren extends StatefulWidget {
  const registrieren({Key? key}) : super(key: key);

  @override
  _registrierenState createState() => _registrierenState();
}

class _registrierenState extends State<registrieren> {
  List professionlist=[];
  /*  List<DropdownMenuItem<String>> menuItems=[
      DropdownMenuItem(child: Text('Trainer'),value:'Trainer',),
      DropdownMenuItem(child: Text('Sportler'),value:'Sportler',),
    ];*/

  String selectedValue= "TRAINER";

  Benutzer benutzer = Benutzer("", "", "", "", "","");
  Future signup() async {
    String url = "http://172.20.37.6:8081/registerbenutzer";
    try{
    print('Step1 ');
    final signinres = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'vorname': benutzer.vorname,
          'nachname': benutzer.nachname,
          'adresse': benutzer.adresse,
          'passwort': benutzer.passwort,
          'professionEnum': selectedValue,
          'beschreibung': benutzer.beschreibung

        }));

    print('Step2');

      return json.decode(signinres.body);
    } catch(e){

    }

  }


  Future getProfessionsliste()async {
    String url = "http://172.20.37.6:8081/profession";
    try {
      final response = await http.get(Uri.parse(url));
        List data;
        data=json.decode(response.body);
        print(data);

        setState(() {
          professionlist = data;
          print(professionlist);
        });

        debugPrint(professionlist.toString());
      }
     catch (err) {}
  }

  @override
  void initState(){
    super.initState();
    getProfessionsliste();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundWidget(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
   child: SingleChildScrollView(
    reverse:true,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              //Vorname input
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: TextEditingController(text: benutzer.vorname),
                  onChanged: (val) {
                    benutzer.vorname = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'vorname is required';
                    }
                    return '';
                  },
                  decoration: InputDecoration(
                    hintText: 'vorname',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                //Nachname Input
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: TextEditingController(text: benutzer.nachname),
                  onChanged: (val) {
                    benutzer.nachname = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'nachname is required';
                    }
                    return '';
                  },
                  decoration: InputDecoration(
                    hintText: 'nachname',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
              ),
              // Email Adresse Input
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: TextEditingController(text: benutzer.adresse),
                  onChanged: (val) {
                    benutzer.adresse = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email Address is required';
                    }
                    return '';
                  },
                  decoration: InputDecoration(
                    hintText: 'Adresse',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
              ),
              // Passwort input
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: TextEditingController(text: benutzer.passwort),
                  onChanged: (val) {
                    benutzer.passwort = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'paaswort is required';
                    }
                    return '';
                  },
                  decoration: InputDecoration(
                    hintText: 'passswort',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
              ),

              //   Textinputwidget(inputAction: TextInputAction.next, hint: 'Email', inputType: TextInputType.emailAddress,),
              //Geburtsdatuminput
              //Textinputwidget(hint: 'Geburtsdatum', inputType: TextInputType.datetime, inputAction: TextInputAction.done),

              // Dorpdowninput um die Proffesion zu wählen
              /*  Container(
                height:70,
                width: 500,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(color:Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
               child:Padding(
                 padding:EdgeInsets.all(20) ,
                 child: DropdownButton(
                     underline: DropdownButtonHideUnderline(child: Container()),
                     dropdownColor: Colors.indigo[300],
                     style: TextStyle( fontSize:15,color: Colors.black54),
                     value: selectedValue,
                     onChanged: (String? newValue){
                       setState(() {
                         selectedValue = newValue!;
                       });
                     },
                     items: professionlist
                 ),
               ),

              ),*/
              Container(
                  height: 70,
                  width: 500,
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  decoration: BoxDecoration(
                    color:Colors.indigo[300],
                   borderRadius: BorderRadius.circular(20)),


                  child:Padding(

                    padding:EdgeInsets.all(20) ,
                    child: DropdownButton(
                      hint: Text("professionEnum"),
                      underline: DropdownButtonHideUnderline(

                          child: Container()),
                      dropdownColor: Colors.indigo[300],
                      value: selectedValue,
                      onChanged: (newValue){
                        setState(() {
                          selectedValue = (newValue as String?)!;
                          benutzer.professionEnum= selectedValue;
                        });
                      },
                      items: professionlist.map((profession) {
                        return DropdownMenuItem(

                          child: new Text(profession),

                          value:profession,
                        );
                      }).toList(),

                    ),
                  ),),
              Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: TextEditingController(text: benutzer.beschreibung),
                  onChanged: (val) {
                    benutzer.beschreibung = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'beschreibung is required';
                    }
                    return '';
                  },
                  decoration: InputDecoration(
                    hintText: 'beschreibung',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // Registrier Button
              Container(
                width: 200,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                    color: Colors.indigo[600],
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    print('ckeck!!');
                    signup();
                    if(signup()!=null){
                       Fluttertoast.showToast(msg: 'Registrierung Erfolgreich');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => anmelden()));
                    }
                  },
                  child: Text('Registrieren'),
                ),
              )
            ],
          ),
        ),
        ), ),
    ]);
  }
}
