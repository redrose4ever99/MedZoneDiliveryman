import 'dart:convert';

HomeItems homeItemsFromJson(String str) => HomeItems.fromJson(json.decode(str));

String homeItemsToJson(HomeItems data) => json.encode(data.toJson());

class HomeItems {
  HomeItems({
    required this.success,
    required this.data,
    required this.message,
    required this.code,
  });

  bool success;
  DataItems data;
  String message;
  int code;

  factory HomeItems.fromJson(Map<String, dynamic> json) => HomeItems(
        success: json["success"],
        data: DataItems.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        // "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class DataItems {
  List<Product>? products;
  List<Customer>? customers;

  DataItems(this.products, this.customers);
  DataItems.fromJson(Map<String, dynamic> json) {
    products =
        List<Product>.from(json["products"].map((x) => Product.fromJson(x)));

    customers =
        List<Customer>.from(json["customer"].map((x) => Customer.fromJson(x)));
  }
}

class Product {
  int? offer;
  int? amount;
  int? id;
  double? price;

  Product(this.offer, this.amount, this.id, this.price);

  Product.fromJson(Map<String, dynamic> json) {
    offer = json['offer'];
    amount = json['amount'];
    id = json['product'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() => {
        "offer": offer,
        "amount": amount,
        "product": id,
        "price": price,
      };
}

class Customer {
  int? id;
  int? code;
  String? full_name;
  // ignore: non_constant_identifier_names
  String? business_name;
  String? mobile;
  String? land_phone;
  String? details_address;

  Customer(this.id, this.code, this.full_name, this.business_name, this.mobile,
      this.land_phone, this.details_address);

  Customer.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    full_name = json["full_name"];
    business_name = json["business_name"];
    mobile = json["mobile"];
    land_phone = json["land_phone"];
    details_address = json["details_address"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "full_name": full_name,
        "business_name": business_name,
        "mobile": mobile,
        "land_phone": land_phone,
        "details_address": details_address,
      };
}
