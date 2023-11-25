
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';

class GetSavedList {
  String? message;
  List<ShoppingList>? shoppingLists;

  GetSavedList({
      this.message,
      this.shoppingLists,
  });

  factory GetSavedList.fromJson(Map<String, dynamic> json) => GetSavedList(
    message: json["message"],
    shoppingLists: List<ShoppingList>.from(json["shopping lists"].map((x) => ShoppingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "shopping lists": List<dynamic>.from(shoppingLists!.map((x) => x.toJson())),
  };
}

class ShoppingList {
  int? id;
  List<Product>? productIds;
  String? quantities;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ShoppingList({
      this.id,
      this.productIds,
      this.quantities,
      this.userId,
      this.createdAt,
      this.updatedAt,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
    id: json["id"],
    productIds: List<Product>.from(json["product_ids"].map((x) => Product.fromJson(x))),
    quantities: json["quantities"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_ids": List<dynamic>.from(productIds!.map((x) => x.toJson())),
    "quantities": quantities,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}