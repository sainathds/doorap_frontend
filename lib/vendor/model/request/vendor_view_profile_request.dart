class VendorViewProfileRequest {
  int? _id;

  VendorViewProfileRequest({int? id}) {
    if (id != null) {
      this._id = id;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;

  VendorViewProfileRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    return data;
  }
}
