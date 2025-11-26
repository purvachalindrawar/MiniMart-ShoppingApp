import 'package:mini_mart/models/product.dart';

class CartItem {
  CartItem({
    required this.product,
    this.quantity = 1,
  });

  final Product product;
  int quantity;

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': product.id,
      'name': product.name,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'rating': product.rating,
      'category': product.category,
      'quantity': quantity,
    };
  }

  static CartItem fromMap(Map<dynamic, dynamic> map) {
    final product = Product(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      rating: (map['rating'] as num).toDouble(),
      category: map['category'] as String,
    );
    final quantity = (map['quantity'] as num?)?.toInt() ?? 1;
    return CartItem(product: product, quantity: quantity);
  }
}

