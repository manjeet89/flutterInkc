// To parse this JSON data, do
//
//     final storeListModel = storeListModelFromJson(jsonString);

import 'dart:convert';

List<StoreListModel> storeListModelFromJson(String str) =>
    List<StoreListModel>.from(
        json.decode(str).map((x) => StoreListModel.fromJson(x)));

String storeListModelToJson(List<StoreListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreListModel {
  String productId;
  String productName;
  String productDescription;
  String productUrl;
  String productImage;
  String nonMemberFee;
  String memberFee;
  String actualPrice;
  String affilatePercentage;
  String isCourierRequired;
  DateTime productUpdatedOn;
  DateTime productCreatedOn;

  StoreListModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productUrl,
    required this.productImage,
    required this.nonMemberFee,
    required this.memberFee,
    required this.actualPrice,
    required this.affilatePercentage,
    required this.isCourierRequired,
    required this.productUpdatedOn,
    required this.productCreatedOn,
  });

  factory StoreListModel.fromJson(Map<String, dynamic> json) => StoreListModel(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productUrl: json["product_url"],
        productImage: json["product_image"],
        nonMemberFee: json["non_member_fee"],
        memberFee: json["member_fee"],
        actualPrice: json["actual_price"],
        affilatePercentage: json["affilate_percentage"],
        isCourierRequired: json["is_courier_required"],
        productUpdatedOn: DateTime.parse(json["product_updated_on"]),
        productCreatedOn: DateTime.parse(json["product_created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_url": productUrl,
        "product_image": productImage,
        "non_member_fee": nonMemberFee,
        "member_fee": memberFee,
        "actual_price": actualPrice,
        "affilate_percentage": affilatePercentage,
        "is_courier_required": isCourierRequired,
        "product_updated_on": productUpdatedOn.toIso8601String(),
        "product_created_on": productCreatedOn.toIso8601String(),
      };
}
