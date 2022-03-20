


class Benutzer {
   int? id;
  String nachname;
  String vorname;
  String passwort;
  String adresse;
  String beschreibung;

  Benutzer(
      this.vorname, this.nachname, this.adresse, this.passwort, this.beschreibung);

 /*  factory Benutzer.fromJson(Map<String, dynamic> json) => _$BenutzerFromJson(json);
   Map<String, dynamic> toJson() => _$BenutzerToJson(this);*/
}


