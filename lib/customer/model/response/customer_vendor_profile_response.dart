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
  double? _rating;
  String? _averageCount;


  VendorProfile(
      {int? fkVendorId,
        String? fkVendorFullName,
        int? fkCategoryId,
        String? fkCategoryCategoryName,
        String? fkVendorAbountMe,
        String? fkVendorProfileImage,
        String? fkVendorBusinessName,
        double? rating,
        String? averageCount}) {
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
    if (averageCount != null) {
      this._averageCount = averageCount;
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
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  String? get averageCount => _averageCount;
  set averageCount(String? averageCount) => _averageCount = averageCount;


  VendorProfile.fromJson(Map<String, dynamic> json) {
    _fkVendorId = json['fk_vendor__id'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkCategoryId = json['fk_category__id'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
    _fkVendorAbountMe = json['fk_vendor__abount_me'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
    _fkVendorBusinessName = json['fk_vendor__business_name'];
    _rating = json['rating'];
    _averageCount = json['average_count'];

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
    data['average_count'] = this._averageCount;

    return data;
  }
}

class ReviewAndFeedback {
  String? _fkOrderdetailsFkCategoryCategoryName;
  String? _feedback;
  String? _reviewDate;
  double? _rating;

  ReviewAndFeedback(
      {String? fkOrderdetailsFkCategoryCategoryName,
        String? feedback,
        String? reviewDate,
        double? rating}) {
    if (fkOrderdetailsFkCategoryCategoryName != null) {
      this._fkOrderdetailsFkCategoryCategoryName =
          fkOrderdetailsFkCategoryCategoryName;
    }
    if (feedback != null) {
      this._feedback = feedback;
    }
    if (reviewDate != null) {
      this._reviewDate = reviewDate;
    }
    if (rating != null) {
      this._rating = rating;
    }
  }

  String? get fkOrderdetailsFkCategoryCategoryName =>
      _fkOrderdetailsFkCategoryCategoryName;
  set fkOrderdetailsFkCategoryCategoryName(
      String? fkOrderdetailsFkCategoryCategoryName) =>
      _fkOrderdetailsFkCategoryCategoryName =
          fkOrderdetailsFkCategoryCategoryName;
  String? get feedback => _feedback;
  set feedback(String? feedback) => _feedback = feedback;
  String? get reviewDate => _reviewDate;
  set reviewDate(String? reviewDate) => _reviewDate = reviewDate;
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;

  ReviewAndFeedback.fromJson(Map<String, dynamic> json) {
    _fkOrderdetailsFkCategoryCategoryName =
    json['fk_orderdetails__fk_category__category_name'];
    _feedback = json['feedback'];
    _reviewDate = json['review_date'];
    _rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_orderdetails__fk_category__category_name'] =
        this._fkOrderdetailsFkCategoryCategoryName;
    data['feedback'] = this._feedback;
    data['review_date'] = this._reviewDate;
    data['rating'] = this._rating;
    return data;
  }
}