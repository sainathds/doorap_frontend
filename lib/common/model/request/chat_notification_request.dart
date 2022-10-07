class ChatNotificationRequest{

  Data? data;
  Notification? notification;
  List<String>? registrationIds;

  ChatNotificationRequest({required this.data, required this.notification, required this.registrationIds});

  ChatNotificationRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    notification = json['notification'];
    registrationIds = json['registration_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['data'] = this.data;
    map['notification'] = this.notification;
    map['registration_ids'] = this.registrationIds;
    return map;
  }
}


class Data{
  String? _orderStatus;
  String? _userType;
  String? _actionId;
  String? _imageUrl;
  String? _sound;
  String? _action;
  String? _body;
  String? _title;
  String? _clickAction;
  String? _androidChannelId;
  String? _currentDatetime;

  Data(
      {String? orderStatus,
        String? userType,
        String? actionId,
        String? imageUrl,
        String? sound,
        String? action,
        String? body,
        String? title,
        String? clickAction,
        String? androidChannelId,
        String? currentDatetime}) {
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (userType != null) {
      this._userType = userType;
    }
    if (actionId != null) {
      this._actionId = actionId;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
    if (sound != null) {
      this._sound = sound;
    }
    if (action != null) {
      this._action = action;
    }
    if (body != null) {
      this._body = body;
    }
    if (title != null) {
      this._title = title;
    }
    if (clickAction != null) {
      this._clickAction = clickAction;
    }
    if (androidChannelId != null) {
      this._androidChannelId = androidChannelId;
    }
    if (currentDatetime != null) {
      this._currentDatetime = currentDatetime;
    }
  }

  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get userType => _userType;
  set userType(String? userType) => _userType = userType;
  String? get actionId => _actionId;
  set actionId(String? actionId) => _actionId = actionId;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  String? get sound => _sound;
  set sound(String? sound) => _sound = sound;
  String? get action => _action;
  set action(String? action) => _action = action;
  String? get body => _body;
  set body(String? body) => _body = body;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get clickAction => _clickAction;
  set clickAction(String? clickAction) => _clickAction = clickAction;
  String? get androidChannelId => _androidChannelId;
  set androidChannelId(String? androidChannelId) =>
      _androidChannelId = androidChannelId;
  String? get currentDatetime => _currentDatetime;
  set currentDatetime(String? currentDatetime) =>
      _currentDatetime = currentDatetime;

  Data.fromJson(Map<String, dynamic> json) {
    _orderStatus = json['order_status'];
    _userType = json['user_type'];
    _actionId = json['action_id'];
    _imageUrl = json['image_url'];
    _sound = json['sound'];
    _action = json['action'];
    _body = json['body'];
    _title = json['title'];
    _clickAction = json['click_action'];
    _androidChannelId = json['android_channel_id'];
    _currentDatetime = json['current_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_status'] = this._orderStatus;
    data['user_type'] = this._userType;
    data['action_id'] = this._actionId;
    data['image_url'] = this._imageUrl;
    data['sound'] = this._sound;
    data['action'] = this._action;
    data['body'] = this._body;
    data['title'] = this._title;
    data['click_action'] = this._clickAction;
    data['android_channel_id'] = this._androidChannelId;
    data['current_datetime'] = this._currentDatetime;
    return data;
  }
}


class Notification {
  String? title;
  String? body;
  /*String? sound;
  bool? contentAvailable;
  String? androidChannelId;
  String? clickAction;
*/
  Notification(
      { required this.title,
        required this.body,
        /*required this.sound,
        required this.contentAvailable,
        required this.clickAction,
        required this.androidChannelId*/});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    /*sound = json['sound'];
    contentAvailable = json['content_available'];
    clickAction = json['clickAction'];
    androidChannelId = json['android_channel_id'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    /*data['sound'] = this.sound;
    data['content_available'] = this.contentAvailable;
    data['clickAction'] = this.clickAction;
    data['android_channel_id'] = this.androidChannelId;*/
    return data;
  }
}

