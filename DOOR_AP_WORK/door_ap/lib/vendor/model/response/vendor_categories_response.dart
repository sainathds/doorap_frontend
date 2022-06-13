class VendorCategoriesResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  VendorCategoriesResponse({int? status, String? msg, List<Payload>? payload}) {
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

  VendorCategoriesResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _categoryName;
  String? _categoryImage;
  bool? _categoryStatus;

  Payload(
      {int? id,
        String? categoryName,
        String? categoryImage,
        bool? categoryStatus}) {
    if (id != null) {
      this._id = id;
    }
    if (categoryName != null) {
      this._categoryName = categoryName;
    }
    if (categoryImage != null) {
      this._categoryImage = categoryImage;
    }
    if (categoryStatus != null) {
      this._categoryStatus = categoryStatus;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get categoryName => _categoryName;
  set categoryName(String? categoryName) => _categoryName = categoryName;
  String? get categoryImage => _categoryImage;
  set categoryImage(String? categoryImage) => _categoryImage = categoryImage;
  bool? get categoryStatus => _categoryStatus;
  set categoryStatus(bool? categoryStatus) => _categoryStatus = categoryStatus;

  Payload.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'];
    _categoryName = json['category_name'];
    _categoryImage = json['category_image'];
    _categoryStatus = json['category_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['category_name'] = this._categoryName;
    data['category_image'] = this._categoryImage;
    data['category_status'] = this._categoryStatus;
    return data;
  }
}
