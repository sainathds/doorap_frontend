class WeekDaysData{

  String? _weekName;
  bool? _isSelected;


  WeekDaysData({String? weekName, bool? isSelected}){
    if(weekName != null){
      _weekName = weekName;
    }

    if(isSelected != null){
      _isSelected = isSelected;
    }
  }



  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }

  String? get weekName => _weekName;

  set weekName(String? value) {
    _weekName = value;
  }
}