
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';

class OrderResponse {
  String? message;
  List<Order>? orders;

  OrderResponse({
      this.message,
      this.orders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    message: json["message"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  int? id;
  String? productIds;
  String? quantities;
  String? deliveryInfo;
  String? deliveryFee;
  String? deliveryTimeSlot;
  String? price;
  String? tax;
  String? orderId;
  String? paymentType;
  String? recipientName;
  String? recipientPhone;
  String? recipientEmail;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  List<Product>? products;

  Order({
      this.id,
      this.productIds,
      this.quantities,
      this.deliveryInfo,
      this.deliveryFee,
      this.deliveryTimeSlot,
      this.price,
      this.tax,
      this.orderId,
      this.paymentType,
      this.recipientName,
      this.recipientPhone,
      this.recipientEmail,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    productIds: json["product_ids"],
    quantities: json["quantities"],
    deliveryInfo: json["delivery_info"],
    deliveryFee: json["delivery_fee"],
    deliveryTimeSlot: json["delivery_time_slot"],
    price: json["price"],
    tax: json["tax"],
    orderId: json["order_id"],
    paymentType: json["payment_type"],
    recipientName: json["recipient_name"],
    recipientPhone: json["recipient_phone"],
    recipientEmail: json["recipient_email"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_ids": productIds,
    "quantities": quantities,
    "delivery_info": deliveryInfo,
    "delivery_fee": deliveryFee,
    "delivery_time_slot": deliveryTimeSlot,
    "price": price,
    "tax": tax,
    "order_id": orderId,
    "payment_type": paymentType,
    "recipient_name": recipientName,
    "recipient_phone": recipientPhone,
    "recipient_email": recipientEmail,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user_id": userId,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}