import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomModel {
  final String detail;
  final String url;
  RoomModel({
    required this.detail,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detail': detail,
      'url': url,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      detail: (map['detail'] ?? '') as String,
      url: (map['url'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
