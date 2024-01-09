class EventsModel {
  String? eventId;
  String? eventNumber;
  String? eventType;
  String? isSpecialEvent;
  String? eventBreed;
  String? eventNameSuff;
  String? eventName;
  String? eventSlug;
  String? eventImage;
  String? isEventParent;
  String? parentEventId;
  String? eventClassPrice;
  String? classPriceValueNonInkc;
  String? dogPriceDiscount;
  String? eventStall;
  String? eventObediencePrice;
  String? eventStallPriceAc;
  String? eventStallPriceFan;
  String? eventJudge;
  String? eventVenue;
  String? eventAddress;
  String? eventLocation;
  String? eventContactPerson;
  String? eventDescription;
  String? eventStartDateTime;
  String? eventEndDateTime;
  String? eventEntryClosedOn;
  String? bestInGroup;
  String? bestInShow;
  String? allowedAudience;
  String? audienceEntryFee;
  String? audienceEntryFeeDog;
  String? eventEntryFees;
  String? eventStatus;
  String? eventUpdatedOn;
  String? eventCreatedOn;

  EventsModel(
      {this.eventId,
      this.eventNumber,
      this.eventType,
      this.isSpecialEvent,
      this.eventBreed,
      this.eventNameSuff,
      this.eventName,
      this.eventSlug,
      this.eventImage,
      this.isEventParent,
      this.parentEventId,
      this.eventClassPrice,
      this.classPriceValueNonInkc,
      this.dogPriceDiscount,
      this.eventStall,
      this.eventObediencePrice,
      this.eventStallPriceAc,
      this.eventStallPriceFan,
      this.eventJudge,
      this.eventVenue,
      this.eventAddress,
      this.eventLocation,
      this.eventContactPerson,
      this.eventDescription,
      this.eventStartDateTime,
      this.eventEndDateTime,
      this.eventEntryClosedOn,
      this.bestInGroup,
      this.bestInShow,
      this.allowedAudience,
      this.audienceEntryFee,
      this.audienceEntryFeeDog,
      this.eventEntryFees,
      this.eventStatus,
      this.eventUpdatedOn,
      this.eventCreatedOn});

  EventsModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventNumber = json['event_number'];
    eventType = json['event_type'];
    isSpecialEvent = json['is_special_event'];
    eventBreed = json['event_breed'];
    eventNameSuff = json['event_name_suff'];
    eventName = json['event_name'];
    eventSlug = json['event_slug'];
    eventImage = json['event_image'];
    isEventParent = json['is_event_parent'];
    parentEventId = json['parent_event_id'];
    eventClassPrice = json['event_class_price'];
    classPriceValueNonInkc = json['class_price_value_non_inkc'];
    dogPriceDiscount = json['dog_price_discount'];
    eventStall = json['event_stall'];
    eventObediencePrice = json['event_obedience_price'];
    eventStallPriceAc = json['event_stall_price_ac'];
    eventStallPriceFan = json['event_stall_price_fan'];
    eventJudge = json['event_judge'];
    eventVenue = json['event_venue'];
    eventAddress = json['event_address'];
    eventLocation = json['event_location'];
    eventContactPerson = json['event_contact_person'];
    eventDescription = json['event_description'];
    eventStartDateTime = json['event_start_date_time'];
    eventEndDateTime = json['event_end_date_time'];
    eventEntryClosedOn = json['event_entry_closed_on'];
    bestInGroup = json['best_in_group'];
    bestInShow = json['best_in_show'];
    allowedAudience = json['allowed_audience'];
    audienceEntryFee = json['audience_entry_fee'];
    audienceEntryFeeDog = json['audience_entry_fee_dog'];
    eventEntryFees = json['event_entry_fees'];
    eventStatus = json['event_status'];
    eventUpdatedOn = json['event_updated_on'];
    eventCreatedOn = json['event_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_number'] = this.eventNumber;
    data['event_type'] = this.eventType;
    data['is_special_event'] = this.isSpecialEvent;
    data['event_breed'] = this.eventBreed;
    data['event_name_suff'] = this.eventNameSuff;
    data['event_name'] = this.eventName;
    data['event_slug'] = this.eventSlug;
    data['event_image'] = this.eventImage;
    data['is_event_parent'] = this.isEventParent;
    data['parent_event_id'] = this.parentEventId;
    data['event_class_price'] = this.eventClassPrice;
    data['class_price_value_non_inkc'] = this.classPriceValueNonInkc;
    data['dog_price_discount'] = this.dogPriceDiscount;
    data['event_stall'] = this.eventStall;
    data['event_obedience_price'] = this.eventObediencePrice;
    data['event_stall_price_ac'] = this.eventStallPriceAc;
    data['event_stall_price_fan'] = this.eventStallPriceFan;
    data['event_judge'] = this.eventJudge;
    data['event_venue'] = this.eventVenue;
    data['event_address'] = this.eventAddress;
    data['event_location'] = this.eventLocation;
    data['event_contact_person'] = this.eventContactPerson;
    data['event_description'] = this.eventDescription;
    data['event_start_date_time'] = this.eventStartDateTime;
    data['event_end_date_time'] = this.eventEndDateTime;
    data['event_entry_closed_on'] = this.eventEntryClosedOn;
    data['best_in_group'] = this.bestInGroup;
    data['best_in_show'] = this.bestInShow;
    data['allowed_audience'] = this.allowedAudience;
    data['audience_entry_fee'] = this.audienceEntryFee;
    data['audience_entry_fee_dog'] = this.audienceEntryFeeDog;
    data['event_entry_fees'] = this.eventEntryFees;
    data['event_status'] = this.eventStatus;
    data['event_updated_on'] = this.eventUpdatedOn;
    data['event_created_on'] = this.eventCreatedOn;
    return data;
  }
}
