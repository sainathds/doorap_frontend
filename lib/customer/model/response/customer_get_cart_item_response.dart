class CustomerGetCartItemResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerGetCartItemResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerGetCartItemResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<CartData>? _cartData;
  List<Calculation>? _calculation;

  Payload({List<CartData>? cartData, List<Calculation>? calculation}) {
    if (cartData != null) {
      this._cartData = cartData;
    }
    if (calculation != null) {
      this._calculation = calculation;
    }
  }

  List<CartData>? get cartData => _cartData;
  set cartData(List<CartData>? cartData) => _cartData = cartData;
  List<Calculation>? get calculation => _calculation;
  set calculation(List<Calculation>? calculation) => _calculation = calculation;

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['cart_data'] != null) {
      _cartData = <CartData>[];
      json['cart_data'].forEach((v) {
        _cartData!.add(new CartData.fromJson(v));
      });
    }
    if (json['calculation'] != null) {
      _calculation = <Calculation>[];
      json['calculation'].forEach((v) {
        _calculation!.add(new Calculation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._cartData != null) {
      data['cart_data'] = this._cartData!.map((v) => v.toJson()).toList();
    }
    if (this._calculation != null) {
      data['calculation'] = this._calculation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? _id;
  int? _fkVendor;
  int? _fkVendorFkCountry;
  String? _fkVendorFkCountryCountryName;
  int? _fkCustomer;
  int? _fkVenderService;
  String? _fkVenderServiceFkServiceServiceName;
  String? _fkVenderServiceFkServiceServiceImage;
  int? _quantity;
  double? _price;
  String? _hour;

  CartData(
      {int? id,
        int? fkVendor,
        int? fkVendorFkCountry,
        String? fkVendorFkCountryCountryName,
        int? fkCustomer,
        int? fkVenderService,
        String? fkVenderServiceFkServiceServiceName,
        String? fkVenderServiceFkServiceServiceImage,
        int? quantity,
        double? price,
        String? hour}) {
    if (id != null) {
      this._id = id;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (fkVendorFkCountry != null) {
      this._fkVendorFkCountry = fkVendorFkCountry;
    }
    if (fkVendorFkCountryCountryName != null) {
      this._fkVendorFkCountryCountryName = fkVendorFkCountryCountryName;
    }
    if (fkCustomer != null) {
      this._fkCustomer = fkCustomer;
    }
    if (fkVenderService != null) {
      this._fkVenderService = fkVenderService;
    }
    if (fkVenderServiceFkServiceServiceName != null) {
      this._fkVenderServiceFkServiceServiceName =
          fkVenderServiceFkServiceServiceName;
    }
    if (fkVenderServiceFkServiceServiceImage != null) {
      this._fkVenderServiceFkServiceServiceImage =
          fkVenderServiceFkServiceServiceImage;
    }
    if (quantity != null) {
      this._quantity = quantity;
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
  int? get fkVendorFkCountry => _fkVendorFkCountry;
  set fkVendorFkCountry(int? fkVendorFkCountry) =>
      _fkVendorFkCountry = fkVendorFkCountry;
  String? get fkVendorFkCountryCountryName => _fkVendorFkCountryCountryName;
  set fkVendorFkCountryCountryName(String? fkVendorFkCountryCountryName) =>
      _fkVendorFkCountryCountryName = fkVendorFkCountryCountryName;
  int? get fkCustomer => _fkCustomer;
  set fkCustomer(int? fkCustomer) => _fkCustomer = fkCustomer;
  int? get fkVenderService => _fkVenderService;
  set fkVenderService(int? fkVenderService) =>
      _fkVenderService = fkVenderService;
  String? get fkVenderServiceFkServiceServiceName =>
      _fkVenderServiceFkServiceServiceName;
  set fkVenderServiceFkServiceServiceName(
      String? fkVenderServiceFkServiceServiceName) =>
      _fkVenderServiceFkServiceServiceName =
          fkVenderServiceFkServiceServiceName;
  String? get fkVenderServiceFkServiceServiceImage =>
      _fkVenderServiceFkServiceServiceImage;
  set fkVenderServiceFkServiceServiceImage(
      String? fkVenderServiceFkServiceServiceImage) =>
      _fkVenderServiceFkServiceServiceImage =
          fkVenderServiceFkServiceServiceImage;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  double? get price => _price;
  set price(double? price) => _price = price;
  String? get hour => _hour;
  set hour(String? hour) => _hour = hour;

  CartData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkVendor = json['fk_vendor'];
    _fkVendorFkCountry = json['fk_vendor__fk_country'];
    _fkVendorFkCountryCountryName = json['fk_vendor__fk_country__country_name'];
    _fkCustomer = json['fk_customer'];
    _fkVenderService = json['fk_vender_service'];
    _fkVenderServiceFkServiceServiceName =
    json['fk_vender_service__fk_service__service_name'];
    _fkVenderServiceFkServiceServiceImage =
    json['fk_vender_service__fk_service__service_image'];
    _quantity = json['quantity'];
    _price = json['price'];
    _hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_vendor'] = this._fkVendor;
    data['fk_vendor__fk_country'] = this._fkVendorFkCountry;
    data['fk_vendor__fk_country__country_name'] =
        this._fkVendorFkCountryCountryName;
    data['fk_customer'] = this._fkCustomer;
    data['fk_vender_service'] = this._fkVenderService;
    data['fk_vender_service__fk_service__service_name'] =
        this._fkVenderServiceFkServiceServiceName;
    data['fk_vender_service__fk_service__service_image'] =
        this._fkVenderServiceFkServiceServiceImage;
    data['quantity'] = this._quantity;
    data['price'] = this._price;
    data['hour'] = this._hour;
    return data;
  }
}

class Calculation {
  int? _averageTime;
  double? _subTotal;
  double? _discount;
  int? _offerId;
  double? _discountPercent;
  int? _itemCount;
  double? _convenienceFee;
  double? _totalAmount;
  int? _appliedId;
  bool? _isPromocdeApplied;
  String? _prmocodeMsg;
  String? _promocode;

  Calculation(
      {int? averageTime,
        double? subTotal,
        double? discount,
        int? offerId,
        double? discountPercent,
        int? itemCount,
        double? convenienceFee,
        double? totalAmount,
        int? appliedId,
        bool? isPromocdeApplied,
        String? prmocodeMsg,
         String? promocode}) {
    if (averageTime != null) {
      this._averageTime = averageTime;
    }
    if (subTotal != null) {
      this._subTotal = subTotal;
    }
    if (discount != null) {
      this._discount = discount;
    }
    if (offerId != null) {
      this._offerId = offerId;
    }
    if (discountPercent != null) {
      this._discountPercent = discountPercent;
    }
    if (itemCount != null) {
      this._itemCount = itemCount;
    }
    if (convenienceFee != null) {
      this._convenienceFee = convenienceFee;
    }
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
    if (appliedId != null) {
      this._appliedId = appliedId;
    }
    if (isPromocdeApplied != null) {
      this._isPromocdeApplied = isPromocdeApplied;
    }
    if (prmocodeMsg != null) {
      this._prmocodeMsg = prmocodeMsg;
    }
    if(promocode != null){
      this._promocode = promocode;
    }
  }

  int? get averageTime => _averageTime;
  set averageTime(int? averageTime) => _averageTime = averageTime;
  double? get subTotal => _subTotal;
  set subTotal(double? subTotal) => _subTotal = subTotal;
  double? get discount => _discount;
  set discount(double? discount) => _discount = discount;
  int? get offerId => _offerId;
  set offerId(int? offerId) => _offerId = offerId;
  double? get discountPercent => _discountPercent;
  set discountPercent(double? discountPercent) =>
      _discountPercent = discountPercent;
  int? get itemCount => _itemCount;
  set itemCount(int? itemCount) => _itemCount = itemCount;
  double? get convenienceFee => _convenienceFee;
  set convenienceFee(double? convenienceFee) =>
      _convenienceFee = convenienceFee;
  double? get totalAmount => _totalAmount;
  set totalAmount(double? totalAmount) => _totalAmount = totalAmount;
  int? get appliedId => _appliedId;
  set appliedId(int? appliedId) => _appliedId = appliedId;
  bool? get isPromocdeApplied => _isPromocdeApplied;
  set isPromocdeApplied(bool? isPromocdeApplied) =>
      _isPromocdeApplied = isPromocdeApplied;
  String? get prmocodeMsg => _prmocodeMsg;
  set prmocodeMsg(String? prmocodeMsg) => _prmocodeMsg = prmocodeMsg;
  String? get promocode => _promocode;
  set promocode(String? promocode) => _promocode = promocode;


  Calculation.fromJson(Map<String, dynamic> json) {
    _averageTime = json['average_time'];
    _subTotal = json['sub_total'];
    _discount = json['discount'];
    _offerId = json['offer_id'];
    _discountPercent = json['discount_percent'];
    _itemCount = json['item_count'];
    _convenienceFee = json['convenience_fee'];
    _totalAmount = json['total_amount'];
    _appliedId = json['applied_id'];
    _isPromocdeApplied = json['is_promocde_applied'];
    _prmocodeMsg = json['prmocode_msg'];
    _promocode = json['promocode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_time'] = this._averageTime;
    data['sub_total'] = this._subTotal;
    data['discount'] = this._discount;
    data['offer_id'] = this._offerId;
    data['discount_percent'] = this._discountPercent;
    data['item_count'] = this._itemCount;
    data['convenience_fee'] = this._convenienceFee;
    data['total_amount'] = this._totalAmount;
    data['applied_id'] = this._appliedId;
    data['is_promocde_applied'] = this._isPromocdeApplied;
    data['prmocode_msg'] = this._prmocodeMsg;
    data['promocode'] = this._promocode;

    return data;
  }
}
