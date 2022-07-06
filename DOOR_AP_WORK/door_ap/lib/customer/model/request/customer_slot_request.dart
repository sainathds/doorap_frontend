class CustomerSlotRequest {
  String? _vendorId;
  String? _slotDate;

  CustomerSlotRequest({String? vendorId, String? slotDate}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (slotDate != null) {
      this._slotDate = slotDate;
    }
  }

  String? get vendorId => _vendorId;
  set vendorId(String? vendorId) => _vendorId = vendorId;
  String? get slotDate => _slotDate;
  set slotDate(String? slotDate) => _slotDate = slotDate;

  CustomerSlotRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _slotDate = json['slot_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['slot_date'] = this._slotDate;
    return data;
  }
}
