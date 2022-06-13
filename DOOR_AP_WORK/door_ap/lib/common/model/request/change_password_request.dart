class ChangePasswordRequest {
  int? _id;
  String? _oldPassword;
  String? _newPassword;

  ChangePasswordRequest({int? id, String? oldPassword, String? newPassword}) {
    if (id != null) {
      this._id = id;
    }
    if (oldPassword != null) {
      this._oldPassword = oldPassword;
    }
    if (newPassword != null) {
      this._newPassword = newPassword;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get oldPassword => _oldPassword;
  set oldPassword(String? oldPassword) => _oldPassword = oldPassword;
  String? get newPassword => _newPassword;
  set newPassword(String? newPassword) => _newPassword = newPassword;

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _oldPassword = json['old_password'];
    _newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['old_password'] = this._oldPassword;
    data['new_password'] = this._newPassword;
    return data;
  }
}
