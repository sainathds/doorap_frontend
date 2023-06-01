class CustomerServiceInfoResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerServiceInfoResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerServiceInfoResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<ServiceData>? _serviceData;
  List<IncludeFacility>? _includeFacility;
  List<ExcludeFacility>? _excludeFacility;

  Payload(
      {List<ServiceData>? serviceData,
        List<IncludeFacility>? includeFacility,
        List<ExcludeFacility>? excludeFacility}) {
    if (serviceData != null) {
      this._serviceData = serviceData;
    }
    if (includeFacility != null) {
      this._includeFacility = includeFacility;
    }
    if (excludeFacility != null) {
      this._excludeFacility = excludeFacility;
    }
  }

  List<ServiceData>? get serviceData => _serviceData;
  set serviceData(List<ServiceData>? serviceData) => _serviceData = serviceData;
  List<IncludeFacility>? get includeFacility => _includeFacility;
  set includeFacility(List<IncludeFacility>? includeFacility) =>
      _includeFacility = includeFacility;
  List<ExcludeFacility>? get excludeFacility => _excludeFacility;
  set excludeFacility(List<ExcludeFacility>? excludeFacility) =>
      _excludeFacility = excludeFacility;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['service_data'] != null) {
      _serviceData = <ServiceData>[];
      json['service_data'].forEach((v) {
        _serviceData!.add(new ServiceData.fromJson(v));
      });
    }
    if (json['include_facility'] != null) {
      _includeFacility = <IncludeFacility>[];
      json['include_facility'].forEach((v) {
        _includeFacility!.add(new IncludeFacility.fromJson(v));
      });
    }
    if (json['exclude_facility'] != null) {
      _excludeFacility = <ExcludeFacility>[];
      json['exclude_facility'].forEach((v) {
        _excludeFacility!.add(new ExcludeFacility.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._serviceData != null) {
      data['service_data'] = this._serviceData!.map((v) => v.toJson()).toList();
    }
    if (this._includeFacility != null) {
      data['include_facility'] =
          this._includeFacility!.map((v) => v.toJson()).toList();
    }
    if (this._excludeFacility != null) {
      data['exclude_facility'] =
          this._excludeFacility!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceData {
  int? _id;
  int? _fkVendor;
  int? _fkVendorId;
  int? _fkCategory;
  int? _fkService;
  String? _fkServiceServiceName;
  String? _fkServiceServiceImage;
  double? _price;
  String? _hour;

  ServiceData(
      {int? id,
        int? fkVendor,
        int? fkVendorId,
        int? fkCategory,
        int? fkService,
        String? fkServiceServiceName,
        String? fkServiceServiceImage,
        double? price,
        String? hour}) {
    if (id != null) {
      this._id = id;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (fkVendorId != null) {
      this._fkVendorId = fkVendorId;
    }
    if (fkCategory != null) {
      this._fkCategory = fkCategory;
    }
    if (fkService != null) {
      this._fkService = fkService;
    }
    if (fkServiceServiceName != null) {
      this._fkServiceServiceName = fkServiceServiceName;
    }
    if (fkServiceServiceImage != null) {
      this._fkServiceServiceImage = fkServiceServiceImage;
    }
    if (price != null) {
      this._price = price;
    }
    if (hour != null) {
      this._hour = hour;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkVendor => _fkVendor;
  set fkVendor(int? fkVendor) => _fkVendor = fkVendor;
  int? get fkVendorId => _fkVendorId;
  set fkVendorId(int? fkVendorId) => _fkVendorId = fkVendorId;
  int? get fkCategory => _fkCategory;
  set fkCategory(int? fkCategory) => _fkCategory = fkCategory;
  int? get fkService => _fkService;
  set fkService(int? fkService) => _fkService = fkService;
  String? get fkServiceServiceName => _fkServiceServiceName;
  set fkServiceServiceName(String? fkServiceServiceName) =>
      _fkServiceServiceName = fkServiceServiceName;
  String? get fkServiceServiceImage => _fkServiceServiceImage;
  set fkServiceServiceImage(String? fkServiceServiceImage) =>
      _fkServiceServiceImage = fkServiceServiceImage;
  double? get price => _price;
  set price(double? price) => _price = price;
  String? get hour => _hour;
  set hour(String? hour) => _hour = hour;

  ServiceData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkVendor = json['fk_vendor'];
    _fkVendorId = json['fk_vendor__id'];
    _fkCategory = json['fk_category'];
    _fkService = json['fk_service'];
    _fkServiceServiceName = json['fk_service__service_name'];
    _fkServiceServiceImage = json['fk_service__service_image'];
    _price = json['price'];
    _hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_vendor'] = this._fkVendor;
    data['fk_vendor__id'] = this._fkVendorId;
    data['fk_category'] = this._fkCategory;
    data['fk_service'] = this._fkService;
    data['fk_service__service_name'] = this._fkServiceServiceName;
    data['fk_service__service_image'] = this._fkServiceServiceImage;
    data['price'] = this._price;
    data['hour'] = this._hour;
    return data;
  }
}

class IncludeFacility {
  int? _id;
  int? _fkVenderService;
  int? _fkVenderFacility;
  String? _fkVenderFacilityFacilityName;

  IncludeFacility(
      {int? id,
        int? fkVenderService,
        int? fkVenderFacility,
        String? fkVenderFacilityFacilityName}) {
    if (id != null) {
      this._id = id;
    }
    if (fkVenderService != null) {
      this._fkVenderService = fkVenderService;
    }
    if (fkVenderFacility != null) {
      this._fkVenderFacility = fkVenderFacility;
    }
    if (fkVenderFacilityFacilityName != null) {
      this._fkVenderFacilityFacilityName = fkVenderFacilityFacilityName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkVenderService => _fkVenderService;
  set fkVenderService(int? fkVenderService) =>
      _fkVenderService = fkVenderService;
  int? get fkVenderFacility => _fkVenderFacility;
  set fkVenderFacility(int? fkVenderFacility) =>
      _fkVenderFacility = fkVenderFacility;
  String? get fkVenderFacilityFacilityName => _fkVenderFacilityFacilityName;
  set fkVenderFacilityFacilityName(String? fkVenderFacilityFacilityName) =>
      _fkVenderFacilityFacilityName = fkVenderFacilityFacilityName;

  IncludeFacility.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkVenderService = json['fk_vender_service'];
    _fkVenderFacility = json['fk_vender_facility'];
    _fkVenderFacilityFacilityName = json['fk_vender_facility__facility_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_vender_service'] = this._fkVenderService;
    data['fk_vender_facility'] = this._fkVenderFacility;
    data['fk_vender_facility__facility_name'] =
        this._fkVenderFacilityFacilityName;
    return data;
  }
}

class ExcludeFacility {
  int? _id;
  int? _fkService;
  String? _facilityName;

  ExcludeFacility({int? id, int? fkService, String? facilityName}) {
    if (id != null) {
      this._id = id;
    }
    if (fkService != null) {
      this._fkService = fkService;
    }
    if (facilityName != null) {
      this._facilityName = facilityName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkService => _fkService;
  set fkService(int? fkService) => _fkService = fkService;
  String? get facilityName => _facilityName;
  set facilityName(String? facilityName) => _facilityName = facilityName;

  ExcludeFacility.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkService = json['fk_service'];
    _facilityName = json['facility_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_service'] = this._fkService;
    data['facility_name'] = this._facilityName;
    return data;
  }
}
