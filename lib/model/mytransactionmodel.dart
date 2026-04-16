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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_phone_number'] = userPhoneNumber;
    data['payment_id'] = paymentId;
    data['payment_user_id'] = paymentUserId;
    data['payment_details'] = paymentDetails;
    data['order_details'] = orderDetails;
    data['order_comment'] = orderComment;
    data['payment_transaction_details'] = paymentTransactionDetails;
    data['affilate_code'] = affilateCode;
    data['affilate_details'] = affilateDetails;
    data['order_status'] = orderStatus;
    data['is_api_used'] = isApiUsed;
    data['payment_mode'] = paymentMode;
    data['payment_created_on'] = paymentCreatedOn;
    data['payment_updated_on'] = paymentUpdatedOn;
    data['transaction_credit'] = transactionCredit;
    data['option_name'] = optionName;
    return data;
  }
}
