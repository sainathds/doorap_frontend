class CustomerFeedbackRequest {
  int? _id;
  int? _vendorId;
  double? _rating;
  String? _feedback;

  CustomerFeedbackRequest(
      {int? id, int? vendorId, double? rating, String? feedback}) {
    if (id != null) {
      this._id = id;
    }
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (feedback != null) {
      this._feedback = feedback;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  String? get feedback => _feedback;
  set feedback(String? feedback) => _feedback = feedback;

  CustomerFeedbackRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _vendorId = json['vendor_id'];
    _rating = json['rating'];
    _feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['vendor_id'] = this._vendorId;
    data['rating'] = this._rating;
    data['feedback'] = this._feedback;
    return data;
  }
}
