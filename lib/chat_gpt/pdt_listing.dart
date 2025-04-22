class Product {
  final String title;
  final double price;
  final double rating;
  final String thumbnail;

  Product({
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}
