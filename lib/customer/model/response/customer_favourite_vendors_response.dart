class CustomerFavouriteVendorsResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CustomerFavouriteVendorsResponse(
      {int? status, String? msg, List<Payload>? payload}) {
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

  CustomerFavouriteVendorsResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _id;
  String? _fkVendorFullName;
  String? _fkVendorProfileImage;
  bool? _likeDislike;
  int? _rating;

  Payload(
      {int? id,
        String? fkVendorFullName,
        String? fkVendorProfileImage,
        bool? likeDislike,
        int? rating}) {
    if (id != null) {
      this._id = id;
    }
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkVendorProfileImage != null) {
      this._fkVendorProfileImage = fkVendorProfileImage;
    }
    if (likeDislike != null) {
      this._likeDislike = likeDislike;
    }
    if (rating != null) {
      this._rating = rating;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get fkVendorProfileImage => _fkVendorProfileImage;
  set fkVendorProfileImage(String? fkVendorProfileImage) =>
      _fkVendorProfileImage = fkVendorProfileImage;
  bool? get likeDislike => _likeDislike;
  set likeDislike(bool? likeDislike) => _likeDislike = likeDislike;
  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
    _likeDislike = json['like_dislike'];
    _rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_vendor__profile_image'] = this._fkVendorProfileImage;
    data['like_dislike'] = this._likeDislike;
    data['rating'] = this._rating;
    return data;
  }
}
