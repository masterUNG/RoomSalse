import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomModel {
  final String detail;
  final String url;
  final String price;
  final String priceEle;
  final String amount;
  RoomModel({
    required this.detail,
    required this.url,
    required this.price,
    required this.priceEle,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detail': detail,
      'url': url,
      'price': price,
      'priceEle': priceEle,
      'amount': amount,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      detail: (map['detail'] ?? '') as String,
      url: (map['url'] ?? '') as String,
      price: (map['price'] ?? '') as String,
      priceEle: (map['priceEle'] ?? '') as String,
      amount: (map['amount'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
