class ProductData {
  dynamic productId;
  dynamic title;
  dynamic image;
  dynamic description;
  dynamic quantity;
  dynamic price;

  ProductData(
      {this.productId,
      this.title,
      this.image,
      this.description,
      this.quantity,
      this.price});

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
