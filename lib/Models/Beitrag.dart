
import 'package:my_coach/Models/Benutzer.dart';

class Beitrag {
  int? id;
  var titel;
  var inhalt;
  var kategorie;
  var benutzer;


  Beitrag( this.titel, this.inhalt,this.kategorie, this.benutzer);

  /*factory Beitrag.fromJson(Map<String, dynamic> json) => _$BeitragFromJson(json);
  Map<String, dynamic> toJson() => _$BeitragToJson(this);*/
}


