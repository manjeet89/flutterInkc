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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kennel_club_id'] = this.kennelClubId;
    data['kennel_club_name'] = this.kennelClubName;
    data['kennel_club_prefix'] = this.kennelClubPrefix;
    data['kennel_club_status'] = this.kennelClubStatus;
    data['kennel_club_updated_on'] = this.kennelClubUpdatedOn;
    data['kennel_club_created_on'] = this.kennelClubCreatedOn;
    return data;
  }
}
