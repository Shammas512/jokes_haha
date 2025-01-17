class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  String? brand;

  Product({this.id, this.name, this.description, this.price, this.brand});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['brand'] = this.brand;
    return data;
  }
}
