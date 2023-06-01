class VendorEditProfileRequest {
  int? _id;
  String? _fullName;
  String? _abountMe;
  String? _profileImage;
  String? _businessName;
  String? _mobileNo;
  String? _googleAddress;
  double? _googleAddressLat;
  double? _googleAddressLng;
  String? _addressLineOne;
  String? _addressLineTwo;
  int? _fkCountry;
  int? _fkCity;
  int? _zipCode;

  VendorEditProfileRequest(
      {int? id,
        String? fullName,
        String? abountMe,
        String? profileImage,
        String? businessName,
        String? mobileNo,
        String? googleAddress,
        double? googleAddressLat,
        double? googleAddressLng,
        String? addressLineOne,
        String? addressLineTwo,
        int? fkCountry,
        int? fkCity,
        int? zipCode}) {
    if (id != null) {
      this._id = id;
    }
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (abountMe != null) {
      this._abountMe = abountMe;
    }
    if (profileImage != null) {
      this._profileImage = profileImage;
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
    if (fkCountry != null) {
      this._fkCountry = fkCountry;
    }
    if (fkCity != null) {
      this._fkCity = fkCity;
    }
    if (zipCode != null) {
      this._zipCode = zipCode;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get abountMe => _abountMe;
  set abountMe(String? abountMe) => _abountMe = abountMe;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
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
  int? get fkCountry => _fkCountry;
  set fkCountry(int? fkCountry) => _fkCountry = fkCountry;
  int? get fkCity => _fkCity;
  set fkCity(int? fkCity) => _fkCity = fkCity;
  int? get zipCode => _zipCode;
  set zipCode(int? zipCode) => _zipCode = zipCode;

  VendorEditProfileRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _abountMe = json['abount_me'];
    _profileImage = json['profile_image'];
    _businessName = json['business_name'];
    _mobileNo = json['mobile_no'];
    _googleAddress = json['google_address'];
    _googleAddressLat = json['google_address_lat'];
    _googleAddressLng = json['google_address_lng'];
    _addressLineOne = json['address_line_one'];
    _addressLineTwo = json['address_line_two'];
    _fkCountry = json['fk_country'];
    _fkCity = json['fk_city'];
    _zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['full_name'] = this._fullName;
    data['abount_me'] = this._abountMe;
    data['profile_image'] = this._profileImage;
    data['business_name'] = this._businessName;
    data['mobile_no'] = this._mobileNo;
    data['google_address'] = this._googleAddress;
    data['google_address_lat'] = this._googleAddressLat;
    data['google_address_lng'] = this._googleAddressLng;
    data['address_line_one'] = this._addressLineOne;
    data['address_line_two'] = this._addressLineTwo;
    data['fk_country'] = this._fkCountry;
    data['fk_city'] = this._fkCity;
    data['zip_code'] = this._zipCode;
    return data;
  }
}
