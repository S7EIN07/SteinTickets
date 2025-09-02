class Event {
  final int? id;
  final String nome;
  final int qtdMaxima;
  final int? qtdIngressos;

  Event({
    this.id,
    required this.nome,
    required this.qtdMaxima,
    this.qtdIngressos,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'qtdMaxima': qtdMaxima};
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      nome: map['nome'],
      qtdMaxima: map['qtdMaxima'],
      qtdIngressos: map['qtdIngressos'] ?? map['qtdMaxima'],
    );
  }
}
