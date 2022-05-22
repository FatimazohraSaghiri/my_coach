import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_coach/Models/Benutzer.dart';
import 'package:my_coach/Screens/Mainview.dart';
import 'package:my_coach/Screens/registrieren.dart';
import 'package:my_coach/Widgets/Backgroundpicture.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class anmelden extends StatefulWidget {
  const anmelden({Key? key}) : super(key: key);

  @override
  _anmeldenState createState() => _anmeldenState();
}

class _anmeldenState extends State<anmelden> {

  Benutzer benutzer = Benutzer("", "", "", "", "","");
  bool istangemeldet= false;
late String currentuser;


  Future getbenutzer() async {
    String url = "http://172.20.37.6:8081/${benutzer.adresse}";
    // final reponse = await  final response = await http.post(Uri.parse(url),
    try{
      print(url);
      final response = await http.get(Uri.parse(url));
      final dto=jsonDecode(response.body);
      print(dto);
    } catch(err){}
  }

  Future signin() async {
    try {
      String url = "http://172.20.37.6:8081/anmelden";
      print('anmeldung wird durchgeführt');
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode({
            'adresse': benutzer.adresse,
            'passwort': benutzer.passwort,
          }));
        print(response.body);
        Fluttertoast.showToast(msg: 'Anmeldung Erfolgreich');
        Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(arguments: benutzer.adresse),
              builder: (context) => Mainview(),));
      } catch (err) {
      Fluttertoast.showToast(
          msg: 'Email oder Passwort falsch bitte versuchen Sie nochmal',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Container(
                  child: Column(
                    children: [
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
                            currentuser= benutzer.adresse;
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
                              return 'password is required';}
                            return '';
                          },
                          decoration: InputDecoration(
                            hintText: 'passwort',
                            contentPadding: EdgeInsets.all(20),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          textInputAction: TextInputAction.done,),),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: BoxDecoration(
                                color: Colors.indigo[600],
                                borderRadius: BorderRadius.circular(20)),
                            child: FlatButton(
                              onPressed: () {


                                print('angemeldet');
                                signin();
                               getbenutzer();
                                },
                              child: Text('Anmelden'),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.indigo[600],
                                borderRadius: BorderRadius.circular(20)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => registrieren()
                                  ),
                                );
                                setState(() {
                                  loading:true;
                                });
                              },
                              child: Text('Registrieren'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
