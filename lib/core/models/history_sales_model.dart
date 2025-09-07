class History {
  final int? id;
  final int saleId;
  final String timestamp;

  History({this.id, required this.saleId, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {'id': id, 'saleId': saleId, 'timestamp': timestamp};
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      saleId: map['saleId'],
      timestamp: map['timestamp'],
    );
  }
}
