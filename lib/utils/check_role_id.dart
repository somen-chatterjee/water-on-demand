class CheckRoleId {
  int? customer;
  int? driver;

  CheckRoleId({
    this.customer = 101,
    this.driver = 102,
  });

  CheckRoleId.fromJson(Map<String, dynamic> json) {
    customer = json['Customer'];
    driver = json['Driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Customer'] = customer;
    data['Driver'] = driver;
    return data;
  }
}
