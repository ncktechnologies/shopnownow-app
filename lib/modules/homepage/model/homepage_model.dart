import 'dart:convert';

List<GetCategories> getCategoriesFromJson(String str) =>
    List<GetCategories>.from(
        json.decode(str).map((x) => GetCategories.fromJson(x)));

String getCategoriesToJson(List<GetCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  Band? band;

  GetCategories(
      {this.id,
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
      this.band});

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
        band: Band.fromJson(json["band"]),
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
        "band": band!.toJson(),
      };
}

class Band {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? minimum;
  String? bulkDiscountPercentage;
  String? bulkDiscountAmount;
  String? generalDiscount;
  int? discountEnabled;

  Band({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.minimum,
    this.bulkDiscountPercentage,
    this.bulkDiscountAmount,
    this.generalDiscount,
    this.discountEnabled,
  });

  factory Band.fromJson(Map<String, dynamic> json) => Band(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        minimum: json["minimum"],
        bulkDiscountPercentage: json["bulk_discount_percentage"],
        bulkDiscountAmount: json["bulk_discount_amount"],
        generalDiscount: json["general_discount"],
        discountEnabled: json["discount_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "minimum": minimum,
        "bulk_discount_percentage": bulkDiscountPercentage,
        "bulk_discount_amount": bulkDiscountAmount,
        "general_discount": generalDiscount,
        "discount_enabled": discountEnabled,
      };

  @override
  String toString() {
    return 'Band{id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, minimum: $minimum, bulkDiscountPercentage: $bulkDiscountPercentage, bulkDiscountAmount: $bulkDiscountAmount, generalDiscount: $generalDiscount, discountEnabled: $discountEnabled}';
  }
}

class GetProductsBySearch {
  String? message;
  List<Product>? products;

  GetProductsBySearch({
    this.message,
    this.products,
  });

