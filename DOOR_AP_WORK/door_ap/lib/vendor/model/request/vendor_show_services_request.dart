class VendorShowServiceRequest {
  String? _id;

  VendorShowServiceRequest({String? id}) {
    if (id != null) {
      this._id = id;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;

  VendorShowServiceRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    return data;
  }
}
