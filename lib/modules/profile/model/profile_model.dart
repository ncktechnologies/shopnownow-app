
class GetProfile {
  User? user;

  GetProfile({
     this.user,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user!.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  dynamic emailVerifiedAt;
  String? wallet;
  int? loyaltyPoints;
  int? verified;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
      this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.wallet,
      this.loyaltyPoints,
      this.verified,
      this.createdAt,
      this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    wallet: json["wallet"],
    loyaltyPoints: json["loyalty_points"],
    verified: json["verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "wallet": wallet,
    "loyalty_points": loyaltyPoints,
    "verified": verified,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
