class VendorSetScheduleRequest {
  String? _vendorId;
  Data? _data;

  VendorSetScheduleRequest({String? vendorId, Data? data}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (data != null) {
      this._data = data;
    }
  }

  String? get vendorId => _vendorId;
  set vendorId(String? vendorId) => _vendorId = vendorId;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  VendorSetScheduleRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _isMonday;
  String? _isTuesday;
  String? _isWednesday;
  String? _isThursday;
  String? _isFriday;
  String? _isSaturday;
  String? _isSunday;
  String? _fromDate;
  String? _toDate;

  Data(
      {String? isMonday,
        String? isTuesday,
        String? isWednesday,
        String? isThursday,
        String? isFriday,
        String? isSaturday,
        String? isSunday,
        String? fromDate,
        String? toDate}) {
    if (isMonday != null) {
      this._isMonday = isMonday;
    }
    if (isTuesday != null) {
      this._isTuesday = isTuesday;
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
    if (fromDate != null) {
      this._fromDate = fromDate;
    }
    if (toDate != null) {
      this._toDate = toDate;
    }
  }

  String? get isMonday => _isMonday;
  set isMonday(String? isMonday) => _isMonday = isMonday;
  String? get isTuesday => _isTuesday;
  set isTuesday(String? isTuesday) => _isTuesday = isTuesday;
  String? get isWednesday => _isWednesday;
  set isWednesday(String? isWednesday) => _isWednesday = isWednesday;
  String? get isThursday => _isThursday;
  set isThursday(String? isThursday) => _isThursday = isThursday;
  String? get isFriday => _isFriday;
  set isFriday(String? isFriday) => _isFriday = isFriday;
  String? get isSaturday => _isSaturday;
  set isSaturday(String? isSaturday) => _isSaturday = isSaturday;
  String? get isSunday => _isSunday;
  set isSunday(String? isSunday) => _isSunday = isSunday;
  String? get fromDate => _fromDate;
  set fromDate(String? fromDate) => _fromDate = fromDate;
  String? get toDate => _toDate;
  set toDate(String? toDate) => _toDate = toDate;

  Data.fromJson(Map<String, dynamic> json) {
    _isMonday = json['is_monday'];
    _isTuesday = json['is_tuesday'];
    _isWednesday = json['is_wednesday'];
    _isThursday = json['is_thursday'];
    _isFriday = json['is_friday'];
    _isSaturday = json['is_saturday'];
    _isSunday = json['is_sunday'];
    _fromDate = json['from_date'];
    _toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_monday'] = this._isMonday;
    data['is_tuesday'] = this._isTuesday;
    data['is_wednesday'] = this._isWednesday;
    data['is_thursday'] = this._isThursday;
    data['is_friday'] = this._isFriday;
    data['is_saturday'] = this._isSaturday;
    data['is_sunday'] = this._isSunday;
    data['from_date'] = this._fromDate;
    data['to_date'] = this._toDate;
    return data;
  }
}
