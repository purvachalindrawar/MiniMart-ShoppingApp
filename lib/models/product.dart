class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
  });

  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;
}
