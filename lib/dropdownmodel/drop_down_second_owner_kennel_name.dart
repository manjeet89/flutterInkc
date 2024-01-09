class SecondOwneModel {
  String? kennelId;
  String? ownerUserId;
  String? isSecondOwner;
  String? secondOwnerId;
  String? kennelName;
  String? kennelComment;
  String? kennelStatus;
  String? isKennelNamePaid;
  String? kennelUpdatedOn;
  String? kennelCreatedOn;

  SecondOwneModel(
      {this.kennelId,
      this.ownerUserId,
      this.isSecondOwner,
      this.secondOwnerId,
      this.kennelName,
      this.kennelComment,
      this.kennelStatus,
      this.isKennelNamePaid,
      this.kennelUpdatedOn,
      this.kennelCreatedOn});

  SecondOwneModel.fromJson(Map<String, dynamic> json) {
    kennelId = json['kennel_id'];
    ownerUserId = json['owner_user_id'];
    isSecondOwner = json['is_second_owner'];
    secondOwnerId = json['second_owner_id'];
    kennelName = json['kennel_name'];
    kennelComment = json['kennel_comment'];
    kennelStatus = json['kennel_status'];
    isKennelNamePaid = json['is_kennel_name_paid'];
    kennelUpdatedOn = json['kennel_updated_on'];
    kennelCreatedOn = json['kennel_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kennel_id'] = this.kennelId;
    data['owner_user_id'] = this.ownerUserId;
    data['is_second_owner'] = this.isSecondOwner;
    data['second_owner_id'] = this.secondOwnerId;
    data['kennel_name'] = this.kennelName;
    data['kennel_comment'] = this.kennelComment;
    data['kennel_status'] = this.kennelStatus;
    data['is_kennel_name_paid'] = this.isKennelNamePaid;
    data['kennel_updated_on'] = this.kennelUpdatedOn;
    data['kennel_created_on'] = this.kennelCreatedOn;
    return data;
  }
}
