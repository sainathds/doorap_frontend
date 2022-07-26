class CustomerNextSixDaysResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerNextSixDaysResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerNextSixDaysResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<VendorData>? _vendorData;
  List<String>? _date;

  Payload({List<VendorData>? vendorData, List<String>? date}) {
    if (vendorData != null) {
      this._vendorData = vendorData;
    }
    if (date != null) {
      this._date = date;
    }
  }

  List<VendorData>? get vendorData => _vendorData;
  set vendorData(List<VendorData>? vendorData) => _vendorData = vendorData;
  List<String>? get date => _date;
  set date(List<String>? date) => _date = date;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['vendor_data'] != null) {
      _vendorData = <VendorData>[];
      json['vendor_data'].forEach((v) {
        _vendorData!.add(new VendorData.fromJson(v));
      });
    }
    _date = json['date'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._vendorData != null) {
      data['vendor_data'] = this._vendorData!.map((v) => v.toJson()).toList();
    }
    data['date'] = this._date;
    return data;
  }
}

class VendorData {
  String? _fullName;
  String? _profileImage;
  String? _categoryName;

  VendorData({String? fullName, String? profileImage, String? categoryName}) {
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (profileImage != null) {
      this._profileImage = profileImage;
    }
    if (categoryName != null) {
      this._categoryName = categoryName;
    }
  }

  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get categoryName => _categoryName;
  set categoryName(String? categoryName) => _categoryName = categoryName;

  VendorData.fromJson(Map<String, dynamic> json) {
    _fullName = json['full_name'];
    _profileImage = json['profile_image'];
    _categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this._fullName;
    data['profile_image'] = this._profileImage;
    data['category_name'] = this._categoryName;
    return data;
  }
}
