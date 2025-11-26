import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mini_mart/models/cart_item.dart';
import 'package:mini_mart/models/product.dart';

const _cartBoxName = 'cartBox';
const _cartItemsKey = 'items';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier(this._box) : super(const []) {
    _loadFromBox();
  }

  final Box _box;

  void _loadFromBox() {
    final raw = _box.get(_cartItemsKey, defaultValue: <dynamic>[]) as List;
    state = raw
        .whereType<Map>()
        .map<CartItem>((map) => CartItem.fromMap(map))
        .toList();
  }

  void _saveToBox() {
    final data = state.map((item) => item.toMap()).toList();
    _box.put(_cartItemsKey, data);
  }

  void addProduct(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      state = [...state, CartItem(product: product)];
    } else {
      final updated = [...state];
      updated[index].quantity++;
      state = updated;
    }
    _saveToBox();
  }

  void removeProduct(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
    _saveToBox();
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
    _saveToBox();
  }

  double get total =>
      state.fold(0, (sum, item) => sum + item.totalPrice);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final box = Hive.box(_cartBoxName);
  return CartNotifier(box);
});

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + item.totalPrice);
});
