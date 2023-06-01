class VendorViewProfileResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;
  String? _isApprove;

  VendorViewProfileResponse(
      {int? status, String? msg, List<Payload>? payload, String? isApprove}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (payload != null) {
      this._payload = payload;
    }
    if (isApprove != null) {
      this._isApprove = isApprove;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Payload>? get payload => _payload;
  set payload(List<Payload>? payload) => _payload = payload;
  String? get isApprove => _isApprove;
  set isApprove(String? isApprove) => _isApprove = isApprove;

  VendorViewProfileResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['payload'] != null) {
      _payload = <Payload>[];
      json['payload'].forEach((v) {
        _payload!.add(new Payload.fromJson(v));
      });
    }
    _isApprove = json['is_approve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.map((v) => v.toJson()).toList();
    }
    data['is_approve'] = this._isApprove;
    return data;
  }
}

class Payload {
  int? _id;
  int? _fkUser;
  String? _fullName;
  String? _profileImage;
  String? _abountMe;
  String? _businessName;
  String? _mobileNo;
  String? _googleAddress;
  double? _googleAddressLat = 0.0;
  double? _googleAddressLng = 0.0;
  String? _addressLineOne;
  String? _addressLineTwo;
  String? _fkCityCityName;
  String? _fkCountryCountryName;
  String? _zipCode;
  String? _userStatus;
  String? _photoIdProof;
  String? _addressProof;
  bool? _isAvailable;
  int? _fkCity;
  int? _fkCountry;
  bool? _isServiceCreated;

