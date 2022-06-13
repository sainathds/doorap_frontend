class Porder {
  int? POID;
  String? PNoStr;  
  String? PartyName;
  String? POCreatedBy;
  String? POStatus;
  

  Porder.fromMap(Map<dynamic, dynamic> map) {
    POID = int.parse(map['POID']);
    PNoStr = map['PONoStr'];
    PartyName = map['PartyName'];
    POCreatedBy = map['POBy'];
     POStatus = map['POStatus'];
    
  }
}
