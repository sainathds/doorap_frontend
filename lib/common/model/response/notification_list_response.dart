class NotificationListResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  NotificationListResponse({int? status, String? msg, List<Payload>? payload}) {
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

  NotificationListResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _fkUser;
  int? _fkOrderId;
  String? _fkOrderOrderId;
  String? _titleName ;
  String? _notification;
  String? _notificationDate;
  bool? _isSeen;
  String? _userType;
  String? _notificationDays;

  Payload(
      {int? id,
        int? fkUser,
        int? fkOrderId,
        String? fkOrderOrderId,
        String? titleName,
        String? notification,
        String? notificationDate,
        bool? isSeen,
        String? userType,
        String? notificationDays}) {
    if (id != null) {
      this._id = id;
    }
    if (fkUser != null) {
      this._fkUser = fkUser;
    }
    if (fkOrderId != null) {
      this._fkOrderId = fkOrderId;
    }
    if (fkOrderOrderId != null) {
      this._fkOrderOrderId = fkOrderOrderId;
    }
    if (titleName != null) {
      this._titleName = titleName;
    }
    if (notification != null) {
      this._notification = notification;
    }
    if (notificationDate != null) {
      this._notificationDate = notificationDate;
    }
    if (isSeen != null) {
      this._isSeen = isSeen;
    }
    if (userType != null) {
      this._userType = userType;
    }
    if (notificationDays != null) {
      this._notificationDays = notificationDays;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkUser => _fkUser;
  set fkUser(int? fkUser) => _fkUser = fkUser;
  int? get fkOrderId => _fkOrderId;
  set fkOrderId(int? fkOrderId) => _fkOrderId = fkOrderId;
  String? get fkOrderOrderId => _fkOrderOrderId;
  set fkOrderOrderId(String? fkOrderOrderId) =>
      _fkOrderOrderId = fkOrderOrderId;
  String? get titleName => _titleName;
  set titleName(String? titleName) => _titleName = titleName;
  String? get notification => _notification;
  set notification(String? notification) => _notification = notification;
  String? get notificationDate => _notificationDate;
  set notificationDate(String? notificationDate) =>
      _notificationDate = notificationDate;
  bool? get isSeen => _isSeen;
  set isSeen(bool? isSeen) => _isSeen = isSeen;
  String? get userType => _userType;
  set userType(String? userType) => _userType = userType;
  String? get notificationDays => _notificationDays;
  set notificationDays(String? notificationDays) =>
      _notificationDays = notificationDays;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkUser = json['fk_user'];
    _fkOrderId = json['fk_order__id'];
    _fkOrderOrderId = json['fk_order__order_id'];
    _titleName = json['title_name'];
    _notification = json['notification'];
    _notificationDate = json['notification_date'];
    _isSeen = json['is_seen'];
    _userType = json['user_type'];
    _notificationDays = json['notification_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_user'] = this._fkUser;
    data['fk_order__id'] = this._fkOrderId;
    data['fk_order__order_id'] = this._fkOrderOrderId;
    data['title_name'] = this._titleName;
    data['notification'] = this._notification;
    data['notification_date'] = this._notificationDate;
    data['is_seen'] = this._isSeen;
    data['user_type'] = this._userType;
    data['notification_days'] = this._notificationDays;
    return data;
  }
}
