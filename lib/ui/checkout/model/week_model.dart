class WeekModel {
  String? week;
  bool? isIgnoring;
  bool? isSelected;
  // List<DateTime>? selectedDate;

  WeekModel({
    this.week,
    this.isIgnoring = true,
    this.isSelected = false,
    // this.selectedDate,
  });

  WeekModel.fromJson(Map<String, dynamic> json) {
    week = json['month'];
    isIgnoring = json['is_ignoring'];
    isSelected = json['is_selected'];
    // selectedDate = json['selected_date'].cast<DateTime>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = week;
    data['is_ignoring'] = isIgnoring;
    data['is_selected'] = isSelected;
    // data['selected_date'] = selectedDate;
    return data;
  }
}