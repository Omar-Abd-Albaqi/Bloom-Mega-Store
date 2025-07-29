class OrderModel {
  final String id;
  final String status;
  final String email;
  final int total;
  final int subtotal;
  final String currencyCode;
  final int displayId;
  final DateTime createdAt;
  final List<OrderItem> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.email,
    required this.total,
    required this.subtotal,
    required this.currencyCode,
    required this.displayId,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      email: json['email'],
      total: json['total'],
      subtotal: json['subtotal'],
      currencyCode: json['currency_code'],
      displayId: json['display_id'],
      createdAt: DateTime.parse(json['created_at']),
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  final String id;
  final String title;
  final String? subtitle;
  final String thumbnail;
  final String variantId;
  final String productId;
  final String productTitle;
  final String productDescription;
  final int unitPrice;
  final int quantity;
  final int subtotal;
  final int total;
  final OrderItemDetail detail;

  OrderItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.thumbnail,
    required this.variantId,
    required this.productId,
    required this.productTitle,
    required this.productDescription,
    required this.unitPrice,
    required this.quantity,
    required this.subtotal,
    required this.total,
    required this.detail,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      thumbnail: json['thumbnail'],
      variantId: json['variant_id'],
      productId: json['product_id'],
      productTitle: json['product_title'],
      productDescription: json['product_description'],
      unitPrice: json['unit_price'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      total: json['total'],
      detail: OrderItemDetail.fromJson(json['detail']),
    );
  }
}

class OrderItemDetail {
  final String id;
  final int quantity;
  final int fulfilledQuantity;
  final int shippedQuantity;

  OrderItemDetail({
    required this.id,
    required this.quantity,
    required this.fulfilledQuantity,
    required this.shippedQuantity,
  });

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) {
    return OrderItemDetail(
      id: json['id'],
      quantity: json['quantity'],
      fulfilledQuantity: json['fulfilled_quantity'],
      shippedQuantity: json['shipped_quantity'],
    );
  }
}
