
import 'dart:convert';

List<GetCategories> getCategoriesFromJson(String str) => List<GetCategories>.from(json.decode(str).map((x) => GetCategories.fromJson(x)));

String getCategoriesToJson(List<GetCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCategories {
  int? id;
  String? name;
  String? tax;
  int? deliveryOption;
  int? discountOption;
  String? discountType;
  String? discountValue;
  String? thumbnail;
  int? hidden;
  int? bandId;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetCategories({
      this.id,
      this.name,
      this.tax,
      this.deliveryOption,
      this.discountOption,
      this.discountType,
      this.discountValue,
      this.thumbnail,
      this.hidden,
      this.bandId,
      this.createdAt,
      this.updatedAt,
  });

  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
    id: json["id"],
    name: json["name"],
    tax: json["tax"],
    deliveryOption: json["delivery_option"],
    discountOption: json["discount_option"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    thumbnail: json["thumbnail"],
    hidden: json["hidden"],
    bandId: json["band_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tax": tax,
    "delivery_option": deliveryOption,
    "discount_option": discountOption,
    "discount_type": discountType,
    "discount_value": discountValue,
    "thumbnail": thumbnail,
    "hidden": hidden,
    "band_id": bandId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}


class GetProductsBySearch {
  String? message;
  List<Product>? products;

  GetProductsBySearch({
      this.message,
      this.products,
  });

  factory GetProductsBySearch.fromJson(Map<String, dynamic> json) => GetProductsBySearch(
    message: json["message"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  String? name;
  String? thumbnailUrl;
  String? price;
  String? unitOfMeasurement;
  int? availability;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
      this.id,
      this.name,
      this.thumbnailUrl,
      this.price,
      this.unitOfMeasurement,
      this.availability,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    thumbnailUrl: json["thumbnail_url"],
    price: json["price"],
    unitOfMeasurement: json["unit_of_measurement"],
    availability: json["availability"],
    categoryId: json["category_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_url": thumbnailUrl,
    "price": price,
    "unit_of_measurement": unitOfMeasurement,
    "availability": availability,
    "category_id": categoryId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class AddProductRequest {
  List<ProductRequest> products;

  AddProductRequest({
    required this.products,
  });

  factory AddProductRequest.fromJson(Map<String, dynamic> json) => AddProductRequest(
    products: List<ProductRequest>.from(json["products"].map((x) => ProductRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductRequest {
  int id;
  int quantity;

  ProductRequest({
    required this.id,
    required this.quantity,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    id: json["id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
  };
}


