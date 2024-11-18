class MonthModel {
  String? month;
  bool? isEnabled;
  bool? isSelected;
  List<DateTime>? selectedDate;

  MonthModel({
    this.month,
    this.isEnabled = false,
    this.isSelected = false,
    this.selectedDate,
  });

  MonthModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    isEnabled = json['is_enabled'];
    isSelected = json['is_selected'];
    selectedDate = json['selected_date'].cast<DateTime>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['is_enabled'] = isEnabled;
    data['is_selected'] = isSelected;
    data['selected_date'] = selectedDate;
    return data;
  }
}