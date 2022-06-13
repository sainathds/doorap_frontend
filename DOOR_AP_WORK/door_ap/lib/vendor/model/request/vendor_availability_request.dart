class VendorAvailabilityRequest {
  int? _id;
  String? _isAvailable;

  VendorAvailabilityRequest({int? id, String? isAvailable}) {
    if (id != null) {
      this._id = id;
    }
    if (isAvailable != null) {
      this._isAvailable = isAvailable;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get isAvailable => _isAvailable;
  set isAvailable(String? isAvailable) => _isAvailable = isAvailable;

  VendorAvailabilityRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['is_available'] = this._isAvailable;
    return data;
  }
}
