class CustomerAllServicesResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CustomerAllServicesResponse(
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

  CustomerAllServicesResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _serviceName;
  String? _serviceImage;
  int? _fkCategory;
  String? _fkCategoryCategoryName;

  Payload(
      {int? id,
        String? serviceName,
        String? serviceImage,
        int? fkCategory,
        String? fkCategoryCategoryName}) {
    if (id != null) {
      this._id = id;
    }
    if (serviceName != null) {
      this._serviceName = serviceName;
    }
    if (serviceImage != null) {
      this._serviceImage = serviceImage;
    }
    if (fkCategory != null) {
      this._fkCategory = fkCategory;
    }
    if (fkCategoryCategoryName != null) {
      this._fkCategoryCategoryName = fkCategoryCategoryName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get serviceName => _serviceName;
  set serviceName(String? serviceName) => _serviceName = serviceName;
  String? get serviceImage => _serviceImage;
  set serviceImage(String? serviceImage) => _serviceImage = serviceImage;
  int? get fkCategory => _fkCategory;
  set fkCategory(int? fkCategory) => _fkCategory = fkCategory;
  String? get fkCategoryCategoryName => _fkCategoryCategoryName;
  set fkCategoryCategoryName(String? fkCategoryCategoryName) =>
      _fkCategoryCategoryName = fkCategoryCategoryName;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _serviceName = json['service_name'];
    _serviceImage = json['service_image'];
    _fkCategory = json['fk_category'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['service_name'] = this._serviceName;
    data['service_image'] = this._serviceImage;
    data['fk_category'] = this._fkCategory;
    data['fk_category__category_name'] = this._fkCategoryCategoryName;
    return data;
  }
}
