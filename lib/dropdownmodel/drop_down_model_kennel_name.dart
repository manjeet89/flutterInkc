class DropDownKennelName {
  String? kennelClubId;
  String? kennelClubName;
  String? kennelClubPrefix;
  String? kennelClubStatus;
  String? kennelClubUpdatedOn;
  String? kennelClubCreatedOn;

  DropDownKennelName(
      {this.kennelClubId,
      this.kennelClubName,
      this.kennelClubPrefix,
      this.kennelClubStatus,
      this.kennelClubUpdatedOn,
      this.kennelClubCreatedOn});

  DropDownKennelName.fromJson(Map<String, dynamic> json) {
    kennelClubId = json['kennel_club_id'];
    kennelClubName = json['kennel_club_name'];
    kennelClubPrefix = json['kennel_club_prefix'];
    kennelClubStatus = json['kennel_club_status'];
    kennelClubUpdatedOn = json['kennel_club_updated_on'];
    kennelClubCreatedOn = json['kennel_club_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kennel_club_id'] = kennelClubId;
    data['kennel_club_name'] = kennelClubName;
    data['kennel_club_prefix'] = kennelClubPrefix;
    data['kennel_club_status'] = kennelClubStatus;
    data['kennel_club_updated_on'] = kennelClubUpdatedOn;
    data['kennel_club_created_on'] = kennelClubCreatedOn;
    return data;
  }
}
