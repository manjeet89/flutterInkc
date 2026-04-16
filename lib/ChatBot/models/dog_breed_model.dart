
// class DogBreedModel {
//   String id;
//   String name;

//   DogBreedModel({
//     required this.id,
//     required this.name,
//   });

//   factory DogBreedModel.fromJson(Map<String, dynamic> json) {
//     return DogBreedModel(
//       id: json['sub_cat_id'],
//       name: json['sub_category_name'],
//     );
//   }
// }

class BreedModel {
  String id;
  String name;

  BreedModel({required this.id, required this.name});

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json["sub_cat_id"].toString(),
      name: json["sub_category_name"].toString(),
    );
  }
}
