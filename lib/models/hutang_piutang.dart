class HutangPiutang {
  final int id;
  final String person;
  final int amount;
  final String status;

  HutangPiutang({
    required this.id,
    required this.person,
    required this.amount,
    required this.status,
  });

  factory HutangPiutang.fromJson(Map<String, dynamic> json) {
    return HutangPiutang(
      id: json['id'],
      person: json['person'],
      amount: json['amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person': person,
      'amount': amount,
      'status': status,
    };
  }
}
