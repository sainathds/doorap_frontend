class SeenNotificationRequest {
  int? _notificationId;

  SeenNotificationRequest({int? notificationId}) {
    if (notificationId != null) {
      this._notificationId = notificationId;
    }
  }

  int? get notificationId => _notificationId;
  set notificationId(int? notificationId) => _notificationId = notificationId;

  SeenNotificationRequest.fromJson(Map<String, dynamic> json) {
    _notificationId = json['notification_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this._notificationId;
    return data;
  }
}
