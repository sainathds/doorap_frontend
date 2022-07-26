class VendorOrderDetailsResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  VendorOrderDetailsResponse({int? status, String? msg, Payload? payload}) {
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

  VendorOrderDetailsResponse.fromJson(Map<dynamic, dynamic> json) {
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
  CustomerDetails? _customerDetails;
  PaymentInformation? _paymentInformation;

  Payload(
      {OrderData? orderData,
        List<OrderService>? orderService,
        CustomerDetails? customerDetails,
        PaymentInformation? paymentInformation}) {
    if (orderData != null) {
      this._orderData = orderData;
    }
    if (orderService != null) {
      this._orderService = orderService;
    }
    if (customerDetails != null) {
      this._customerDetails = customerDetails;
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
  CustomerDetails? get customerDetails => _customerDetails;
  set customerDetails(CustomerDetails? customerDetails) =>
      _customerDetails = customerDetails;
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
    _customerDetails = json['customer_details'] != null
        ? new CustomerDetails.fromJson(json['customer_details'])
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
    if (this._customerDetails != null) {
      data['customer_details'] = this._customerDetails!.toJson();
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
  String? _fkCategoryCategoryName;
  int? _fkCustomer;
  int? _fkVendor;
  String? _bookingStartTime;
  String? _orderStatus;
  String? _bookingDate;
  String? _address;

  OrderData(
      {int? id,
        String? orderId,
        String? fkCategoryCategoryName,
        int? fkCustomer,
        int? fkVendor,
        String? bookingStartTime,
        String? orderStatus,
        String? bookingDate,
        String? address}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (fkCategoryCategoryName != null) {
      this._fkCategoryCategoryName = fkCategoryCategoryName;
    }
    if (fkCustomer != null) {
      this._fkCustomer = fkCustomer;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (bookingStartTime != null) {
      this._bookingStartTime = bookingStartTime;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (bookingDate != null) {
      this._bookingDate = bookingDate;
    }
    if (address != null) {
      this._address = address;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  String? get fkCategoryCategoryName => _fkCategoryCategoryName;
  set fkCategoryCategoryName(String? fkCategoryCategoryName) =>
      _fkCategoryCategoryName = fkCategoryCategoryName;
  int? get fkCustomer => _fkCustomer;
  set fkCustomer(int? fkCustomer) => _fkCustomer = fkCustomer;
  int? get fkVendor => _fkVendor;
  set fkVendor(int? fkVendor) => _fkVendor = fkVendor;
  String? get bookingStartTime => _bookingStartTime;
  set bookingStartTime(String? bookingStartTime) =>
      _bookingStartTime = bookingStartTime;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;
  String? get address => _address;
  set address(String? address) => _address = address;

  OrderData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _fkCategoryCategoryName = json['fk_category__category_name'];
    _fkCustomer = json['fk_customer'];
    _fkVendor = json['fk_vendor'];
    _bookingStartTime = json['booking_start_time'];
    _orderStatus = json['order_status'];
    _bookingDate = json['booking_date'];
    _address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['fk_category__category_name'] = this._fkCategoryCategoryName;
    data['fk_customer'] = this._fkCustomer;
    data['fk_vendor'] = this._fkVendor;
    data['booking_start_time'] = this._bookingStartTime;
    data['order_status'] = this._orderStatus;
    data['booking_date'] = this._bookingDate;
    data['address'] = this._address;
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
  set fkServicePrice(double? fkServicePrice) =>
      _fkServicePrice = fkServicePrice;
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

class CustomerDetails {
  String? _fkCustomerName;

  CustomerDetails({String? fkCustomerName}) {
    if (fkCustomerName != null) {
      this._fkCustomerName = fkCustomerName;
    }
  }

  String? get fkCustomerName => _fkCustomerName;
  set fkCustomerName(String? fkCustomerName) =>
      _fkCustomerName = fkCustomerName;

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    _fkCustomerName = json['fk_customer__name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_customer__name'] = this._fkCustomerName;
    return data;
  }
}

class PaymentInformation {
  double? _subTotal;
  double? _vendorPayAmount;
  int? _duration;
  double? _vendorConvenienceFee;
  int? _quantity;

  PaymentInformation(
      {double? subTotal,
        double? vendorPayAmount,
        int? duration,
        double? vendorConvenienceFee,
        int? quantity}) {
    if (subTotal != null) {
      this._subTotal = subTotal;
    }
    if (vendorPayAmount != null) {
      this._vendorPayAmount = vendorPayAmount;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (vendorConvenienceFee != null) {
      this._vendorConvenienceFee = vendorConvenienceFee;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
  }

  double? get subTotal => _subTotal;
  set subTotal(double? subTotal) => _subTotal = subTotal;
  double? get vendorPayAmount => _vendorPayAmount;
  set vendorPayAmount(double? vendorPayAmount) =>
      _vendorPayAmount = vendorPayAmount;
  int? get duration => _duration;
  set duration(int? duration) => _duration = duration;
  double? get vendorConvenienceFee => _vendorConvenienceFee;
  set vendorConvenienceFee(double? vendorConvenienceFee) =>
      _vendorConvenienceFee = vendorConvenienceFee;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;

  PaymentInformation.fromJson(Map<String, dynamic> json) {
    _subTotal = json['sub_total'];
    _vendorPayAmount = json['vendor_pay_amount'];
    _duration = json['duration'];
    _vendorConvenienceFee = json['vendor_convenience_fee'];
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_total'] = this._subTotal;
    data['vendor_pay_amount'] = this._vendorPayAmount;
    data['duration'] = this._duration;
    data['vendor_convenience_fee'] = this._vendorConvenienceFee;
    data['quantity'] = this._quantity;
    return data;
  }
}