import 'package:flutter/cupertino.dart';

class CustomerBookOrderRequest {
  int? _vendorId;
  int? _customerId;
  int? _categoryId;
  int? _quantity;
  String? _address;
  String? _city;
  int? _zipCode;
  double? _lat;
  double? _lng;
  double? _subTotal;
  double? _discount;
  double? _convenienceFee;
  double? _totalAmount;
  int? _duration;
  String? _bookingDate;
  String? _bookingStartTime;
  String? _bookingEndTime;
  String? _promocode;
  List<int>? _vendorServicesId;
  int? _vendorCountryId;
  String? _vendorCountryName;
  String? _currentBookingTime;
  String? _currentBookingDate;
  int? _appliedId;
  String? _customerCountry;
  String? _paymentIntentId;



  CustomerBookOrderRequest(
      {int? vendorId,
        int? customerId,
        int? categoryId,
        int? quantity,
        String? address,
        String? city,
        int? zipCode,
        double? lat,
        double? lng,
        double? subTotal,
        double? discount,
        double? convenienceFee,
        double? totalAmount,
        int? duration,
        String? bookingDate,
        String? bookingStartTime,
        String? bookingEndTime,
        String? promocode,
        List<int>? vendorServicesId,
        int? vendorCountryId,
        String? vendorCountryName,
        String? currentBookingTime,
        String? currentBookingDate,
        int? appliedId,
        String? customerCountry,
        String? paymentIntentId
      }) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (address != null) {
      this._address = address;
    }
    if (city != null) {
      this._city = city;
    }
    if (zipCode != null) {
      this._zipCode = zipCode;
    }
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
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
    if (duration != null) {
      this._duration = duration;
    }
    if (bookingDate != null) {
      this._bookingDate = bookingDate;
    }
    if (bookingStartTime != null) {
      this._bookingStartTime = bookingStartTime;
    }
    if (bookingEndTime != null) {
      this._bookingEndTime = bookingEndTime;
    }
    if (promocode != null) {
      this._promocode = promocode;
    }
    if (vendorServicesId != null) {
      this._vendorServicesId = vendorServicesId;
    }
    if (vendorCountryId != null) {
      this._vendorCountryId = vendorCountryId;
    }
    if (vendorCountryName != null) {
      this._vendorCountryName = vendorCountryName;
    }
    if (currentBookingTime != null) {
      this._currentBookingTime = currentBookingTime;
    }
    if (currentBookingDate != null) {
      this._currentBookingDate = currentBookingDate;
    }
    if (appliedId != null) {
      this._appliedId = appliedId;
    }
    if (customerCountry != null) {
      this._customerCountry = customerCountry;
    }
    if (paymentIntentId != null) {
      this._paymentIntentId = paymentIntentId;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get city => _city;
  set city(String? city) => _city = city;
  int? get zipCode => _zipCode;
  set zipCode(int? zipCode) => _zipCode = zipCode;
  double? get lat => _lat;
  set lat(double? lat) => _lat = lat;
  double? get lng => _lng;
  set lng(double? lng) => _lng = lng;
  double? get subTotal => _subTotal;
  set subTotal(double? subTotal) => _subTotal = subTotal;
  double? get discount => _discount;
  set discount(double? discount) => _discount = discount;
  double? get convenienceFee => _convenienceFee;
  set convenienceFee(double? convenienceFee) =>
      _convenienceFee = convenienceFee;
  double? get totalAmount => _totalAmount;
  set totalAmount(double? totalAmount) => _totalAmount = totalAmount;
  int? get duration => _duration;
  set duration(int? duration) => _duration = duration;
  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;
  String? get bookingStartTime => _bookingStartTime;
  set bookingStartTime(String? bookingStartTime) =>
      _bookingStartTime = bookingStartTime;
  String? get bookingEndTime => _bookingEndTime;
  set bookingEndTime(String? bookingEndTime) =>
      _bookingEndTime = bookingEndTime;
  String? get promocode => _promocode;
  set promocode(String? promocode) => _promocode = promocode;
  List<int>? get vendorServicesId => _vendorServicesId;
  set vendorServicesId(List<int>? vendorServicesId) =>
      _vendorServicesId = vendorServicesId;
  int? get vendorCountryId => _vendorCountryId;
  set vendorCountryId(int? vendorCountryId) =>
      _vendorCountryId = vendorCountryId;
  String? get vendorCountryName => _vendorCountryName;
  set vendorCountryName(String? vendorCountryName) =>
      _vendorCountryName = vendorCountryName;
  String? get currentBookingTime => _currentBookingTime;
  set currentBookingTime(String? currentBookingTime) => _currentBookingTime = currentBookingTime;
  String? get currentBookingDate => _currentBookingDate;
  set currentBookingDate(String? currentBookingDate) => _currentBookingDate = currentBookingDate;
  int? get appliedId => _appliedId;
  set appliedId(int? appliedId) => _appliedId = appliedId;
  String? get customerCountry => _customerCountry;
  set customerCountry(String? customerCountry) => _customerCountry = customerCountry;
  String? get paymentIntentId => _paymentIntentId;
  set paymentIntentId(String? paymentIntentId) =>
      _paymentIntentId = paymentIntentId;


  CustomerBookOrderRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _customerId = json['customer_id'];
    _categoryId = json['category_id'];
    _quantity = json['quantity'];
    _address = json['address'];
    _city = json['city'];
    _zipCode = json['zip_code'];
    _lat = json['lat'];
    _lng = json['lng'];
    _subTotal = json['sub_total'];
    _discount = json['discount'];
    _convenienceFee = json['convenience_fee'];
    _totalAmount = json['total_amount'];
    _duration = json['duration'];
    _bookingDate = json['booking_date'];
    _bookingStartTime = json['booking_start_time'];
    _bookingEndTime = json['booking_end_time'];
    _promocode = json['promocode'];
    _vendorServicesId = json['vendor_services_id'].cast<int>();
    _vendorCountryId = json['vendor_country_id'];
    _vendorCountryName = json['vendor_country_name'];
    _currentBookingTime = json['current_booking_time'];
    _currentBookingDate = json['current_booking_date'];
    _appliedId = json['applied_id'];
    _customerCountry = json['customer_country'];
    _paymentIntentId = json['payment_intent_id'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['customer_id'] = this._customerId;
    data['category_id'] = this._categoryId;
    data['quantity'] = this._quantity;
    data['address'] = this._address;
    data['city'] = this._city;
    data['zip_code'] = this._zipCode;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['sub_total'] = this._subTotal;
    data['discount'] = this._discount;
    data['convenience_fee'] = this._convenienceFee;
    data['total_amount'] = this._totalAmount;
    data['duration'] = this._duration;
    data['booking_date'] = this._bookingDate;
    data['booking_start_time'] = this._bookingStartTime;
    data['booking_end_time'] = this._bookingEndTime;
    data['promocode'] = this._promocode;
    data['vendor_services_id'] = this._vendorServicesId;
    data['vendor_country_id'] = this._vendorCountryId;
    data['vendor_country_name'] = this._vendorCountryName;
    data['current_booking_time'] = this._currentBookingTime;
    data['current_booking_date'] = this._currentBookingDate;
    data['applied_id'] = this._appliedId;
    data['customer_country'] = this._customerCountry;
    data['payment_intent_id'] = this._paymentIntentId;


    return data;
  }
}
