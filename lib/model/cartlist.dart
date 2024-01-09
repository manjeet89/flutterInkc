// To parse this JSON data, do
//
//     final cartList = cartListFromJson(jsonString);

import 'dart:convert';

List<CartList> cartListFromJson(String str) =>
    List<CartList>.from(json.decode(str).map((x) => CartList.fromJson(x)));

String cartListToJson(List<CartList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartList {
  String cartId;
  String cartUserId;
  String cartInfo;
  String cartUseFor;
  String isPurchase;
  String isRemove;
  String cartUpdatedOn;
  String cartCreatedOn;

  CartList({
    required this.cartId,
    required this.cartUserId,
    required this.cartInfo,
    required this.cartUseFor,
    required this.isPurchase,
    required this.isRemove,
    required this.cartUpdatedOn,
    required this.cartCreatedOn,
  });

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
        cartId: json["cart_id"],
        cartUserId: json["cart_user_id"],
        cartInfo: json["cart_info"],
        cartUseFor: json["cart_use_for"],
        isPurchase: json["is_purchase"],
        isRemove: json["is_remove"],
        cartUpdatedOn: json["cart_updated_on"],
        cartCreatedOn: json["cart_created_on"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "cart_user_id": cartUserId,
        "cart_info": cartInfo,
        "cart_use_for": cartUseFor,
        "is_purchase": isPurchase,
        "is_remove": isRemove,
        "cart_updated_on": cartUpdatedOn,
        "cart_created_on": cartCreatedOn,
      };
}
