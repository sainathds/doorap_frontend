class CustomerCurrentOrderResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CustomerCurrentOrderResponse(
      {int? status, String? msg, List<Payload>? payload}) {
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

  CustomerCurrentOrderResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _orderId;
  int? _fkVendor;
  String? _fkVendorProfileImage;
  String? _fkVendorFullName;
  String? _fkVendorGoogleAddress;
  double? _fkVendorGoogleAddressLat;
  double? _fkVendorGoogleAddressLng;
  String? _fkVendorAddressLineOne;
  String? _fkVendorAddressLineTwo;
  String? _fkVendorFkCountryCountryName;
  String? _fkVendorFkCityCityName;
  int? _duration;
  double? _totalAmount;
  String? _orderStatus;
  Service? _service;
  int? _rating;

  Payload(
      {int? id,
        String? orderId,
        int? fkVendor,
        String? fkVendorProfileImage,
        String? fkVendorFullName,
        String? fkVendorGoogleAddress,
        double? fkVendorGoogleAddressLat,
        double? fkVendorGoogleAddressLng,
        String? fkVendorAddressLineOne,
        String? fkVendorAddressLineTwo,
        String? fkVendorFkCountryCountryName,
        String? fkVendorFkCityCityName,
        int? duration,
        double? totalAmount,
        String? orderStatus,
        Service? service,
        int? rating}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (fkVendorProfileImage != null) {
      this._fkVendorProfileImage = fkVendorProfileImage;
    }
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkVendorGoogleAddress != null) {
      this._fkVendorGoogleAddress = fkVendorGoogleAddress;
    }
    if (fkVendorGoogleAddressLat != null) {
      this._fkVendorGoogleAddressLat = fkVendorGoogleAddressLat;
    }
    if (fkVendorGoogleAddressLng != null) {
      this._fkVendorGoogleAddressLng = fkVendorGoogleAddressLng;
    }
    if (fkVendorAddressLineOne != null) {
      this._fkVendorAddressLineOne = fkVendorAddressLineOne;
    }
    if (fkVendorAddressLineTwo != null) {
      this._fkVendorAddressLineTwo = fkVendorAddressLineTwo;
    }
    if (fkVendorFkCountryCountryName != null) {
      this._fkVendorFkCountryCountryName = fkVendorFkCountryCountryName;
    }
    if (fkVendorFkCityCityName != null) {
      this._fkVendorFkCityCityName = fkVendorFkCityCityName;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (service != null) {
      this._service = service;
    }
    if (rating != null) {
      this._rating = rating;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  int? get fkVendor => _fkVendor;
  set fkVendor(int? fkVendor) => _fkVendor = fkVendor;
  String? get fkVendorProfileImage => _fkVendorProfileImage;
  set fkVendorProfileImage(String? fkVendorProfileImage) =>
      _fkVendorProfileImage = fkVendorProfileImage;
  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get fkVendorGoogleAddress => _fkVendorGoogleAddress;
  set fkVendorGoogleAddress(String? fkVendorGoogleAddress) =>
      _fkVendorGoogleAddress = fkVendorGoogleAddress;
  double? get fkVendorGoogleAddressLat => _fkVendorGoogleAddressLat;
  set fkVendorGoogleAddressLat(double? fkVendorGoogleAddressLat) =>
      _fkVendorGoogleAddressLat = fkVendorGoogleAddressLat;
  double? get fkVendorGoogleAddressLng => _fkVendorGoogleAddressLng;
  set fkVendorGoogleAddressLng(double? fkVendorGoogleAddressLng) =>
      _fkVendorGoogleAddressLng = fkVendorGoogleAddressLng;
  String? get fkVendorAddressLineOne => _fkVendorAddressLineOne;
  set fkVendorAddressLineOne(String? fkVendorAddressLineOne) =>
      _fkVendorAddressLineOne = fkVendorAddressLineOne;
  String? get fkVendorAddressLineTwo => _fkVendorAddressLineTwo;
  set fkVendorAddressLineTwo(String? fkVendorAddressLineTwo) =>
      _fkVendorAddressLineTwo = fkVendorAddressLineTwo;
  String? get fkVendorFkCountryCountryName => _fkVendorFkCountryCountryName;
  set fkVendorFkCountryCountryName(String? fkVendorFkCountryCountryName) =>
      _fkVendorFkCountryCountryName = fkVendorFkCountryCountryName;
  String? get fkVendorFkCityCityName => _fkVendorFkCityCityName;
  set fkVendorFkCityCityName(String? fkVendorFkCityCityName) =>
      _fkVendorFkCityCityName = fkVendorFkCityCityName;
  int? get duration => _duration;
  set duration(int? duration) => _duration = duration;
  double? get totalAmount => _totalAmount;
  set totalAmount(double? totalAmount) => _totalAmount = totalAmount;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  Service? get service => _service;
  set service(Service? service) => _service = service;
  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _fkVendor = json['fk_vendor'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkVendorGoogleAddress = json['fk_vendor__google_address'];
    _fkVendorGoogleAddressLat = json['fk_vendor__google_address_lat'];
    _fkVendorGoogleAddressLng = json['fk_vendor__google_address_lng'];
    _fkVendorAddressLineOne = json['fk_vendor__address_line_one'];
    _fkVendorAddressLineTwo = json['fk_vendor__address_line_two'];
    _fkVendorFkCountryCountryName = json['fk_vendor__fk_country__country_name'];
    _fkVendorFkCityCityName = json['fk_vendor__fk_city__city_name'];
    _duration = json['duration'];
    _totalAmount = json['total_amount'];
    _orderStatus = json['order_status'];
    _service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    _rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['fk_vendor'] = this._fkVendor;
    data['fk_vendor__profile_image'] = this._fkVendorProfileImage;
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_vendor__google_address'] = this._fkVendorGoogleAddress;
    data['fk_vendor__google_address_lat'] = this._fkVendorGoogleAddressLat;
    data['fk_vendor__google_address_lng'] = this._fkVendorGoogleAddressLng;
    data['fk_vendor__address_line_one'] = this._fkVendorAddressLineOne;
    data['fk_vendor__address_line_two'] = this._fkVendorAddressLineTwo;
    data['fk_vendor__fk_country__country_name'] =
        this._fkVendorFkCountryCountryName;
    data['fk_vendor__fk_city__city_name'] = this._fkVendorFkCityCityName;
    data['duration'] = this._duration;
    data['total_amount'] = this._totalAmount;
    data['order_status'] = this._orderStatus;
    if (this._service != null) {
      data['service'] = this._service!.toJson();
    }
    data['rating'] = this._rating;
    return data;
  }
}

class Service {
  List<String>? _serviceName;

  Service({List<String>? serviceName}) {
    if (serviceName != null) {
      this._serviceName = serviceName;
    }
  }

  List<String>? get serviceName => _serviceName;
  set serviceName(List<String>? serviceName) => _serviceName = serviceName;

  Service.fromJson(Map<String, dynamic> json) {
    _serviceName = json['service_name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this._serviceName;
    return data;
  }
}
