class Usuaris {
  String _dni;
  String nom;
  String cognoms;
  String email;
  int edat;

  Usuaris({
    required dni,
    required this.nom,
    required this.cognoms,
    required this.email,
    required this.edat,
  }) : _dni = dni;

  Usuaris.fromJson(Map<String, dynamic> json)
      : this(
            email: json['email'],
            dni: json['dni'],
            nom: json['nom'],
            cognoms: json['cognoms'],
            edat: json['edat']);

  Map<String, dynamic> toJson() => {
        'dni': _dni,
        'nom': nom,
        'cognoms': cognoms,
        'email': email,
        'edat': edat,
      };

//per poder consulatr-lo
  String get dni => _dni;
}
