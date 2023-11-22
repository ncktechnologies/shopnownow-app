
class WalletResponse {
  String? walletBalance;
  int? loyaltyPoints;

  WalletResponse({
      this.walletBalance,
      this.loyaltyPoints,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
    walletBalance: json["wallet_balance"],
    loyaltyPoints: json["loyalty_points"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_balance": walletBalance,
    "loyalty_points": loyaltyPoints,
  };
}

class TransactionResponse {
  List<Transaction>? transactions;

  TransactionResponse({
     this.transactions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  int? id;
  int? userId;
  String? amount;
  String? type;
  dynamic reference;
  String? status;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  Transaction({
      this.id,
      this.userId,
      this.amount,
      this.type,
      this.reference,
      this.status,
      this.message,
      this.createdAt,
      this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    type: json["type"],
    reference: json["reference"],
    status: json["status"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "type": type,
    "reference": reference,
    "status": status,
    "message": message,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

