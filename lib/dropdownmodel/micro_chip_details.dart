class MicroChipModel {
  String? empTypeId;
  String? empTypeName;
  String? empTypeAccess;
  String? empTypeStatus;
  String? empTypeUpdatedOn;
  String? empTypeCreatedOn;
  String? isAdminLogin;

  MicroChipModel(
      {this.empTypeId,
      this.empTypeName,
      this.empTypeAccess,
      this.empTypeStatus,
      this.empTypeUpdatedOn,
      this.empTypeCreatedOn,
      this.isAdminLogin});

  MicroChipModel.fromJson(Map<String, dynamic> json) {
    empTypeId = json['emp_type_id'];
    empTypeName = json['emp_type_name'];
    empTypeAccess = json['emp_type_access'];
    empTypeStatus = json['emp_type_status'];
    empTypeUpdatedOn = json['emp_type_updated_on'];
    empTypeCreatedOn = json['emp_type_created_on'];
    isAdminLogin = json['is_admin_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_type_id'] = this.empTypeId;
    data['emp_type_name'] = this.empTypeName;
    data['emp_type_access'] = this.empTypeAccess;
    data['emp_type_status'] = this.empTypeStatus;
    data['emp_type_updated_on'] = this.empTypeUpdatedOn;
    data['emp_type_created_on'] = this.empTypeCreatedOn;
    data['is_admin_login'] = this.isAdminLogin;
    return data;
  }
}
