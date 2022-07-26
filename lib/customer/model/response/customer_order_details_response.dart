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
  List<Reviewandfeedback>? _reviewandfeedback;

  Payload(
      {OrderData? orderData,
        List<OrderService>? orderService,
        VendorDetails? vendorDetails,
        PaymentInformation? paymentInformation,
        List<Reviewandfeedback>? reviewandfeedback}) {
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
    if (reviewandfeedback != null) {
      this._reviewandfeedback = reviewandfeedback;
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
  List<Reviewandfeedback>? get reviewandfeedback => _reviewandfeedback;
  set reviewandfeedback(List<Reviewandfeedback>? reviewandfeedback) =>
      _reviewandfeedback = reviewandfeedback;

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
    if (json['reviewandfeedback'] != null) {
      _reviewandfeedback = <Reviewandfeedback>[];
      json['reviewandfeedback'].forEach((v) {
        _reviewandfeedback!.add(new Reviewandfeedback.fromJson(v));
      });
    }
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
    if (this._reviewandfeedback != null) {
      data['reviewandfeedback'] =
          this._reviewandfeedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  int? _id;
  String? _orderId;
  int? _fkCustomer;
  int? _fkVendor;
  String? _bookingDate;
  String? _orderStatus;
  String? _bookingStartTime;
  String? _address;

  OrderData(
      {int? id,
        String? orderId,
        int? fkCustomer,
        int? fkVendor,
        String? bookingDate,
        String? orderStatus,
        String? bookingStartTime,
        String? address}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (fkCustomer != null) {
      this._fkCustomer = fkCustomer;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (bookingDate != null) {
      this._bookingDate = bookingDate;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (bookingStartTime != null) {
      this._bookingStartTime = bookingStartTime;
    }
    if (address != null) {
      this._address = address;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  int? get fkCustomer => _fkCustomer;
  set fkCustomer(int? fkCustomer) => _fkCustomer = fkCustomer;
  int? get fkVendor => _fkVendor;
  set fkVendor(int? fkVendor) => _fkVendor = fkVendor;
  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get bookingStartTime => _bookingStartTime;
  set bookingStartTime(String? bookingStartTime) =>
      _bookingStartTime = bookingStartTime;
  String? get address => _address;
  set address(String? address) => _address = address;

  OrderData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _fkCustomer = json['fk_customer'];
    _fkVendor = json['fk_vendor'];
    _bookingDate = json['booking_date'];
    _orderStatus = json['order_status'];
    _bookingStartTime = json['booking_start_time'];
    _address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['fk_customer'] = this._fkCustomer;
    data['fk_vendor'] = this._fkVendor;
    data['booking_date'] = this._bookingDate;
    data['order_status'] = this._orderStatus;
    data['booking_start_time'] = this._bookingStartTime;
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

class VendorDetails {
  String? _fkVendorFullName;
  String? _fkVendorProfileImage;
  String? _fkServiceFkCategoryCategoryName;

  VendorDetails(
      {String? fkVendorFullName,
        String? fkVendorProfileImage,
        String? fkServiceFkCategoryCategoryName}) {
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (fkVendorProfileImage != null) {
      this._fkVendorProfileImage = fkVendorProfileImage;
    }
    if (fkServiceFkCategoryCategoryName != null) {
      this._fkServiceFkCategoryCategoryName = fkServiceFkCategoryCategoryName;
    }
  }

  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get fkVendorProfileImage => _fkVendorProfileImage;
  set fkVendorProfileImage(String? fkVendorProfileImage) =>
      _fkVendorProfileImage = fkVendorProfileImage;
  String? get fkServiceFkCategoryCategoryName =>
      _fkServiceFkCategoryCategoryName;
  set fkServiceFkCategoryCategoryName(
      String? fkServiceFkCategoryCategoryName) =>
      _fkServiceFkCategoryCategoryName = fkServiceFkCategoryCategoryName;

  VendorDetails.fromJson(Map<String, dynamic> json) {
    _fkVendorFullName = json['fk_vendor__full_name'];
    _fkVendorProfileImage = json['fk_vendor__profile_image'];
    _fkServiceFkCategoryCategoryName =
    json['fk_service__fk_category__category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['fk_vendor__profile_image'] = this._fkVendorProfileImage;
    data['fk_service__fk_category__category_name'] =
        this._fkServiceFkCategoryCategoryName;
    return data;
  }
}

class PaymentInformation {
  int? _quantity;
  double? _subTotal;
  double? _discount;
  double? _convenienceFee;
  double? _totalAmount;

  PaymentInformation(
      {int? quantity,
        double? subTotal,
        double? discount,
        double? convenienceFee,
        double? totalAmount}) {
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (subTotal != null) {
      this._subTotal = subTotal;
    }
    if (discount != null) {
      this._discount = discount;
    }
    if (convenienceFee != null) {
      this._convenienceFee = convenienceFee;
    }
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
  }

  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  double? get subTotal => _subTotal;
  set subTotal(double? subTotal) => _subTotal = subTotal;
  double? get discount => _discount;
  set discount(double? discount) => _discount = discount;
  double? get convenienceFee => _convenienceFee;
  set convenienceFee(double? convenienceFee) =>
      _convenienceFee = convenienceFee;
  double? get totalAmount => _totalAmount;
  set totalAmount(double? totalAmount) => _totalAmount = totalAmount;

  PaymentInformation.fromJson(Map<String, dynamic> json) {
    _quantity = json['quantity'];
    _subTotal = json['sub_total'];
    _discount = json['discount'];
    _convenienceFee = json['convenience_fee'];
    _totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this._quantity;
    data['sub_total'] = this._subTotal;
    data['discount'] = this._discount;
    data['convenience_fee'] = this._convenienceFee;
    data['total_amount'] = this._totalAmount;
    return data;
  }
}

class Reviewandfeedback {
  double? _rating;
  String? _feedback;

  Reviewandfeedback({double? rating, String? feedback}) {
    if (rating != null) {
      this._rating = rating;
    }
    if (feedback != null) {
      this._feedback = feedback;
    }
  }

  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  String? get feedback => _feedback;
  set feedback(String? feedback) => _feedback = feedback;

  Reviewandfeedback.fromJson(Map<String, dynamic> json) {
    _rating = json['rating'];
    _feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this._rating;
    data['feedback'] = this._feedback;
    return data;
  }
}
