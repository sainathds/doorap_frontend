class CustomerSlotAvailableResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerSlotAvailableResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerSlotAvailableResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<VendorData>? _vendorData;
  List<Data>? _data;

  Payload({List<VendorData>? vendorData, List<Data>? data}) {
    if (vendorData != null) {
      this._vendorData = vendorData;
    }
    if (data != null) {
      this._data = data;
    }
  }

  List<VendorData>? get vendorData => _vendorData;
  set vendorData(List<VendorData>? vendorData) => _vendorData = vendorData;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['vendor_data'] != null) {
      _vendorData = <VendorData>[];
      json['vendor_data'].forEach((v) {
        _vendorData!.add(new VendorData.fromJson(v));
      });
    }
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._vendorData != null) {
      data['vendor_data'] = this._vendorData!.map((v) => v.toJson()).toList();
    }
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorData {
  String? _fullName;
  String? _profileImage;
  String? _categoryName;

  VendorData({String? fullName, String? profileImage, String? categoryName}) {
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (profileImage != null) {
      this._profileImage = profileImage;
    }
    if (categoryName != null) {
      this._categoryName = categoryName;
    }
  }

  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get categoryName => _categoryName;
  set categoryName(String? categoryName) => _categoryName = categoryName;

  VendorData.fromJson(Map<String, dynamic> json) {
    _fullName = json['full_name'];
    _profileImage = json['profile_image'];
    _categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this._fullName;
    data['profile_image'] = this._profileImage;
    data['category_name'] = this._categoryName;
    return data;
  }
}

class Data {
  String? _date;
  List<SlotDetails>? _slotDetails;
  Status? _status;

  Data({String? date, List<SlotDetails>? slotDetails, Status? status}) {
    if (date != null) {
      this._date = date;
    }
    if (slotDetails != null) {
      this._slotDetails = slotDetails;
    }
    if (status != null) {
      this._status = status;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  List<SlotDetails>? get slotDetails => _slotDetails;
  set slotDetails(List<SlotDetails>? slotDetails) => _slotDetails = slotDetails;
  Status? get status => _status;
  set status(Status? status) => _status = status;

  Data.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    if (json['slot_details'] != null) {
      _slotDetails = <SlotDetails>[];
      json['slot_details'].forEach((v) {
        _slotDetails!.add(new SlotDetails.fromJson(v));
      });
    }
    _status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this._date;
    if (this._slotDetails != null) {
      data['slot_details'] = this._slotDetails!.map((v) => v.toJson()).toList();
    }
    if (this._status != null) {
      data['status'] = this._status!.toJson();
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
  bool? _isTuesday;
  bool? _isStatus;
  bool? _isWednesday;
  bool? _isThursday;
  bool? _isFriday;
  bool? _isSaturday;
  bool? _isSunday;
  bool? _isMonday;

  Status(
      {String? fromTime,
        String? toTime,
        bool? isTuesday,
        bool? isStatus,
        bool? isWednesday,
        bool? isThursday,
        bool? isFriday,
        bool? isSaturday,
        bool? isSunday,
        bool? isMonday}) {
    if (fromTime != null) {
      this._fromTime = fromTime;
    }
    if (toTime != null) {
      this._toTime = toTime;
    }
    if (isTuesday != null) {
      this._isTuesday = isTuesday;
    }
    if (isStatus != null) {
      this._isStatus = isStatus;
    }
    if (isWednesday != null) {
      this._isWednesday = isWednesday;
    }
    if (isThursday != null) {
      this._isThursday = isThursday;
    }
    if (isFriday != null) {
      this._isFriday = isFriday;
    }
    if (isSaturday != null) {
      this._isSaturday = isSaturday;
    }
    if (isSunday != null) {
      this._isSunday = isSunday;
    }
    if (isMonday != null) {
      this._isMonday = isMonday;
    }
  }

  String? get fromTime => _fromTime;
  set fromTime(String? fromTime) => _fromTime = fromTime;
  String? get toTime => _toTime;
  set toTime(String? toTime) => _toTime = toTime;
  bool? get isTuesday => _isTuesday;
  set isTuesday(bool? isTuesday) => _isTuesday = isTuesday;
  bool? get isStatus => _isStatus;
  set isStatus(bool? isStatus) => _isStatus = isStatus;
  bool? get isWednesday => _isWednesday;
  set isWednesday(bool? isWednesday) => _isWednesday = isWednesday;
  bool? get isThursday => _isThursday;
  set isThursday(bool? isThursday) => _isThursday = isThursday;
  bool? get isFriday => _isFriday;
  set isFriday(bool? isFriday) => _isFriday = isFriday;
  bool? get isSaturday => _isSaturday;
  set isSaturday(bool? isSaturday) => _isSaturday = isSaturday;
  bool? get isSunday => _isSunday;
  set isSunday(bool? isSunday) => _isSunday = isSunday;
  bool? get isMonday => _isMonday;
  set isMonday(bool? isMonday) => _isMonday = isMonday;

  Status.fromJson(Map<String, dynamic> json) {
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _isTuesday = json['is_tuesday'];
    _isStatus = json['is_status'];
    _isWednesday = json['is_wednesday'];
    _isThursday = json['is_thursday'];
    _isFriday = json['is_friday'];
    _isSaturday = json['is_saturday'];
    _isSunday = json['is_sunday'];
    _isMonday = json['is_monday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_time'] = this._fromTime;
    data['to_time'] = this._toTime;
    data['is_tuesday'] = this._isTuesday;
    data['is_status'] = this._isStatus;
    data['is_wednesday'] = this._isWednesday;
    data['is_thursday'] = this._isThursday;
    data['is_friday'] = this._isFriday;
    data['is_saturday'] = this._isSaturday;
    data['is_sunday'] = this._isSunday;
    data['is_monday'] = this._isMonday;
    return data;
  }
}
