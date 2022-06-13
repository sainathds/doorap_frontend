class VendorShowServiceResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  VendorShowServiceResponse({int? status, String? msg, Payload? payload}) {
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

  VendorShowServiceResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<VenderService>? _venderService;

  Payload({List<VenderService>? venderService}) {
    if (venderService != null) {
      this._venderService = venderService;
    }
  }

  List<VenderService>? get venderService => _venderService;
  set venderService(List<VenderService>? venderService) =>
      _venderService = venderService;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['vender_service'] != null) {
      _venderService = <VenderService>[];
      json['vender_service'].forEach((v) {
        _venderService!.add(new VenderService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._venderService != null) {
      data['vender_service'] =
          this._venderService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VenderService {
  int? _id;
  int? _fkVendor;
  int? _fkCategory;
  String? _fkCategoryCategoryName;
  int? _fkService;
  String? _fkServiceServiceName;
  String? _fkServiceServiceImage;
  double? _price;
  String? _hour;

  VenderService(
      {int? id,
        int? fkVendor,
        int? fkCategory,
        String? fkCategoryCategoryName,
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
    if (fkCategory != null) {
      this._fkCategory = fkCategory;
    }
    if (fkCategoryCategoryName != null) {
      this._fkCategoryCategoryName = fkCategoryCategoryName;
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
  int? get fkCategory => _fkCategory;
  set fkCategory(int? fkCategory) => _fkCategory = fkCategory;
  String? get fkCategoryCategoryName => _fkCategoryCategoryName;
  set fkCategoryCategoryName(String? fkCategoryCategoryName) =>
      _fkCategoryCategoryName = fkCategoryCategoryName;
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

  VenderService.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkVendor = json['fk_vendor'];
    _fkCategory = json['fk_category'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
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
    data['fk_category'] = this._fkCategory;
    data['fk_category__category_name'] = this._fkCategoryCategoryName;
    data['fk_service'] = this._fkService;
    data['fk_service__service_name'] = this._fkServiceServiceName;
    data['fk_service__service_image'] = this._fkServiceServiceImage;
    data['price'] = this._price;
    data['hour'] = this._hour;
    return data;
  }
}
