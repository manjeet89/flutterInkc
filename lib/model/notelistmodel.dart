// To parse this JSON data, do
//
//     final noteList = noteListFromJson(jsonString);

import 'dart:convert';

List<NoteList> noteListFromJson(String str) =>
    List<NoteList>.from(json.decode(str).map((x) => NoteList.fromJson(x)));

String noteListToJson(List<NoteList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteList {
  String noteId;
  String notePetId;
  String noteUserId;
  String noteMessage;
  String noteCreatedOn;

  NoteList({
    required this.noteId,
    required this.notePetId,
    required this.noteUserId,
    required this.noteMessage,
    required this.noteCreatedOn,
  });

  factory NoteList.fromJson(Map<String, dynamic> json) => NoteList(
        noteId: json["note_id"],
        notePetId: json["note_pet_id"],
        noteUserId: json["note_user_id"],
        noteMessage: json["note_message"],
        noteCreatedOn: json["note_created_on"],
      );

  Map<String, dynamic> toJson() => {
        "note_id": noteId,
        "note_pet_id": notePetId,
        "note_user_id": noteUserId,
        "note_message": noteMessage,
        "note_created_on": noteCreatedOn,
      };
}
