class NotificationCountResponse {
  int? _status;
  String? _msg;
  int? _notificationCount;

  NotificationCountResponse(
      {int? status, String? msg, int? notificationCount}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (notificationCount != null) {
      this._notificationCount = notificationCount;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  int? get notificationCount => _notificationCount;
  set notificationCount(int? notificationCount) =>
      _notificationCount = notificationCount;

  NotificationCountResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _notificationCount = json['notification_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    data['notification_count'] = this._notificationCount;
    return data;
  }
}