  factory GetProductsBySearch.fromJson(Map<String, dynamic> json) =>
      GetProductsBySearch(
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
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
  int? quantity;
  Band? band;
  Category? category;

  Product(
      {this.id,
      this.name,
      this.thumbnailUrl,
      this.price,
      this.unitOfMeasurement,
      this.availability,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.quantity,
      this.band,
      this.category});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        thumbnailUrl: json["thumbnail_url"],
        price: json["price"],
        unitOfMeasurement: json["unit_of_measurement"],
        availability: json["availability"],
        categoryId: json["category_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        band: json["band"] == null ? null : Band.fromJson(json["band"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
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
        "band": band!.toJson(),
        "category": category!.toJson(),
      };

  @override
  String toString() {
    return 'Product{id: $id, quantity:$quantity, name: $name, thumbnailUrl: $thumbnailUrl, price: $price, unitOfMeasurement: $unitOfMeasurement, availability: $availability, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class Category {
  String tax;

  Category({
    required this.tax,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "tax": tax,
      };
}

class AddProductRequest {
  List<ProductRequest> products;

  AddProductRequest({
    required this.products,
  });

  factory AddProductRequest.fromJson(Map<String, dynamic> json) =>
      AddProductRequest(
        products: List<ProductRequest>.from(
            json["products"].map((x) => ProductRequest.fromJson(x))),
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

class GetLocation {
  List<Location>? locations;

  GetLocation({
    this.locations,
  });

  factory GetLocation.fromJson(Map<String, dynamic> json) => GetLocation(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Location {
  int? id;
  int? bandId;
  String? location;
  String? price;
  int? hidden;
  DateTime? createdAt;
  DateTime? updatedAt;

  Location({
    this.id,
    this.bandId,
    this.location,
    this.price,
    this.hidden,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        bandId: json["band_id"],
        location: json["location"],
        price: json["price"],
        hidden: json["hidden"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "band_id": bandId,
        "location": location,
        "price": price,
        "hidden": hidden,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class GetTimeSlot {
  List<TimeSlot>? timeSlots;

  GetTimeSlot({
    this.timeSlots,
  });

  factory GetTimeSlot.fromJson(Map<String, dynamic> json) => GetTimeSlot(
        timeSlots: List<TimeSlot>.from(
            json["timeSlots"].map((x) => TimeSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timeSlots": List<dynamic>.from(timeSlots!.map((x) => x.toJson())),
      };
}

class TimeSlot {
  int? id;
  String? deliveryTime;
  int? isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;

  TimeSlot({
    this.id,
    this.deliveryTime,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        id: json["id"],
        deliveryTime: json["start_time"] + " - " + json["end_time"],
        isAvailable: json["is_available"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_time": deliveryTime,
        "is_available": isAvailable,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class CreateOrderRequest {
  int? userId;
  List<ProductRequest> products;
  int price;
  int tax;
  String status;
  String deliveryInfo;
  String paymentType;
  String recipientName;
  String recipientPhone;
  String recipientEmail;
  int deliveryFee;
  String deliveryTimeSlot;

  CreateOrderRequest({
    this.userId,
    required this.products,
    required this.price,
    required this.tax,
    required this.status,
    required this.deliveryInfo,
    required this.paymentType,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientEmail,
    required this.deliveryFee,
    required this.deliveryTimeSlot,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequest(
        userId: json["user_id"],
        products: List<ProductRequest>.from(
            json["products"].map((x) => ProductRequest.fromJson(x))),
        price: json["price"],
        tax: json["tax"],
        status: json["status"],
        deliveryInfo: json["delivery_info"],
        paymentType: json["payment_type"],
        recipientName: json["recipient_name"],
        recipientPhone: json["recipient_phone"],
        recipientEmail: json["recipient_email"],
        deliveryFee: json["delivery_fee"],
        deliveryTimeSlot: json["delivery_time_slot"],
      );

  Map<String, dynamic> toJson() => {
        if (userId != 0) 'user_id': userId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "price": price,
        "tax": tax,
        "status": status,
        "delivery_info": deliveryInfo,
        "payment_type": paymentType,
        "recipient_name": recipientName,
        "recipient_phone": recipientPhone,
        "recipient_email": recipientEmail,
        "delivery_fee": deliveryFee,
        "delivery_time_slot": deliveryTimeSlot,
      };
}

class ProcessPaymentRequest {
  int? userId;
  String amount;
  String status;
  int? orderId;
  String reference;
  String paymentType;
  String paymentGateway;
  String paymentGatewayReference;

  ProcessPaymentRequest({
    this.userId,
    required this.amount,
    required this.status,
    required this.orderId,
    required this.reference,
    required this.paymentType,
    required this.paymentGateway,
    required this.paymentGatewayReference,
  });

  factory ProcessPaymentRequest.fromJson(Map<String, dynamic> json) =>
      ProcessPaymentRequest(
        userId: json["user_id"],
        amount: json["amount"],
        status: json["status"],
        orderId: json["order_id"].toInt(),
        reference: json["reference"],
        paymentType: json["payment_type"],
        paymentGateway: json["payment_gateway"],
        paymentGatewayReference: json["payment_gateway_reference"],
      );

  Map<String, dynamic> toJson() => {
        if (userId != null) "user_id": userId.toString(),
        "amount": amount,
        "status": status,
        "order_id": orderId.toString(),
        "reference": reference,
        "payment_type": paymentType,
        "payment_gateway": paymentGateway,
        "payment_gateway_reference": paymentGatewayReference,
      };
}

List<GetQuickGuide> getQuickGuideFromJson(String str) =>
    List<GetQuickGuide>.from(
        json.decode(str).map((x) => GetQuickGuide.fromJson(x)));

class GetQuickGuide {
  int? id;
  String? title;
  String? body;
  String? imagePath;
  int? isHidden;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetQuickGuide({
    this.id,
    this.title,
    this.body,
    this.imagePath,
    this.isHidden,
    this.createdAt,
    this.updatedAt,
  });

  factory GetQuickGuide.fromJson(Map<String, dynamic> json) => GetQuickGuide(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        imagePath: json["image_path"],
        isHidden: json["is_hidden"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "image_path": imagePath,
        "is_hidden": isHidden,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
