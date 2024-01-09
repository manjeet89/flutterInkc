// To parse this JSON data, do
//
//     final NonInkcRegistrationDogModel = NonInkcRegistrationDogModelFromJson(jsonString);

import 'dart:convert';

List<NonInkcRegistrationDogModel> NonInkcRegistrationDogModelFromJson(
        String str) =>
    List<NonInkcRegistrationDogModel>.from(
        json.decode(str).map((x) => NonInkcRegistrationDogModel.fromJson(x)));

String NonInkcRegistrationDogModelToJson(
        List<NonInkcRegistrationDogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NonInkcRegistrationDogModel {
  String petId;
  String referBy;
  String ownerId;
  String isSecondOwner;
  dynamic secondOwnerId;
  dynamic litterKennelId;
  String isNonInkcRegistration;
  String petName;
  dynamic breederOwnerId;
  dynamic implementedDate;
  String birthDate;
  String petCategoryId;
  String petSubCategoryId;
  String isMicrochipRequire;
  dynamic petMicrochipNumber;
  dynamic uploadMicrochipDocument;
  String isDocumentRequire;
  String petRegistrationNumber;
  dynamic sireRegNumber;
  String sireUserApproval;
  dynamic sireUserApprovalComment;
  String sireAdminApproval;
  dynamic sireAdminApprovalComment;
  dynamic damRegNumber;
  String damUserApproval;
  dynamic damUserApprovalComment;
  String damAdminApproval;
  dynamic damAdminApprovalComment;
  String implementBy;
  dynamic implementerName;
  dynamic implementerMobileNumber;
  String microchipStatus;
  String petGender;
  dynamic colorMarking;
  dynamic brededCountry;
  String petImage;
  String frontSideCertificate;
  String backSideCertificate;
  dynamic petHeightImage;
  dynamic petSideImage;
  dynamic documentUpload;
  dynamic petComment;
  String isTransferChangedName;
  DateTime petUpdatedOn;
  DateTime petCreatedOn;
  String petRegisteredAs;
  String petChecked;
  String isDeath;
  dynamic deathDate;
  String petStatus;
  String paymentMode;
  dynamic paymentComment;
  String isPaidForPet;
  String userFullName;
  String categoryName;
  String subCategoryName;

  NonInkcRegistrationDogModel({
    required this.petId,
    required this.referBy,
    required this.ownerId,
    required this.isSecondOwner,
    required this.secondOwnerId,
    required this.litterKennelId,
    required this.isNonInkcRegistration,
    required this.petName,
    required this.breederOwnerId,
    required this.implementedDate,
    required this.birthDate,
    required this.petCategoryId,
    required this.petSubCategoryId,
    required this.isMicrochipRequire,
    required this.petMicrochipNumber,
    required this.uploadMicrochipDocument,
    required this.isDocumentRequire,
    required this.petRegistrationNumber,
    required this.sireRegNumber,
    required this.sireUserApproval,
    required this.sireUserApprovalComment,
    required this.sireAdminApproval,
    required this.sireAdminApprovalComment,
    required this.damRegNumber,
    required this.damUserApproval,
    required this.damUserApprovalComment,
    required this.damAdminApproval,
    required this.damAdminApprovalComment,
    required this.implementBy,
    required this.implementerName,
    required this.implementerMobileNumber,
    required this.microchipStatus,
    required this.petGender,
    required this.colorMarking,
    required this.brededCountry,
    required this.petImage,
    required this.frontSideCertificate,
    required this.backSideCertificate,
    required this.petHeightImage,
    required this.petSideImage,
    required this.documentUpload,
    required this.petComment,
    required this.isTransferChangedName,
    required this.petUpdatedOn,
    required this.petCreatedOn,
    required this.petRegisteredAs,
    required this.petChecked,
    required this.isDeath,
    required this.deathDate,
    required this.petStatus,
    required this.paymentMode,
    required this.paymentComment,
    required this.isPaidForPet,
    required this.userFullName,
    required this.categoryName,
    required this.subCategoryName,
  });

  factory NonInkcRegistrationDogModel.fromJson(Map<String, dynamic> json) =>
      NonInkcRegistrationDogModel(
        petId: json["pet_id"],
        referBy: json["refer_by"],
        ownerId: json["owner_id"],
        isSecondOwner: json["is_second_owner"],
        secondOwnerId: json["second_owner_id"],
        litterKennelId: json["litter_kennel_id"],
        isNonInkcRegistration: json["is_non_inkc_registration"],
        petName: json["pet_name"],
        breederOwnerId: json["breeder_owner_id"],
        implementedDate: json["implemented_date"],
        birthDate: json["birth_date"],
        petCategoryId: json["pet_category_id"],
        petSubCategoryId: json["pet_sub_category_id"],
        isMicrochipRequire: json["is_microchip_require"],
        petMicrochipNumber: json["pet_microchip_number"],
        uploadMicrochipDocument: json["upload_microchip_document"],
        isDocumentRequire: json["is_document_require"],
        petRegistrationNumber: json["pet_registration_number"],
        sireRegNumber: json["sire_reg_number"],
        sireUserApproval: json["sire_user_approval"],
        sireUserApprovalComment: json["sire_user_approval_comment"],
        sireAdminApproval: json["sire_admin_approval"],
        sireAdminApprovalComment: json["sire_admin_approval_comment"],
        damRegNumber: json["dam_reg_number"],
        damUserApproval: json["dam_user_approval"],
        damUserApprovalComment: json["dam_user_approval_comment"],
        damAdminApproval: json["dam_admin_approval"],
        damAdminApprovalComment: json["dam_admin_approval_comment"],
        implementBy: json["implement_by"],
        implementerName: json["implementer_name"],
        implementerMobileNumber: json["implementer_mobile_number"],
        microchipStatus: json["microchip_status"],
        petGender: json["pet_gender"],
        colorMarking: json["color_marking"],
        brededCountry: json["breded_country"],
        petImage: json["pet_image"],
        frontSideCertificate: json["front_side_certificate"],
        backSideCertificate: json["back_side_certificate"],
        petHeightImage: json["pet_height_image"],
        petSideImage: json["pet_side_image"],
        documentUpload: json["document_upload"],
        petComment: json["pet_comment"],
        isTransferChangedName: json["is_transfer_changed_name"],
        petUpdatedOn: DateTime.parse(json["pet_updated_on"]),
        petCreatedOn: DateTime.parse(json["pet_created_on"]),
        petRegisteredAs: json["pet_registered_as"],
        petChecked: json["pet_checked"],
        isDeath: json["is_death"],
        deathDate: json["death_date"],
        petStatus: json["pet_status"],
        paymentMode: json["payment_mode"],
        paymentComment: json["payment_comment"],
        isPaidForPet: json["is_paid_for_pet"],
        userFullName: json["user_full_name"],
        categoryName: json["category_name"],
        subCategoryName: json["sub_category_name"],
      );

  Map<String, dynamic> toJson() => {
        "pet_id": petId,
        "refer_by": referBy,
        "owner_id": ownerId,
        "is_second_owner": isSecondOwner,
        "second_owner_id": secondOwnerId,
        "litter_kennel_id": litterKennelId,
        "is_non_inkc_registration": isNonInkcRegistration,
        "pet_name": petName,
        "breeder_owner_id": breederOwnerId,
        "implemented_date": implementedDate,
        "birth_date": birthDate,
        "pet_category_id": petCategoryId,
        "pet_sub_category_id": petSubCategoryId,
        "is_microchip_require": isMicrochipRequire,
        "pet_microchip_number": petMicrochipNumber,
        "upload_microchip_document": uploadMicrochipDocument,
        "is_document_require": isDocumentRequire,
        "pet_registration_number": petRegistrationNumber,
        "sire_reg_number": sireRegNumber,
        "sire_user_approval": sireUserApproval,
        "sire_user_approval_comment": sireUserApprovalComment,
        "sire_admin_approval": sireAdminApproval,
        "sire_admin_approval_comment": sireAdminApprovalComment,
        "dam_reg_number": damRegNumber,
        "dam_user_approval": damUserApproval,
        "dam_user_approval_comment": damUserApprovalComment,
        "dam_admin_approval": damAdminApproval,
        "dam_admin_approval_comment": damAdminApprovalComment,
        "implement_by": implementBy,
        "implementer_name": implementerName,
        "implementer_mobile_number": implementerMobileNumber,
        "microchip_status": microchipStatus,
        "pet_gender": petGender,
        "color_marking": colorMarking,
        "breded_country": brededCountry,
        "pet_image": petImage,
        "front_side_certificate": frontSideCertificate,
        "back_side_certificate": backSideCertificate,
        "pet_height_image": petHeightImage,
        "pet_side_image": petSideImage,
        "document_upload": documentUpload,
        "pet_comment": petComment,
        "is_transfer_changed_name": isTransferChangedName,
        "pet_updated_on": petUpdatedOn.toIso8601String(),
        "pet_created_on": petCreatedOn.toIso8601String(),
        "pet_registered_as": petRegisteredAs,
        "pet_checked": petChecked,
        "is_death": isDeath,
        "death_date": deathDate,
        "pet_status": petStatus,
        "payment_mode": paymentMode,
        "payment_comment": paymentComment,
        "is_paid_for_pet": isPaidForPet,
        "user_full_name": userFullName,
        "category_name": categoryName,
        "sub_category_name": subCategoryName,
      };
}