class CustomerLikeDislikeRequest {
  int? _vendorId;
  int? _categoryId;
  int? _customerId;
  String? _likeDislike;

  CustomerLikeDislikeRequest(
      {int? vendorId, int? categoryId, int? customerId, String? likeDislike}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (likeDislike != null) {
      this._likeDislike = likeDislike;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  String? get likeDislike => _likeDislike;
  set likeDislike(String? likeDislike) => _likeDislike = likeDislike;

  CustomerLikeDislikeRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _categoryId = json['category_id'];
    _customerId = json['customer_id'];
    _likeDislike = json['like_dislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['category_id'] = this._categoryId;
    data['customer_id'] = this._customerId;
    data['like_dislike'] = this._likeDislike;
    return data;
  }
}
