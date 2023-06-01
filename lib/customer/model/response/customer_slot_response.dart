class CustomerSlotResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerSlotResponse({int? status, String? msg, Payload? payload}) {
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
  Payload? get payload => _payload;
  set payload(Payload? payload) => _payload = payload;

  CustomerSlotResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.toJson();
    }
    return data;
  }
}

class Payload {
  List<SlotDetails>? _slotDetails;
  List<Status>? _status;

  Payload({List<SlotDetails>? slotDetails, List<Status>? status}) {
    if (slotDetails != null) {
      this._slotDetails = slotDetails;
    }
    if (status != null) {
      this._status = status;
    }
  }

  List<SlotDetails>? get slotDetails => _slotDetails;
  set slotDetails(List<SlotDetails>? slotDetails) => _slotDetails = slotDetails;
  List<Status>? get status => _status;
  set status(List<Status>? status) => _status = status;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['slot_details'] != null) {
      _slotDetails = <SlotDetails>[];
      json['slot_details'].forEach((v) {
        _slotDetails!.add(new SlotDetails.fromJson(v));
      });
    }
    if (json['status'] != null) {
      _status = <Status>[];
      json['status'].forEach((v) {
        _status!.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._slotDetails != null) {
      data['slot_details'] = this._slotDetails!.map((v) => v.toJson()).toList();
    }
    if (this._status != null) {
      data['status'] = this._status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlotDetails {
  String? _fromTime;
  String? _toTime;

  SlotDetails({String? fromTime, String? toTime}) {
    if (fromTime != null) {
      this._fromTime = fromTime;
    }
    if (toTime != null) {
      this._toTime = toTime;
    }
  }

  String? get fromTime => _fromTime;
  set fromTime(String? fromTime) => _fromTime = fromTime;
  String? get toTime => _toTime;
  set toTime(String? toTime) => _toTime = toTime;

  SlotDetails.fromJson(Map<String, dynamic> json) {
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_time'] = this._fromTime;
    data['to_time'] = this._toTime;
    return data;
  }
}

class Status {
  String? _fromTime;
  String? _toTime;
  bool? _isSaturday;
  bool? _isStatus;

  Status({String? fromTime, String? toTime, bool? isSaturday, bool? isStatus}) {
    if (fromTime != null) {
      this._fromTime = fromTime;
    }
    if (toTime != null) {
      this._toTime = toTime;
    }
    if (isSaturday != null) {
      this._isSaturday = isSaturday;
    }
    if (isStatus != null) {
      this._isStatus = isStatus;
    }
  }

  String? get fromTime => _fromTime;
  set fromTime(String? fromTime) => _fromTime = fromTime;
  String? get toTime => _toTime;
  set toTime(String? toTime) => _toTime = toTime;
  bool? get isSaturday => _isSaturday;
  set isSaturday(bool? isSaturday) => _isSaturday = isSaturday;
  bool? get isStatus => _isStatus;
  set isStatus(bool? isStatus) => _isStatus = isStatus;

  Status.fromJson(Map<String, dynamic> json) {
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _isSaturday = json['is_saturday'];
    _isStatus = json['is_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_time'] = this._fromTime;
    data['to_time'] = this._toTime;
    data['is_saturday'] = this._isSaturday;
    data['is_status'] = this._isStatus;
    return data;
  }
}
