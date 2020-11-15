class Item {
  final String name;
  final String description;
  final String price;
  final String stock;
  final List<String> images;
  final String type;
  
  Item(
      {this.name,
      this.type,
      this.description,
      this.price,
      this.stock,
      this.images
    });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      type: json['type'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      images: json['images'] != null
          ? new List<String>.from(json['images'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    if (this.images != null) {
      data['images'] = this.images;
    }
    return data;
  }
}