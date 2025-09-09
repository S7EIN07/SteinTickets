class Event {
  final int? id;
  final String nome;
  final String? imagePath;
  final int qtdMaxima;
  final int qtdIngressos;
  final int? minimumAge;

  Event({
    this.id,
    required this.nome,
    this.imagePath,
    required this.qtdMaxima,
    required this.qtdIngressos,
    this.minimumAge = 16,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'imagePath': imagePath,
      'qtdMaxima': qtdMaxima,
      "qtdIngressos": qtdIngressos,
      "minimumAge": minimumAge,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      nome: map['nome'],
      imagePath: map['imagePath'],
      qtdMaxima: map['qtdMaxima'],
      qtdIngressos: map['qtdIngressos'] ?? map['qtdMaxima'],
      minimumAge: map['minimumAge'],
    );
  }
}
