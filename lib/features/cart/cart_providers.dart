import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mini_mart/models/cart_item.dart';
import 'package:mini_mart/models/product.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(const []);

  void addProduct(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      state = [...state, CartItem(product: product)];
    } else {
      final updated = [...state];
      updated[index].quantity++;
      state = updated;
    }
  }

  void removeProduct(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeProduct(product);
      return;
    }
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;
    final updated = [...state];
    updated[index].quantity = quantity;
    state = updated;
  }

  double get total =>
      state.fold(0, (sum, item) => sum + item.totalPrice);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + item.totalPrice);
});
