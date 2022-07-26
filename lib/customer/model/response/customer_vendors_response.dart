class CustomerVendorsResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CustomerVendorsResponse({int? status, String? msg, List<Payload>? payload}) {
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
  List<Payload>? get payload => _payload;
  set payload(List<Payload>? payload) => _payload = payload;

  CustomerVendorsResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['payload'] != null) {
      _payload = <Payload>[];
      json['payload'].forEach((v) {
        _payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  int? _fkVendorId;
  String? _fkVendorFullName;
  String? _fkVendorProfileImage;
  String? _fkCategoryCategoryName;
  double? _rating;
  bool? _likeDislike;

  Payload(
      {int? fkVendorId,
        String? fkVendorFullName,
        String? fkVendorProfileImage,
        String? fkCategoryCategoryName,
        double? rating,
        bool? likeDislike}) {
    if (fkVendorId != null) {
      this._fkVendorId = fkVendorId;
    }
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkVendorProfileImage != null) {
      this._fkVendorProfileImage = fkVendorProfileImage;
    }
    if (fkCategoryCategoryName != null) {
      this._fkCategoryCategoryName = fkCategoryCategoryName;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (likeDislike != null) {
      this._likeDislike = likeDislike;
    }
  }

  int? get fkVendorId => _fkVendorId;
  set fkVendorId(int? fkVendorId) => _fkVendorId = fkVendorId;
  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get fkVendorProfileImage => _fkVendorProfileImage;
  set fkVendorProfileImage(String? fkVendorProfileImage) =>
      _fkVendorProfileImage = fkVendorProfileImage;
  String? get fkCategoryCategoryName => _fkCategoryCategoryName;
  set fkCategoryCategoryName(String? fkCategoryCategoryName) =>
      _fkCategoryCategoryName = fkCategoryCategoryName;
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  bool? get likeDislike => _likeDislike;
  set likeDislike(bool? likeDislike) => _likeDislike = likeDislike;

  Payload.fromJson(Map<String, dynamic> json) {
    _fkVendorId = json['fk_vendor__id'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
    _rating = json['rating'];
    _likeDislike = json['like_dislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_vendor__id'] = this._fkVendorId;
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_vendor__profile_image'] = this._fkVendorProfileImage;
    data['fk_category__category_name'] = this._fkCategoryCategoryName;
    data['rating'] = this._rating;
    data['like_dislike'] = this._likeDislike;
    return data;
  }
}
