// To parse this JSON data, do
//
//     final NotificationModel = NotificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> NotificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String NotificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String notiId;
  String notiUserId;
  String urlCreated;
  String notiMessage;
  String notiStatus;
  String notiCreatedOn;
  String notiUpdatedOn;

  NotificationModel({
    required this.notiId,
    required this.notiUserId,
    required this.urlCreated,
    required this.notiMessage,
    required this.notiStatus,
    required this.notiCreatedOn,
    required this.notiUpdatedOn,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notiId: json["noti_id"],
        notiUserId: json["noti_user_id"],
        urlCreated: json["url_created"],
        notiMessage: json["noti_message"],
        notiStatus: json["noti_status"],
        notiCreatedOn: json["noti_created_on"],
        notiUpdatedOn: json["noti_updated_on"],
      );

  Map<String, dynamic> toJson() => {
        "noti_id": notiId,
        "noti_user_id": notiUserId,
        "url_created": urlCreated,
        "noti_message": notiMessage,
        "noti_status": notiStatus,
        "noti_created_on": notiCreatedOn,
        "noti_updated_on": notiUpdatedOn,
      };
}
