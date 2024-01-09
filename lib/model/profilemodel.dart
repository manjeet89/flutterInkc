class ProfileModel {
  final String firstname;
  final String lastname;

  ProfileModel({required this.firstname, required this.lastname});
}



// class ProfileModel {
//   String userId;
//   String addedBy;
//   String referedBy;
//   String userEmployeeType;
//   String userFullName;
//   String firstName;
//   String middleName;
//   String lastName;
//   String userProfileImage;
//   String gender;
//   DateTime userBirthDate;
//   String userEmailId;
//   String userPhoneNumber;
//   String alternetContactNumber;
//   String userPassword;
//   String userAddress;
//   String userAddress2;
//   String userLocal;
//   String userDistrict;
//   String userState;
//   String userPincode;
//   String alternetAddress;
//   String userOtp;
//   String userOtpTried;
//   String sendOtpTried;
//   String isVerified;
//   String userStatus;
//   String isAlive;
//   String memberStatus;
//   String memberStatusId;
//   String kennelClubName;
//   String kennelClubComment;
//   String kennelClubStatus;
//   String isKennelClubPaid;
//   String judgeUserId;
//   String affilateCode;
//   String isUpdatedOnce;
//   String cardCode;
//   String userToken;
//   String isAdmin;
//   String userUpdatedOn;
//   String userCreatedOn;

//   ProfileModel({
//     required this.userId,
//     required this.addedBy,
//     required this.referedBy,
//     required this.userEmployeeType,
//     required this.userFullName,
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     required this.userProfileImage,
//     required this.gender,
//     required this.userBirthDate,
//     required this.userEmailId,
//     required this.userPhoneNumber,
//     required this.alternetContactNumber,
//     required this.userPassword,
//     required this.userAddress,
//     required this.userAddress2,
//     required this.userLocal,
//     required this.userDistrict,
//     required this.userState,
//     required this.userPincode,
//     required this.alternetAddress,
//     required this.userOtp,
//     required this.userOtpTried,
//     required this.sendOtpTried,
//     required this.isVerified,
//     required this.userStatus,
//     required this.isAlive,
//     required this.memberStatus,
//     required this.memberStatusId,
//     required this.kennelClubName,
//     required this.kennelClubComment,
//     required this.kennelClubStatus,
//     required this.isKennelClubPaid,
//     required this.judgeUserId,
//     required this.affilateCode,
//     required this.isUpdatedOnce,
//     required this.cardCode,
//     required this.userToken,
//     required this.isAdmin,
//     required this.userUpdatedOn,
//     required this.userCreatedOn,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//         userId: json["user_id"],
//         addedBy: json["added_by"],
//         referedBy: json["refered_by"],
//         userEmployeeType: json["user_employee_type"],
//         userFullName: json["user_full_name"],
//         firstName: json["first_name"],
//         middleName: json["middle_name"],
//         lastName: json["last_name"],
//         userProfileImage: json["user_profile_image"],
//         gender: json["gender"],
//         userBirthDate: DateTime.parse(json["user_birth_date"]),
//         userEmailId: json["user_email_id"],
//         userPhoneNumber: json["user_phone_number"],
//         alternetContactNumber: json["alternet_contact_number"],
//         userPassword: json["user_password"],
//         userAddress: json["user_address"],
//         userAddress2: json["user_address_2"],
//         userLocal: json["user_local"],
//         userDistrict: json["user_district"],
//         userState: json["user_state"],
//         userPincode: json["user_pincode"],
//         alternetAddress: json["alternet_address"],
//         userOtp: json["user_otp"],
//         userOtpTried: json["user_otp_tried"],
//         sendOtpTried: json["send_otp_tried"],
//         isVerified: json["is_verified"],
//         userStatus: json["user_status"],
//         isAlive: json["is_alive"],
//         memberStatus: json["member_status"],
//         memberStatusId: json["member_status_id"],
//         kennelClubName: json["kennel_club_name"],
//         kennelClubComment: json["kennel_club_comment"],
//         kennelClubStatus: json["kennel_club_status"],
//         isKennelClubPaid: json["is_kennel_club_paid"],
//         judgeUserId: json["judge_user_id"],
//         affilateCode: json["affilate_code"],
//         isUpdatedOnce: json["is_updated_once"],
//         cardCode: json["card_code"],
//         userToken: json["user_token"],
//         isAdmin: json["is_admin"],
//         userUpdatedOn: json["user_updated_on"],
//         userCreatedOn: json["user_created_on"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "added_by": addedBy,
//         "refered_by": referedBy,
//         "user_employee_type": userEmployeeType,
//         "user_full_name": userFullName,
//         "first_name": firstName,
//         "middle_name": middleName,
//         "last_name": lastName,
//         "user_profile_image": userProfileImage,
//         "gender": gender,
//         "user_birth_date":
//             "${userBirthDate.year.toString().padLeft(4, '0')}-${userBirthDate.month.toString().padLeft(2, '0')}-${userBirthDate.day.toString().padLeft(2, '0')}",
//         "user_email_id": userEmailId,
//         "user_phone_number": userPhoneNumber,
//         "alternet_contact_number": alternetContactNumber,
//         "user_password": userPassword,
//         "user_address": userAddress,
//         "user_address_2": userAddress2,
//         "user_local": userLocal,
//         "user_district": userDistrict,
//         "user_state": userState,
//         "user_pincode": userPincode,
//         "alternet_address": alternetAddress,
//         "user_otp": userOtp,
//         "user_otp_tried": userOtpTried,
//         "send_otp_tried": sendOtpTried,
//         "is_verified": isVerified,
//         "user_status": userStatus,
//         "is_alive": isAlive,
//         "member_status": memberStatus,
//         "member_status_id": memberStatusId,
//         "kennel_club_name": kennelClubName,
//         "kennel_club_comment": kennelClubComment,
//         "kennel_club_status": kennelClubStatus,
//         "is_kennel_club_paid": isKennelClubPaid,
//         "judge_user_id": judgeUserId,
//         "affilate_code": affilateCode,
//         "is_updated_once": isUpdatedOnce,
//         "card_code": cardCode,
//         "user_token": userToken,
//         "is_admin": isAdmin,
//         "user_updated_on": userUpdatedOn,
//         "user_created_on": userCreatedOn,
//       };
// }
