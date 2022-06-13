class VendorSelectedFacilityResponse {
  int? _status;
  String? _msg;
  List<VendorFacility>? _vendorFacility;

  VendorSelectedFacilityResponse(
      {int? status, String? msg, List<VendorFacility>? vendorFacility}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (vendorFacility != null) {
      this._vendorFacility = vendorFacility;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<VendorFacility>? get vendorFacility => _vendorFacility;
  set vendorFacility(List<VendorFacility>? vendorFacility) =>
      _vendorFacility = vendorFacility;

  VendorSelectedFacilityResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['vendor_facility'] != null) {
      _vendorFacility = <VendorFacility>[];
      json['vendor_facility'].forEach((v) {
        _vendorFacility!.add(new VendorFacility.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._vendorFacility != null) {
      data['vendor_facility'] =
          this._vendorFacility!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorFacility {
  int? _id;
  int? _fkVenderService;
  int? _fkVenderFacility;
  String? _fkVenderFacilityFacilityName;

  VendorFacility(
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

  VendorFacility.fromJson(Map<String, dynamic> json) {
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
