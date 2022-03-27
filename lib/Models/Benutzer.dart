

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Benutzer {
  int? id;
  String nachname;
  String vorname;
  String passwort;
  String adresse;
  var professionEnum;
  String beschreibung;

  Benutzer(this.vorname, this.nachname, this.adresse, this.passwort,this.professionEnum, this.beschreibung);

}

