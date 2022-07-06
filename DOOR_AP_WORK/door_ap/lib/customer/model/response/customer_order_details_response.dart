class CustomerOrderDetailsResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerOrderDetailsResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerOrderDetailsResponse.fromJson(Map<dynamic, dynamic> json) {
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
  OrderData? _orderData;
  List<OrderService>? _orderService;
  VendorDetails? _vendorDetails;
  PaymentInformation? _paymentInformation;

  Payload(
      {OrderData? orderData,
        List<OrderService>? orderService,
        VendorDetails? vendorDetails,
        PaymentInformation? paymentInformation}) {
    if (orderData != null) {
      this._orderData = orderData;
    }
    if (orderService != null) {
      this._orderService = orderService;
    }
    if (vendorDetails != null) {
      this._vendorDetails = vendorDetails;
    }
    if (paymentInformation != null) {
      this._paymentInformation = paymentInformation;
    }
  }

  OrderData? get orderData => _orderData;
  set orderData(OrderData? orderData) => _orderData = orderData;
  List<OrderService>? get orderService => _orderService;
  set orderService(List<OrderService>? orderService) =>
      _orderService = orderService;
  VendorDetails? get vendorDetails => _vendorDetails;
  set vendorDetails(VendorDetails? vendorDetails) =>
      _vendorDetails = vendorDetails;
  PaymentInformation? get paymentInformation => _paymentInformation;
  set paymentInformation(PaymentInformation? paymentInformation) =>
      _paymentInformation = paymentInformation;

  Payload.fromJson(Map<String, dynamic> json) {
    _orderData = json['order_data'] != null
        ? new OrderData.fromJson(json['order_data'])
        : null;
    if (json['order_service'] != null) {
      _orderService = <OrderService>[];
      json['order_service'].forEach((v) {
        _orderService!.add(new OrderService.fromJson(v));
      });
    }
    _vendorDetails = json['vendor_details'] != null
        ? new VendorDetails.fromJson(json['vendor_details'])
        : null;
    _paymentInformation = json['payment_information'] != null
        ? new PaymentInformation.fromJson(json['payment_information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._orderData != null) {
      data['order_data'] = this._orderData!.toJson();
    }
    if (this._orderService != null) {
      data['order_service'] =
          this._orderService!.map((v) => v.toJson()).toList();
    }
    if (this._vendorDetails != null) {
      data['vendor_details'] = this._vendorDetails!.toJson();
    }
    if (this._paymentInformation != null) {
      data['payment_information'] = this._paymentInformation!.toJson();
    }
    return data;
  }
}

class OrderData {
  int? _id;
  String? _orderId;
  String? _bookingDate;
  String? _orderStatus;

  OrderData(
      {int? id, String? orderId, String? bookingDate, String? orderStatus}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (bookingDate != null) {
      this._bookingDate = bookingDate;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;

  OrderData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _bookingDate = json['booking_date'];
    _orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['booking_date'] = this._bookingDate;
    data['order_status'] = this._orderStatus;
    return data;
  }
}

class OrderService {
  String? _fkServiceFkServiceServiceName;
  String? _fkServiceFkServiceServiceImage;
  double? _fkServicePrice;
  String? _fkServiceHour;

  OrderService(
      {String? fkServiceFkServiceServiceName,
        String? fkServiceFkServiceServiceImage,
        double? fkServicePrice,
        String? fkServiceHour}) {
    if (fkServiceFkServiceServiceName != null) {
      this._fkServiceFkServiceServiceName = fkServiceFkServiceServiceName;
    }
    if (fkServiceFkServiceServiceImage != null) {
      this._fkServiceFkServiceServiceImage = fkServiceFkServiceServiceImage;
    }
    if (fkServicePrice != null) {
      this._fkServicePrice = fkServicePrice;
    }
    if (fkServiceHour != null) {
      this._fkServiceHour = fkServiceHour;
    }
  }

  String? get fkServiceFkServiceServiceName => _fkServiceFkServiceServiceName;
  set fkServiceFkServiceServiceName(String? fkServiceFkServiceServiceName) =>
      _fkServiceFkServiceServiceName = fkServiceFkServiceServiceName;
  String? get fkServiceFkServiceServiceImage => _fkServiceFkServiceServiceImage;
  set fkServiceFkServiceServiceImage(String? fkServiceFkServiceServiceImage) =>
      _fkServiceFkServiceServiceImage = fkServiceFkServiceServiceImage;
  double? get fkServicePrice => _fkServicePrice;
  set fkServicePrice(double? fkServicePrice) => _fkServicePrice = fkServicePrice;
  String? get fkServiceHour => _fkServiceHour;
  set fkServiceHour(String? fkServiceHour) => _fkServiceHour = fkServiceHour;

  OrderService.fromJson(Map<String, dynamic> json) {
    _fkServiceFkServiceServiceName =
    json['fk_service__fk_service__service_name'];
    _fkServiceFkServiceServiceImage =
    json['fk_service__fk_service__service_image'];
    _fkServicePrice = json['fk_service__price'];
    _fkServiceHour = json['fk_service__hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_service__fk_service__service_name'] =
        this._fkServiceFkServiceServiceName;
    data['fk_service__fk_service__service_image'] =
        this._fkServiceFkServiceServiceImage;
    data['fk_service__price'] = this._fkServicePrice;
    data['fk_service__hour'] = this._fkServiceHour;
    return data;
  }
}

class VendorDetails {
  String? _fkVendorFullName;
  String? _fkServiceFkCategoryCategoryName;

  VendorDetails(
      {String? fkVendorFullName, String? fkServiceFkCategoryCategoryName}) {
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkServiceFkCategoryCategoryName != null) {
      this._fkServiceFkCategoryCategoryName = fkServiceFkCategoryCategoryName;
    }
  }

  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get fkServiceFkCategoryCategoryName =>
      _fkServiceFkCategoryCategoryName;
  set fkServiceFkCategoryCategoryName(
      String? fkServiceFkCategoryCategoryName) =>
      _fkServiceFkCategoryCategoryName = fkServiceFkCategoryCategoryName;

  VendorDetails.fromJson(Map<String, dynamic> json) {
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkServiceFkCategoryCategoryName =
    json['fk_service__fk_category__category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_service__fk_category__category_name'] =
        this._fkServiceFkCategoryCategoryName;
    return data;
  }
}

class PaymentInformation {
  double? _totalAmount;
  int? _duration;
  String? _address;

  PaymentInformation({double? totalAmount, int? duration, String? address}) {
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (address != null) {
      this._address = address;
    }
  }

  double? get totalAmount => _totalAmount;
  set totalAmount(double? totalAmount) => _totalAmount = totalAmount;
  int? get duration => _duration;
  set duration(int? duration) => _duration = duration;
  String? get address => _address;
  set address(String? address) => _address = address;

  PaymentInformation.fromJson(Map<String, dynamic> json) {
    _totalAmount = json['total_amount'];
    _duration = json['duration'];
    _address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this._totalAmount;
    data['duration'] = this._duration;
    data['address'] = this._address;
    return data;
  }
}
