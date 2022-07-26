class VendorCurrentOrderResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  VendorCurrentOrderResponse(
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

  VendorCurrentOrderResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _fkCustomer;
  String? _fkCustomerName;
  int? _duration;
  String? _customerCity;
  String? _customerCountry;
  double? _lat;
  double? _lng;
  String? _zipCode;
  String? _address;
  double? _vendorPayAmount;
  String? _orderStatus;
  Service? _service;

  Payload(
      {int? id,
        String? orderId,
        int? fkVendor,
        int? fkCustomer,
        String? fkCustomerName,
        int? duration,
        String? customerCity,
        String? customerCountry,
        double? lat,
        double? lng,
        String? zipCode,
        String? address,
        double? vendorPayAmount,
        String? orderStatus,
        Service? service}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (fkCustomer != null) {
      this._fkCustomer = fkCustomer;
    }
    if (fkCustomerName != null) {
      this._fkCustomerName = fkCustomerName;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (customerCity != null) {
      this._customerCity = customerCity;
    }
    if (customerCountry != null) {
      this._customerCountry = customerCountry;
    }
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
    }
    if (zipCode != null) {
      this._zipCode = zipCode;
    }
    if (address != null) {
      this._address = address;
    }
    if (vendorPayAmount != null) {
      this._vendorPayAmount = vendorPayAmount;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (service != null) {
      this._service = service;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  int? get fkVendor => _fkVendor;
  set fkVendor(int? fkVendor) => _fkVendor = fkVendor;
  int? get fkCustomer => _fkCustomer;
  set fkCustomer(int? fkCustomer) => _fkCustomer = fkCustomer;
  String? get fkCustomerName => _fkCustomerName;
  set fkCustomerName(String? fkCustomerName) =>
      _fkCustomerName = fkCustomerName;
  int? get duration => _duration;
  set duration(int? duration) => _duration = duration;
  String? get customerCity => _customerCity;
  set customerCity(String? fkCityCityName) =>
      _customerCity = customerCity;
  String? get customerCountry => _customerCountry;
  set customerCountry(String? customerCountry) =>
      _customerCountry = customerCountry;
  double? get lat => _lat;
  set lat(double? lat) => _lat = lat;
  double? get lng => _lng;
  set lng(double? lng) => _lng = lng;
  String? get zipCode => _zipCode;
  set zipCode(String? zipCode) => _zipCode = zipCode;
  String? get address => _address;
  set address(String? address) => _address = address;
  double? get vendorPayAmount => _vendorPayAmount;
  set vendorPayAmount(double? vendorPayAmount) =>
      _vendorPayAmount = vendorPayAmount;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  Service? get service => _service;
  set service(Service? service) => _service = service;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _fkVendor = json['fk_vendor'];
    _fkCustomer = json['fk_customer'];
    _fkCustomerName = json['fk_customer__name'];
    _duration = json['duration'];
    _customerCity = json['customer_city'];
    _customerCountry = json['customer_country'];
    _lat = json['lat'];
    _lng = json['lng'];
    _zipCode = json['zip_code'];
    _address = json['address'];
    _vendorPayAmount = json['vendor_pay_amount'];
    _orderStatus = json['order_status'];
    _service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['fk_vendor'] = this._fkVendor;
    data['fk_customer'] = this._fkCustomer;
    data['fk_customer__name'] = this._fkCustomerName;
    data['duration'] = this._duration;
    data['customer_city'] = this._customerCity;
    data['customer_country'] = this._customerCountry;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['zip_code'] = this._zipCode;
    data['address'] = this._address;
    data['vendor_pay_amount'] = this._vendorPayAmount;
    data['order_status'] = this._orderStatus;
    if (this._service != null) {
      data['service'] = this._service!.toJson();
    }
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
