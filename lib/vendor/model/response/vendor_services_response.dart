class VendorServicesResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  VendorServicesResponse({int? status, String? msg, List<Payload>? payload}) {
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

  VendorServicesResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _fkCategoryId;
  String? _serviceImage;
  String? _serviceName;
  double? _servicePrice;
  String? _serviceTime;
  bool? _serviceStatus;

  Payload(
      {int? id,
        int? fkCategoryId,
        String? serviceImage,
        String? serviceName,
        double? servicePrice,
        String? serviceTime,
        bool? serviceStatus}) {
    if (id != null) {
      this._id = id;
    }
    if (fkCategoryId != null) {
      this._fkCategoryId = fkCategoryId;
    }
    if (serviceImage != null) {
      this._serviceImage = serviceImage;
    }
    if (serviceName != null) {
      this._serviceName = serviceName;
    }
    if (servicePrice != null) {
      this._servicePrice = servicePrice;
    }
    if (serviceTime != null) {
      this._serviceTime = serviceTime;
    }
    if (serviceStatus != null) {
      this._serviceStatus = serviceStatus;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkCategoryId => _fkCategoryId;
  set fkCategoryId(int? fkCategoryId) => _fkCategoryId = fkCategoryId;
  String? get serviceImage => _serviceImage;
  set serviceImage(String? serviceImage) => _serviceImage = serviceImage;
  String? get serviceName => _serviceName;
  set serviceName(String? serviceName) => _serviceName = serviceName;
  double? get servicePrice => _servicePrice;
  set servicePrice(double? servicePrice) => _servicePrice = servicePrice;
  String? get serviceTime => _serviceTime;
  set serviceTime(String? serviceTime) => _serviceTime = serviceTime;
  bool? get serviceStatus => _serviceStatus;
  set serviceStatus(bool? serviceStatus) => _serviceStatus = serviceStatus;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkCategoryId = json['fk_category_id'];
    _serviceImage = json['service_image'];
    _serviceName = json['service_name'];
    _servicePrice = json['service_price'];
    _serviceTime = json['service_time'];
    _serviceStatus = json['service_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_category_id'] = this._fkCategoryId;
    data['service_image'] = this._serviceImage;
    data['service_name'] = this._serviceName;
    data['service_price'] = this._servicePrice;
    data['service_time'] = this._serviceTime;
    data['service_status'] = this._serviceStatus;
    return data;
  }
}