  Payload(
      {int? id,
        int? fkUser,
        String? fullName,
        String? profileImage,
        String? abountMe,
        String? businessName,
        String? mobileNo,
        String? googleAddress,
        double? googleAddressLat,
        double? googleAddressLng,
        String? addressLineOne,
        String? addressLineTwo,
        String? fkCityCityName,
        String? fkCountryCountryName,
        String? zipCode,
        String? userStatus,
        String? photoIdProof,
        String? addressProof,
        bool? isAvailable,
        int? fkCity,
        int? fkCountry,
        bool? isServiceCreated
        }) {
    if (id != null) {
      this._id = id;
    }
    if (fkUser != null) {
      this._fkUser = fkUser;
    }
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (profileImage != null) {
      this._profileImage = profileImage;
    }
    if (abountMe != null) {
      this._abountMe = abountMe;
    }
    if (businessName != null) {
      this._businessName = businessName;
    }
    if (mobileNo != null) {
      this._mobileNo = mobileNo;
    }
    if (googleAddress != null) {
      this._googleAddress = googleAddress;
    }
    if (googleAddressLat != null) {
      this._googleAddressLat = googleAddressLat;
    }
    if (googleAddressLng != null) {
      this._googleAddressLng = googleAddressLng;
    }
    if (addressLineOne != null) {
      this._addressLineOne = addressLineOne;
    }
    if (addressLineTwo != null) {
      this._addressLineTwo = addressLineTwo;
    }
    if (fkCityCityName != null) {
      this._fkCityCityName = fkCityCityName;
    }
    if (fkCountryCountryName != null) {
      this._fkCountryCountryName = fkCountryCountryName;
    }
    if (zipCode != null) {
      this._zipCode = zipCode;
    }
    if (userStatus != null) {
      this._userStatus = userStatus;
    }
    if (photoIdProof != null) {
      this._photoIdProof = photoIdProof;
    }
    if (addressProof != null) {
      this._addressProof = addressProof;
    }
    if (isAvailable != null) {
      this._isAvailable = isAvailable;
    }
    if (fkCity != null) {
      this._fkCity = fkCity;
    }
    if (fkCountry != null) {
      this._fkCountry = fkCountry;
    }
    if (isServiceCreated != null) {
      this._isServiceCreated = isServiceCreated;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkUser => _fkUser;
  set fkUser(int? fkUser) => _fkUser = fkUser;
  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get abountMe => _abountMe;
  set abountMe(String? abountMe) => _abountMe = abountMe;
  String? get businessName => _businessName;
  set businessName(String? businessName) => _businessName = businessName;
  String? get mobileNo => _mobileNo;
  set mobileNo(String? mobileNo) => _mobileNo = mobileNo;
  String? get googleAddress => _googleAddress;
  set googleAddress(String? googleAddress) => _googleAddress = googleAddress;
  double? get googleAddressLat => _googleAddressLat;
  set googleAddressLat(double? googleAddressLat) =>
      _googleAddressLat = googleAddressLat;
  double? get googleAddressLng => _googleAddressLng;
  set googleAddressLng(double? googleAddressLng) =>
      _googleAddressLng = googleAddressLng;
  String? get addressLineOne => _addressLineOne;
  set addressLineOne(String? addressLineOne) =>
      _addressLineOne = addressLineOne;
  String? get addressLineTwo => _addressLineTwo;
  set addressLineTwo(String? addressLineTwo) =>
      _addressLineTwo = addressLineTwo;
  String? get fkCityCityName => _fkCityCityName;
  set fkCityCityName(String? fkCityCityName) =>
      _fkCityCityName = fkCityCityName;
  String? get fkCountryCountryName => _fkCountryCountryName;
  set fkCountryCountryName(String? fkCountryCountryName) =>
      _fkCountryCountryName = fkCountryCountryName;
  String? get zipCode => _zipCode;
  set zipCode(String? zipCode) => _zipCode = zipCode;
  String? get userStatus => _userStatus;
  set userStatus(String? userStatus) => _userStatus = userStatus;
  String? get photoIdProof => _photoIdProof;
  set photoIdProof(String? photoIdProof) => _photoIdProof = photoIdProof;
  String? get addressProof => _addressProof;
  set addressProof(String? addressProof) => _addressProof = addressProof;
  bool? get isAvailable => _isAvailable;
  set isAvailable(bool? isAvailable) => _isAvailable = isAvailable;
  int? get fkCity => _fkCity;
  set fkCity(int? fkCity) => _fkCity = fkCity;
  int? get fkCountry => _fkCountry;
  set fkCountry(int? fkCountry) => _fkCountry = fkCountry;
  bool? get isServiceCreated => _isServiceCreated;
  set isServiceCreated(bool? isServiceCreated) => _isServiceCreated = isServiceCreated;


  Payload.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'];
    _fkUser = json['fk_user'];
    _fullName = json['full_name'];
    _profileImage = json['profile_image'];
    _abountMe = json['abount_me'];
    _businessName = json['business_name'];
    _mobileNo = json['mobile_no'];
    _googleAddress = json['google_address'];
    _googleAddressLat = json['google_address_lat'];
    _googleAddressLng = json['google_address_lng'];
    _addressLineOne = json['address_line_one'];
    _addressLineTwo = json['address_line_two'];
    _fkCityCityName = json['fk_city__city_name'];
    _fkCountryCountryName = json['fk_country__country_name'];
    _zipCode = json['zip_code'];
    _userStatus = json['user_status'];
    _photoIdProof = json['photo_id_proof'];
    _addressProof = json['address_proof'];
    _isAvailable = json['is_available'];
    _fkCity = json['fk_city'];
    _fkCountry = json['fk_country'];
    _isServiceCreated = json['is_service_created'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_user'] = this._fkUser;
    data['full_name'] = this._fullName;
    data['profile_image'] = this._profileImage;
    data['abount_me'] = this._abountMe;
    data['business_name'] = this._businessName;
    data['mobile_no'] = this._mobileNo;
    data['google_address'] = this._googleAddress;
    data['google_address_lat'] = this._googleAddressLat;
    data['google_address_lng'] = this._googleAddressLng;
    data['address_line_one'] = this._addressLineOne;
    data['address_line_two'] = this._addressLineTwo;
    data['fk_city__city_name'] = this._fkCityCityName;
    data['fk_country__country_name'] = this._fkCountryCountryName;
    data['zip_code'] = this._zipCode;
    data['user_status'] = this._userStatus;
    data['photo_id_proof'] = this._photoIdProof;
    data['address_proof'] = this._addressProof;
    data['is_available'] = this._isAvailable;
    data['fk_city'] = this._fkCity;
    data['fk_country'] = this._fkCountry;
    data['is_service_created'] = this._isServiceCreated;

    return data;
  }
}
