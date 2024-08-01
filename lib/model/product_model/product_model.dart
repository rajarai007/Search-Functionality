import 'dart:convert';

class ProductModel {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final String? image;
  final double? rating;
  final String? brand;
  final String? color;
  final String? connectivity;
  final bool? wireless;

  const ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.rating,
    this.brand,
    this.color,
    this.connectivity,
    this.wireless,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, image: $image, rating: $rating, brand: $brand, color: $color, connectivity: $connectivity, wireless: $wireless)';
  }

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        price: (data['price'] as num?)?.toDouble(),
        image: data['image'] as String?,
        rating: (data['rating'] as num?)?.toDouble(),
        brand: data['brand'] as String?,
        color: data['color'] as String?,
        connectivity: data['connectivity'] as String?,
        wireless: data['wireless'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'rating': rating,
        'brand': brand,
        'color': color,
        'connectivity': connectivity,
        'wireless': wireless,
      };

  /// `dart:convert`
  ///
  /// Parses the JSON string and returns the resulting object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? image,
    double? rating,
    String? brand,
    String? color,
    String? connectivity,
    bool? wireless,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      connectivity: connectivity ?? this.connectivity,
      wireless: wireless ?? this.wireless,
    );
  }
}
