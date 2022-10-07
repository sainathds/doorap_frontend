class ChatNotificationResponse {
  int? _multicastId;
  int? _success;
  int? _failure;
  int? _canonicalIds;
  List<Results>? _results;

  ChatNotificationResponse(
      {int? multicastId,
        int? success,
        int? failure,
        int? canonicalIds,
        List<Results>? results}) {
    if (multicastId != null) {
      this._multicastId = multicastId;
    }
    if (success != null) {
      this._success = success;
    }
    if (failure != null) {
      this._failure = failure;
    }
    if (canonicalIds != null) {
      this._canonicalIds = canonicalIds;
    }
    if (results != null) {
      this._results = results;
    }
  }

  int? get multicastId => _multicastId;
  set multicastId(int? multicastId) => _multicastId = multicastId;
  int? get success => _success;
  set success(int? success) => _success = success;
  int? get failure => _failure;
  set failure(int? failure) => _failure = failure;
  int? get canonicalIds => _canonicalIds;
  set canonicalIds(int? canonicalIds) => _canonicalIds = canonicalIds;
  List<Results>? get results => _results;
  set results(List<Results>? results) => _results = results;

  ChatNotificationResponse.fromJson(Map<dynamic, dynamic> json) {
    _multicastId = json['multicast_id'];
    _success = json['success'];
    _failure = json['failure'];
    _canonicalIds = json['canonical_ids'];
    if (json['results'] != null) {
      _results = <Results>[];
      json['results'].forEach((v) {
        _results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['multicast_id'] = this._multicastId;
    data['success'] = this._success;
    data['failure'] = this._failure;
    data['canonical_ids'] = this._canonicalIds;
    if (this._results != null) {
      data['results'] = this._results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? _messageId;

  Results({String? messageId}) {
    if (messageId != null) {
      this._messageId = messageId;
    }
  }

  String? get messageId => _messageId;
  set messageId(String? messageId) => _messageId = messageId;

  Results.fromJson(Map<String, dynamic> json) {
    _messageId = json['message_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_id'] = this._messageId;
    return data;
  }
}
