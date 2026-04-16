class DogDamLisrModel {
  String id;
  String name;
  String pet_registration_number;

  DogDamLisrModel({required this.id, required this.name, required this.pet_registration_number});

  factory DogDamLisrModel.fromJson(Map<String, dynamic> json) {
    return DogDamLisrModel(
      id: json["pet_id"].toString(),
      name: json["pet_name"].toString(),
      pet_registration_number: json["pet_registration_number"].toString(),
    );
  }
}
