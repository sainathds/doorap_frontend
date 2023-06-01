class NotificationResponse {
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

  NotificationResponse(
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

  NotificationResponse.fromJson(Map<String, dynamic> json) {
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
