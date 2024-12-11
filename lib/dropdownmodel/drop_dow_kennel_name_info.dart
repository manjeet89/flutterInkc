class KennelNameInfoModel {
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

  KennelNameInfoModel(
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

  KennelNameInfoModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kennel_id'] = kennelId;
    data['owner_user_id'] = ownerUserId;
    data['is_second_owner'] = isSecondOwner;
    data['second_owner_id'] = secondOwnerId;
    data['kennel_name'] = kennelName;
    data['kennel_comment'] = kennelComment;
    data['kennel_status'] = kennelStatus;
    data['is_kennel_name_paid'] = isKennelNamePaid;
    data['kennel_updated_on'] = kennelUpdatedOn;
    data['kennel_created_on'] = kennelCreatedOn;
    return data;
  }
}
