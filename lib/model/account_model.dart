import 'dart:math';

class AccountHistoryType {
  static const debit = "debit";
  static const entrance = "entrance";
}

class AccountHistory {
  final String type;
  final String date;
  final double value;
  final String message;

  AccountHistory({
    required this.type,
    required this.date,
    required this.value,
    required this.message,
  });

  factory AccountHistory.fromJson(Map<String, dynamic> json) {
    return AccountHistory(
      type: json['type'],
      date: json['date'],
      value: json['value'] + .0,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
        "value": value,
        "message": message,
      };
}

class Account {
  String? id;
  final String type;
  final String number;
  final String agency;
  final String bank;
  final double balance;
  final List<dynamic> history;

  Account({
    this.id,
    this.type = "corrente",
    this.agency = "0321",
    this.balance = 0.0,
    this.bank = "0032",
    this.history = const [],
    required this.number,
  });

  static String get genNumber => Account.generateAccountNumber();

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "number": number,
        "agency": agency,
        "bank": bank,
        "balance": balance,
        "history": history,
      };

  factory Account.fromJson(Map<String, dynamic>? json) => Account(
        id: json!['id'],
        type: json['type'],
        number: json['number'],
        agency: json['agency'],
        bank: json['bank'],
        history: json['history'] ?? [],
        balance: json.containsKey('balance') ? json['balance'] + .0 : null,
      );

  static String generateAccountNumber() {
    return "${Random().nextInt(10000000)}-${Random().nextInt(10)}";
  }
}
