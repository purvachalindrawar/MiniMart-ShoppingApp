import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _settingsBoxName = 'settingsBox';
const _favoritesKey = 'favoriteProductIds';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  final box = Hive.box(_settingsBoxName);
  final stored = box.get(_favoritesKey, defaultValue: <String>[]) as List;
  final initial = stored.cast<String>().toSet();
  return FavoritesNotifier(box, initial);
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this._box, Set<String> initial) : super(initial);

  final Box _box;

  void toggle(String productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state, productId};
    }
    _save();
  }

  void _save() {
    _box.put(_favoritesKey, state.toList());
  }
}
