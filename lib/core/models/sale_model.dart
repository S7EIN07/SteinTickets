class Sale {
  final int? id;
  final String nomeCliente;
  final String dataNascimento;
  final int qtdIngressos;
  final int eventId;

  Sale({
    this.id,
    required this.nomeCliente,
    required this.dataNascimento,
    required this.qtdIngressos,
    required this.eventId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'dataNascimento': dataNascimento,
      'qtdIngressos': qtdIngressos,
      'eventId': eventId,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'],
      nomeCliente: map['nomeCliente'],
      dataNascimento: map['dataNascimento'],
      qtdIngressos: map['qtdIngressos'],
      eventId: map['eventId'],
    );
  }
}
