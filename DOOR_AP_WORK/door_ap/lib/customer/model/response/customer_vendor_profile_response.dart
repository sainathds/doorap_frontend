class CustomerVendorProfileResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerVendorProfileResponse({int? status, String? msg, Payload? payload}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (payload != null) {
      this._payload = payload;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  Payload? get payload => _payload;
  set payload(Payload? payload) => _payload = payload;

  CustomerVendorProfileResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.toJson();
    }
    return data;
  }
}

class Payload {
  List<VendorProfile>? _vendorProfile;
  List<ReviewAndFeedback>? _reviewAndFeedback;

  Payload(
      {List<VendorProfile>? vendorProfile,
        List<ReviewAndFeedback>? reviewAndFeedback}) {
    if (vendorProfile != null) {
      this._vendorProfile = vendorProfile;
    }
    if (reviewAndFeedback != null) {
      this._reviewAndFeedback = reviewAndFeedback;
    }
  }

  List<VendorProfile>? get vendorProfile => _vendorProfile;
  set vendorProfile(List<VendorProfile>? vendorProfile) =>
      _vendorProfile = vendorProfile;
  List<ReviewAndFeedback>? get reviewAndFeedback => _reviewAndFeedback;
  set reviewAndFeedback(List<ReviewAndFeedback>? reviewAndFeedback) =>
      _reviewAndFeedback = reviewAndFeedback;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['vendor_profile'] != null) {
      _vendorProfile = <VendorProfile>[];
      json['vendor_profile'].forEach((v) {
        _vendorProfile!.add(new VendorProfile.fromJson(v));
      });
    }
    if (json['review_and_feedback'] != null) {
      _reviewAndFeedback = <ReviewAndFeedback>[];
      json['review_and_feedback'].forEach((v) {
        _reviewAndFeedback!.add(new ReviewAndFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._vendorProfile != null) {
      data['vendor_profile'] =
          this._vendorProfile!.map((v) => v.toJson()).toList();
    }
    if (this._reviewAndFeedback != null) {
      data['review_and_feedback'] =
          this._reviewAndFeedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorProfile {
  int? _fkVendorId;
  String? _fkVendorFullName;
  int? _fkCategoryId;
  String? _fkCategoryCategoryName;
  String? _fkVendorAbountMe;
  String? _fkVendorProfileImage;
  String? _fkVendorBusinessName;
  String? _rating;

  VendorProfile(
      {int? fkVendorId,
        String? fkVendorFullName,
        int? fkCategoryId,
        String? fkCategoryCategoryName,
        String? fkVendorAbountMe,
        String? fkVendorProfileImage,
        String? fkVendorBusinessName,
        String? rating}) {
    if (fkVendorId != null) {
      this._fkVendorId = fkVendorId;
    }
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkCategoryId != null) {
      this._fkCategoryId = fkCategoryId;
    }
    if (fkCategoryCategoryName != null) {
      this._fkCategoryCategoryName = fkCategoryCategoryName;
    }
    if (fkVendorAbountMe != null) {
      this._fkVendorAbountMe = fkVendorAbountMe;
    }
    if (fkVendorProfileImage != null) {
      this._fkVendorProfileImage = fkVendorProfileImage;
    }
    if (fkVendorBusinessName != null) {
      this._fkVendorBusinessName = fkVendorBusinessName;
    }
    if (rating != null) {
      this._rating = rating;
    }
  }

  int? get fkVendorId => _fkVendorId;
  set fkVendorId(int? fkVendorId) => _fkVendorId = fkVendorId;
  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  int? get fkCategoryId => _fkCategoryId;
  set fkCategoryId(int? fkCategoryId) => _fkCategoryId = fkCategoryId;
  String? get fkCategoryCategoryName => _fkCategoryCategoryName;
  set fkCategoryCategoryName(String? fkCategoryCategoryName) =>
      _fkCategoryCategoryName = fkCategoryCategoryName;
  String? get fkVendorAbountMe => _fkVendorAbountMe;
  set fkVendorAbountMe(String? fkVendorAbountMe) =>
      _fkVendorAbountMe = fkVendorAbountMe;
  String? get fkVendorProfileImage => _fkVendorProfileImage;
  set fkVendorProfileImage(String? fkVendorProfileImage) =>
      _fkVendorProfileImage = fkVendorProfileImage;
  String? get fkVendorBusinessName => _fkVendorBusinessName;
  set fkVendorBusinessName(String? fkVendorBusinessName) =>
      _fkVendorBusinessName = fkVendorBusinessName;
  String? get rating => _rating;
  set rating(String? rating) => _rating = rating;

  VendorProfile.fromJson(Map<String, dynamic> json) {
    _fkVendorId = json['fk_vendor__id'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkCategoryId = json['fk_category__id'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
    _fkVendorAbountMe = json['fk_vendor__abount_me'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
    _fkVendorBusinessName = json['fk_vendor__business_name'];
    _rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_vendor__id'] = this._fkVendorId;
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_category__id'] = this._fkCategoryId;
    data['fk_category__category_name'] = this._fkCategoryCategoryName;
    data['fk_vendor__abount_me'] = this._fkVendorAbountMe;
    data['fk_vendor__profile_image'] = this._fkVendorProfileImage;
    data['fk_vendor__business_name'] = this._fkVendorBusinessName;
    data['rating'] = this._rating;
    return data;
  }
}

class ReviewAndFeedback {
  String? _serviceName;
  String? _feedback;
  int? _totalPrice;
  double? _pricePerHour;
  String? _date;
  int? _hour;

  ReviewAndFeedback(
      {String? serviceName,
        String? feedback,
        int? totalPrice,
        double? pricePerHour,
        String? date,
        int? hour}) {
    if (serviceName != null) {
      this._serviceName = serviceName;
    }
    if (feedback != null) {
      this._feedback = feedback;
    }
    if (totalPrice != null) {
      this._totalPrice = totalPrice;
    }
    if (pricePerHour != null) {
      this._pricePerHour = pricePerHour;
    }
    if (date != null) {
      this._date = date;
    }
    if (hour != null) {
      this._hour = hour;
    }
  }

  String? get serviceName => _serviceName;
  set serviceName(String? serviceName) => _serviceName = serviceName;
  String? get feedback => _feedback;
  set feedback(String? feedback) => _feedback = feedback;
  int? get totalPrice => _totalPrice;
  set totalPrice(int? totalPrice) => _totalPrice = totalPrice;
  double? get pricePerHour => _pricePerHour;
  set pricePerHour(double? pricePerHour) => _pricePerHour = pricePerHour;
  String? get date => _date;
  set date(String? date) => _date = date;
  int? get hour => _hour;
  set hour(int? hour) => _hour = hour;

  ReviewAndFeedback.fromJson(Map<String, dynamic> json) {
    _serviceName = json['service_name'];
    _feedback = json['feedback'];
    _totalPrice = json['total_price'];
    _pricePerHour = json['price_per_hour'];
    _date = json['date'];
    _hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this._serviceName;
    data['feedback'] = this._feedback;
    data['total_price'] = this._totalPrice;
    data['price_per_hour'] = this._pricePerHour;
    data['date'] = this._date;
    data['hour'] = this._hour;
    return data;
  }
}
