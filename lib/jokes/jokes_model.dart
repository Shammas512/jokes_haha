class jokes_model {
  String? setup;
  String? delivery;

  jokes_model({this.setup, this.delivery});

  jokes_model.fromJson(Map<String, dynamic> json) {
    setup = json['setup'];
    delivery = json['delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['setup'] = this.setup;
    data['delivery'] = this.delivery;
    return data;
  }
}
