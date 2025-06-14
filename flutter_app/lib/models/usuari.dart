class Usuari {
  String id;

  Usuari({
    required this.id,
  });

  // Constructor per crear un usuari a partir d'un JSON
  Usuari.fromJson(Map<String, dynamic> json) : this(id: json['id']);

// Mètode per convertir l'usuari a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
