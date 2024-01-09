class KennelHistory {
  String? historyId;
  String? kennelId;
  String? kennelClubName;
  String? kennelClubComment;
  String? kennelClubStatus;
  String? historyCreatedOn;

  KennelHistory(
      {this.historyId,
      this.kennelId,
      this.kennelClubName,
      this.kennelClubComment,
      this.kennelClubStatus,
      this.historyCreatedOn});

  KennelHistory.fromJson(Map<String, dynamic> json) {
    historyId = json['history_id'];
    kennelId = json['kennel_id'];
    kennelClubName = json['kennel_club_name'];
    kennelClubComment = json['kennel_club_comment'];
    kennelClubStatus = json['kennel_club_status'];
    historyCreatedOn = json['history_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['history_id'] = this.historyId;
    data['kennel_id'] = this.kennelId;
    data['kennel_club_name'] = this.kennelClubName;
    data['kennel_club_comment'] = this.kennelClubComment;
    data['kennel_club_status'] = this.kennelClubStatus;
    data['history_created_on'] = this.historyCreatedOn;
    return data;
  }
}
