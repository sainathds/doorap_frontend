class VendorSaveProfileResponse {
  int? _status;
  String? _msg;

  VendorSaveProfileResponse({int? status, String? msg}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  VendorSaveProfileResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    return data;
  }
}
