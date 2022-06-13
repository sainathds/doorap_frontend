class Customer {
  int? CustID;
  String? CustName;
  String? SFID;
  String? ClosingBal;
  String? Bal2;
  

  Customer.fromMap(Map<dynamic, dynamic> map) {
    CustID = int.parse(map['CustID']);
    CustName = map['CustName'];
    SFID = map['SFID'];
    ClosingBal = map['ClosingBal'];
    Bal2 = map['Bal2'];
    
  }
}
