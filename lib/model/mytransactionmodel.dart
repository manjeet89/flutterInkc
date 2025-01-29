class MyTransactionModel {
  String? firstName;
  String? lastName;
  String? userPhoneNumber;
  String? paymentId;
  String? paymentUserId;
  String? paymentDetails;
  String? orderDetails;
  String? orderComment;
  String? paymentTransactionDetails;
  String? affilateCode;
  String? affilateDetails;
  String? orderStatus;
  String? isApiUsed;
  String? paymentMode;
  String? paymentCreatedOn;
  String? paymentUpdatedOn;
  String? transactionCredit;
  String? optionName;

  MyTransactionModel(
      {this.firstName,
      this.lastName,
      this.userPhoneNumber,
      this.paymentId,
      this.paymentUserId,
      this.paymentDetails,
      this.orderDetails,
      this.orderComment,
      this.paymentTransactionDetails,
      this.affilateCode,
      this.affilateDetails,
      this.orderStatus,
      this.isApiUsed,
      this.paymentMode,
      this.paymentCreatedOn,
      this.paymentUpdatedOn,
      this.transactionCredit,
      this.optionName});

  MyTransactionModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userPhoneNumber = json['user_phone_number'];
    paymentId = json['payment_id'];
    paymentUserId = json['payment_user_id'];
    paymentDetails = json['payment_details'];
    orderDetails = json['order_details'];
    orderComment = json['order_comment'];
    paymentTransactionDetails = json['payment_transaction_details'];
    affilateCode = json['affilate_code'];
    affilateDetails = json['affilate_details'];
    orderStatus = json['order_status'];
    isApiUsed = json['is_api_used'];
    paymentMode = json['payment_mode'];
    paymentCreatedOn = json['payment_created_on'];
    paymentUpdatedOn = json['payment_updated_on'];
    transactionCredit = json['transaction_credit'];
    optionName = json['option_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_phone_number'] = this.userPhoneNumber;
    data['payment_id'] = this.paymentId;
    data['payment_user_id'] = this.paymentUserId;
    data['payment_details'] = this.paymentDetails;
    data['order_details'] = this.orderDetails;
    data['order_comment'] = this.orderComment;
    data['payment_transaction_details'] = this.paymentTransactionDetails;
    data['affilate_code'] = this.affilateCode;
    data['affilate_details'] = this.affilateDetails;
    data['order_status'] = this.orderStatus;
    data['is_api_used'] = this.isApiUsed;
    data['payment_mode'] = this.paymentMode;
    data['payment_created_on'] = this.paymentCreatedOn;
    data['payment_updated_on'] = this.paymentUpdatedOn;
    data['transaction_credit'] = this.transactionCredit;
    data['option_name'] = this.optionName;
    return data;
  }
}
