class ParticipentEventDropDown {
  String? petId;
  String? petName;

  ParticipentEventDropDown({this.petId, this.petName});

  ParticipentEventDropDown.fromJson(Map<String, dynamic> json) {
    petId = json['pet_id'];
    petName = json['pet_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pet_id'] = this.petId;
    data['pet_name'] = this.petName;
    return data;
  }
}
