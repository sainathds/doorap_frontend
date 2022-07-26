class CustomerBannerResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CustomerBannerResponse({int? status, String? msg, List<Payload>? payload}) {
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

  CustomerBannerResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _bannerTitle;
  String? _bannerImage;
  bool? _bannerStatus;

  Payload(
      {int? id, String? bannerTitle, String? bannerImage, bool? bannerStatus}) {
    if (id != null) {
      this._id = id;
    }
    if (bannerTitle != null) {
      this._bannerTitle = bannerTitle;
    }
    if (bannerImage != null) {
      this._bannerImage = bannerImage;
    }
    if (bannerStatus != null) {
      this._bannerStatus = bannerStatus;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get bannerTitle => _bannerTitle;
  set bannerTitle(String? bannerTitle) => _bannerTitle = bannerTitle;
  String? get bannerImage => _bannerImage;
  set bannerImage(String? bannerImage) => _bannerImage = bannerImage;
  bool? get bannerStatus => _bannerStatus;
  set bannerStatus(bool? bannerStatus) => _bannerStatus = bannerStatus;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _bannerTitle = json['banner_title'];
    _bannerImage = json['banner_image'];
    _bannerStatus = json['banner_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['banner_title'] = this._bannerTitle;
    data['banner_image'] = this._bannerImage;
    data['banner_status'] = this._bannerStatus;
    return data;
  }
}
