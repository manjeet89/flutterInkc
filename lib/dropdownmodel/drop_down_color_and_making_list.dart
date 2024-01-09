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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colour_id'] = this.colourId;
    data['colour_code'] = this.colourCode;
    data['colour_name'] = this.colourName;
    data['colour_status'] = this.colourStatus;
    data['colour_updated_on'] = this.colourUpdatedOn;
    data['colour_created_on'] = this.colourCreatedOn;
    return data;
  }
}
