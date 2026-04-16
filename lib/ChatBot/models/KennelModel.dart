class Kennelmodel {
  String id;
  String name;

  Kennelmodel({required this.id, required this.name});

  factory Kennelmodel.fromJson(Map<String, dynamic> json) {
    return Kennelmodel(
      id: json["kennel_club_id"].toString(),
      name: json["kennel_club_name"].toString(),
    );
  }
}
