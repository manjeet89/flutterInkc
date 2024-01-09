class DamNumberModel {
  String? petId;
  String? referBy;
  String? ownerId;
  String? isSecondOwner;
  String? secondOwnerId;
  String? litterKennelId;
  String? isNonInkcRegistration;
  String? petName;
  String? breederOwnerId;
  String? implementedDate;
  String? birthDate;
  String? petCategoryId;
  String? petSubCategoryId;
  String? isMicrochipRequire;
  String? petMicrochipNumber;
  String? uploadMicrochipDocument;
  String? isDocumentRequire;
  String? petRegistrationNumber;
  String? sireRegNumber;
  String? sireUserApproval;
  String? sireUserApprovalComment;
  String? sireAdminApproval;
  String? sireAdminApprovalComment;
  String? damRegNumber;
  String? damUserApproval;
  String? damUserApprovalComment;
  String? damAdminApproval;
  String? damAdminApprovalComment;
  String? implementBy;
  String? implementerName;
  String? implementerMobileNumber;
  String? microchipStatus;
  String? petGender;
  String? colorMarking;
  String? brededCountry;
  String? petImage;
  String? frontSideCertificate;
  String? backSideCertificate;
  String? petHeightImage;
  String? petSideImage;
  String? documentUpload;
  String? petComment;
  String? isTransferChangedName;
  String? petUpdatedOn;
  String? petCreatedOn;
  String? petRegisteredAs;
  String? petChecked;
  String? isDeath;
  String? deathDate;
  String? petStatus;
  String? paymentMode;
  String? paymentComment;
  String? isPaidForPet;

  DamNumberModel(
      {this.petId,
      this.referBy,
      this.ownerId,
      this.isSecondOwner,
      this.secondOwnerId,
      this.litterKennelId,
      this.isNonInkcRegistration,
      this.petName,
      this.breederOwnerId,
      this.implementedDate,
      this.birthDate,
      this.petCategoryId,
      this.petSubCategoryId,
      this.isMicrochipRequire,
      this.petMicrochipNumber,
      this.uploadMicrochipDocument,
      this.isDocumentRequire,
      this.petRegistrationNumber,
      this.sireRegNumber,
      this.sireUserApproval,
      this.sireUserApprovalComment,
      this.sireAdminApproval,
      this.sireAdminApprovalComment,
      this.damRegNumber,
      this.damUserApproval,
      this.damUserApprovalComment,
      this.damAdminApproval,
      this.damAdminApprovalComment,
      this.implementBy,
      this.implementerName,
      this.implementerMobileNumber,
      this.microchipStatus,
      this.petGender,
      this.colorMarking,
      this.brededCountry,
      this.petImage,
      this.frontSideCertificate,
      this.backSideCertificate,
      this.petHeightImage,
      this.petSideImage,
      this.documentUpload,
      this.petComment,
      this.isTransferChangedName,
      this.petUpdatedOn,
      this.petCreatedOn,
      this.petRegisteredAs,
      this.petChecked,
      this.isDeath,
      this.deathDate,
      this.petStatus,
      this.paymentMode,
      this.paymentComment,
      this.isPaidForPet});

  DamNumberModel.fromJson(Map<String, dynamic> json) {
    petId = json['pet_id'];
    referBy = json['refer_by'];
    ownerId = json['owner_id'];
    isSecondOwner = json['is_second_owner'];
    secondOwnerId = json['second_owner_id'];
    litterKennelId = json['litter_kennel_id'];
    isNonInkcRegistration = json['is_non_inkc_registration'];
    petName = json['pet_name'];
    breederOwnerId = json['breeder_owner_id'];
    implementedDate = json['implemented_date'];
    birthDate = json['birth_date'];
    petCategoryId = json['pet_category_id'];
    petSubCategoryId = json['pet_sub_category_id'];
    isMicrochipRequire = json['is_microchip_require'];
    petMicrochipNumber = json['pet_microchip_number'];
    uploadMicrochipDocument = json['upload_microchip_document'];
    isDocumentRequire = json['is_document_require'];
    petRegistrationNumber = json['pet_registration_number'];
    sireRegNumber = json['sire_reg_number'];
    sireUserApproval = json['sire_user_approval'];
    sireUserApprovalComment = json['sire_user_approval_comment'];
    sireAdminApproval = json['sire_admin_approval'];
    sireAdminApprovalComment = json['sire_admin_approval_comment'];
    damRegNumber = json['dam_reg_number'];
    damUserApproval = json['dam_user_approval'];
    damUserApprovalComment = json['dam_user_approval_comment'];
    damAdminApproval = json['dam_admin_approval'];
    damAdminApprovalComment = json['dam_admin_approval_comment'];
    implementBy = json['implement_by'];
    implementerName = json['implementer_name'];
    implementerMobileNumber = json['implementer_mobile_number'];
    microchipStatus = json['microchip_status'];
    petGender = json['pet_gender'];
    colorMarking = json['color_marking'];
    brededCountry = json['breded_country'];
    petImage = json['pet_image'];
    frontSideCertificate = json['front_side_certificate'];
    backSideCertificate = json['back_side_certificate'];
    petHeightImage = json['pet_height_image'];
    petSideImage = json['pet_side_image'];
    documentUpload = json['document_upload'];
    petComment = json['pet_comment'];
    isTransferChangedName = json['is_transfer_changed_name'];
    petUpdatedOn = json['pet_updated_on'];
    petCreatedOn = json['pet_created_on'];
    petRegisteredAs = json['pet_registered_as'];
    petChecked = json['pet_checked'];
    isDeath = json['is_death'];
    deathDate = json['death_date'];
    petStatus = json['pet_status'];
    paymentMode = json['payment_mode'];
    paymentComment = json['payment_comment'];
    isPaidForPet = json['is_paid_for_pet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pet_id'] = this.petId;
    data['refer_by'] = this.referBy;
    data['owner_id'] = this.ownerId;
    data['is_second_owner'] = this.isSecondOwner;
    data['second_owner_id'] = this.secondOwnerId;
    data['litter_kennel_id'] = this.litterKennelId;
    data['is_non_inkc_registration'] = this.isNonInkcRegistration;
    data['pet_name'] = this.petName;
    data['breeder_owner_id'] = this.breederOwnerId;
    data['implemented_date'] = this.implementedDate;
    data['birth_date'] = this.birthDate;
    data['pet_category_id'] = this.petCategoryId;
    data['pet_sub_category_id'] = this.petSubCategoryId;
    data['is_microchip_require'] = this.isMicrochipRequire;
    data['pet_microchip_number'] = this.petMicrochipNumber;
    data['upload_microchip_document'] = this.uploadMicrochipDocument;
    data['is_document_require'] = this.isDocumentRequire;
    data['pet_registration_number'] = this.petRegistrationNumber;
    data['sire_reg_number'] = this.sireRegNumber;
    data['sire_user_approval'] = this.sireUserApproval;
    data['sire_user_approval_comment'] = this.sireUserApprovalComment;
    data['sire_admin_approval'] = this.sireAdminApproval;
    data['sire_admin_approval_comment'] = this.sireAdminApprovalComment;
    data['dam_reg_number'] = this.damRegNumber;
    data['dam_user_approval'] = this.damUserApproval;
    data['dam_user_approval_comment'] = this.damUserApprovalComment;
    data['dam_admin_approval'] = this.damAdminApproval;
    data['dam_admin_approval_comment'] = this.damAdminApprovalComment;
    data['implement_by'] = this.implementBy;
    data['implementer_name'] = this.implementerName;
    data['implementer_mobile_number'] = this.implementerMobileNumber;
    data['microchip_status'] = this.microchipStatus;
    data['pet_gender'] = this.petGender;
    data['color_marking'] = this.colorMarking;
    data['breded_country'] = this.brededCountry;
    data['pet_image'] = this.petImage;
    data['front_side_certificate'] = this.frontSideCertificate;
    data['back_side_certificate'] = this.backSideCertificate;
    data['pet_height_image'] = this.petHeightImage;
    data['pet_side_image'] = this.petSideImage;
    data['document_upload'] = this.documentUpload;
    data['pet_comment'] = this.petComment;
    data['is_transfer_changed_name'] = this.isTransferChangedName;
    data['pet_updated_on'] = this.petUpdatedOn;
    data['pet_created_on'] = this.petCreatedOn;
    data['pet_registered_as'] = this.petRegisteredAs;
    data['pet_checked'] = this.petChecked;
    data['is_death'] = this.isDeath;
    data['death_date'] = this.deathDate;
    data['pet_status'] = this.petStatus;
    data['payment_mode'] = this.paymentMode;
    data['payment_comment'] = this.paymentComment;
    data['is_paid_for_pet'] = this.isPaidForPet;
    return data;
  }
}