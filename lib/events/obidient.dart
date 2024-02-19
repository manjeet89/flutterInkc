class Obideint {
  String? classId;
  String? className;
  String? classDescription;
  String? classStatus;
  String? classUpdatedOn;
  String? classCreatedOn;

  Obideint(
      {this.classId,
      this.className,
      this.classDescription,
      this.classStatus,
      this.classUpdatedOn,
      this.classCreatedOn});

  Obideint.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    className = json['class_name'];
    classDescription = json['class_description'];
    classStatus = json['class_status'];
    classUpdatedOn = json['class_updated_on'];
    classCreatedOn = json['class_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['class_name'] = this.className;
    data['class_description'] = this.classDescription;
    data['class_status'] = this.classStatus;
    data['class_updated_on'] = this.classUpdatedOn;
    data['class_created_on'] = this.classCreatedOn;
    return data;
  }
}
