class CustomerAllServicesRequest {
  String? _search;

  CustomerAllServicesRequest({String? search}) {
    if (search != null) {
      this._search = search;
    }
  }

  String? get search => _search;
  set search(String? search) => _search = search;

  CustomerAllServicesRequest.fromJson(Map<String, dynamic> json) {
    _search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this._search;
    return data;
  }
}
