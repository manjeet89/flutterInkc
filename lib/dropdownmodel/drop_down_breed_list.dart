class DogBreedList {
  String? subCatId;
  String? petCategoryId;
  String? subCategoryName;
  String? subCategoryCode;
  String? subCatSlug;
  String? subCatStudSlug;
  String? subCatImage;
  String? subIsDiscounted;
  String? subCategoryStatus;
  String? subCategoryUpdatedOn;
  String? subCategoryCreatedOn;

  DogBreedList(
      {this.subCatId,
      this.petCategoryId,
      this.subCategoryName,
      this.subCategoryCode,
      this.subCatSlug,
      this.subCatStudSlug,
      this.subCatImage,
      this.subIsDiscounted,
      this.subCategoryStatus,
      this.subCategoryUpdatedOn,
      this.subCategoryCreatedOn});

  DogBreedList.fromJson(Map<String, dynamic> json) {
    subCatId = json['sub_cat_id'];
    petCategoryId = json['pet_category_id'];
    subCategoryName = json['sub_category_name'];
    subCategoryCode = json['sub_category_code'];
    subCatSlug = json['sub_cat_slug'];
    subCatStudSlug = json['sub_cat_stud_slug'];
    subCatImage = json['sub_cat_image'];
    subIsDiscounted = json['sub_is_discounted'];
    subCategoryStatus = json['sub_category_status'];
    subCategoryUpdatedOn = json['sub_category_updated_on'];
    subCategoryCreatedOn = json['sub_category_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_cat_id'] = this.subCatId;
    data['pet_category_id'] = this.petCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['sub_category_code'] = this.subCategoryCode;
    data['sub_cat_slug'] = this.subCatSlug;
    data['sub_cat_stud_slug'] = this.subCatStudSlug;
    data['sub_cat_image'] = this.subCatImage;
    data['sub_is_discounted'] = this.subIsDiscounted;
    data['sub_category_status'] = this.subCategoryStatus;
    data['sub_category_updated_on'] = this.subCategoryUpdatedOn;
    data['sub_category_created_on'] = this.subCategoryCreatedOn;
    return data;
  }
}