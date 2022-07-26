class CustomerVendorServicesResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerVendorServicesResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerVendorServicesResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<VenderData>? _venderData;
  List<ServiceData>? _serviceData;

  Payload({List<VenderData>? venderData, List<ServiceData>? serviceData}) {
    if (venderData != null) {
      this._venderData = venderData;
    }
    if (serviceData != null) {
      this._serviceData = serviceData;
    }
  }

  List<VenderData>? get venderData => _venderData;
  set venderData(List<VenderData>? venderData) => _venderData = venderData;
  List<ServiceData>? get serviceData => _serviceData;
  set serviceData(List<ServiceData>? serviceData) => _serviceData = serviceData;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['vender_data'] != null) {
      _venderData = <VenderData>[];
      json['vender_data'].forEach((v) {
        _venderData!.add(new VenderData.fromJson(v));
      });
    }
    if (json['service_data'] != null) {
      _serviceData = <ServiceData>[];
      json['service_data'].forEach((v) {
        _serviceData!.add(new ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._venderData != null) {
      data['vender_data'] = this._venderData!.map((v) => v.toJson()).toList();
    }
    if (this._serviceData != null) {
      data['service_data'] = this._serviceData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VenderData {
  int? _fkCategoryId;
  String? _fkCategoryCategoryName;
  int? _fkVendorId;
  String? _fkVendorFullName;
  String? _fkVendorProfileImage;

  VenderData(
      {int? fkCategoryId,
        String? fkCategoryCategoryName,
        int? fkVendorId,
        String? fkVendorFullName,
        String? fkVendorProfileImage}) {
    if (fkCategoryId != null) {
      this._fkCategoryId = fkCategoryId;
    }
    if (fkCategoryCategoryName != null) {
      this._fkCategoryCategoryName = fkCategoryCategoryName;
    }
    if (fkVendorId != null) {
      this._fkVendorId = fkVendorId;
    }
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkVendorProfileImage != null) {
      this._fkVendorProfileImage = fkVendorProfileImage;
    }
  }

  int? get fkCategoryId => _fkCategoryId;
  set fkCategoryId(int? fkCategoryId) => _fkCategoryId = fkCategoryId;
  String? get fkCategoryCategoryName => _fkCategoryCategoryName;
  set fkCategoryCategoryName(String? fkCategoryCategoryName) =>
      _fkCategoryCategoryName = fkCategoryCategoryName;
  int? get fkVendorId => _fkVendorId;
  set fkVendorId(int? fkVendorId) => _fkVendorId = fkVendorId;
  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get fkVendorProfileImage => _fkVendorProfileImage;
  set fkVendorProfileImage(String? fkVendorProfileImage) =>
      _fkVendorProfileImage = fkVendorProfileImage;

  VenderData.fromJson(Map<String, dynamic> json) {
    _fkCategoryId = json['fk_category__id'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
    _fkVendorId = json['fk_vendor__id'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_category__id'] = this._fkCategoryId;
    data['fk_category__category_name'] = this._fkCategoryCategoryName;
    data['fk_vendor__id'] = this._fkVendorId;
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_vendor__profile_image'] = this._fkVendorProfileImage;
    return data;
  }
}

class ServiceData {
  int? _id;
  int? _fkServiceId;
  String? _fkServiceServiceName;
  String? _fkServiceServiceImage;

  ServiceData(
      {int? id,
        int? fkServiceId,
        String? fkServiceServiceName,
        String? fkServiceServiceImage}) {
    if (id != null) {
      this._id = id;
    }
    if (fkServiceId != null) {
      this._fkServiceId = fkServiceId;
    }
    if (fkServiceServiceName != null) {
      this._fkServiceServiceName = fkServiceServiceName;
    }
    if (fkServiceServiceImage != null) {
      this._fkServiceServiceImage = fkServiceServiceImage;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkServiceId => _fkServiceId;
  set fkServiceId(int? fkServiceId) => _fkServiceId = fkServiceId;
  String? get fkServiceServiceName => _fkServiceServiceName;
  set fkServiceServiceName(String? fkServiceServiceName) =>
      _fkServiceServiceName = fkServiceServiceName;
  String? get fkServiceServiceImage => _fkServiceServiceImage;
  set fkServiceServiceImage(String? fkServiceServiceImage) =>
      _fkServiceServiceImage = fkServiceServiceImage;

  ServiceData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkServiceId = json['fk_service__id'];
    _fkServiceServiceName = json['fk_service__service_name'];
    _fkServiceServiceImage = json['fk_service__service_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_service__id'] = this._fkServiceId;
    data['fk_service__service_name'] = this._fkServiceServiceName;
    data['fk_service__service_image'] = this._fkServiceServiceImage;
    return data;
  }
}
