class ClearNotificationRequest {
  int? _userId;
  String? _userType;

  ClearNotificationRequest({int? userId, String? userType}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (userType != null) {
      this._userType = userType;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get userType => _userType;
  set userType(String? userType) => _userType = userType;

  ClearNotificationRequest.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['user_type'] = this._userType;
    return data;
  }
}
