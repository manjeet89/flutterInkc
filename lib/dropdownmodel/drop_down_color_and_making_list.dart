class ColorAndMaking {
  String? colourId;
  String? colourCode;
  String? colourName;
  String? colourStatus;
  String? colourUpdatedOn;
  String? colourCreatedOn;

  ColorAndMaking(
      {this.colourId,
      this.colourCode,
      this.colourName,
      this.colourStatus,
      this.colourUpdatedOn,
      this.colourCreatedOn});

  ColorAndMaking.fromJson(Map<String, dynamic> json) {
    colourId = json['colour_id'];
    colourCode = json['colour_code'];
    colourName = json['colour_name'];
    colourStatus = json['colour_status'];
    colourUpdatedOn = json['colour_updated_on'];
    colourCreatedOn = json['colour_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['colour_id'] = colourId;
    data['colour_code'] = colourCode;
    data['colour_name'] = colourName;
    data['colour_status'] = colourStatus;
    data['colour_updated_on'] = colourUpdatedOn;
    data['colour_created_on'] = colourCreatedOn;
    return data;
  }
}
