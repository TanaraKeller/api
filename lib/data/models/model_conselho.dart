import 'dart:convert';

ConselhoModel conselhoModelFromJson(String str) => ConselhoModel.fromJson(json.decode(str));

String conselhoModelToJson(ConselhoModel data) => json.encode(data.toJson());

class ConselhoModel {
  Slip slip;

  ConselhoModel({
    required this.slip,
  });

  factory ConselhoModel.fromJson(Map<String, dynamic> json) => ConselhoModel(
    slip: Slip.fromJson(json["slip"]),
  );

  Map<String, dynamic> toJson() => {
    "slip": slip.toJson(),
  };
}

class Slip {
  int id;
  String advice;

  Slip({
    required this.id,
    required this.advice,
  });

  factory Slip.fromJson(Map<String, dynamic> json) => Slip(
    id: json["id"],
    advice: json["advice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "advice": advice,
  };
}

