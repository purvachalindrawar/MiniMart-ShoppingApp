import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mini_mart/models/product.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));

  const products = <Product>[
    Product(
      id: '1',
      name: 'Fresh Apples',
      price: 2.49,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.5,
      category: 'Fruits',
    ),
    Product(
      id: '2',
      name: 'Bananas',
      price: 1.99,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.2,
      category: 'Fruits',
    ),
    Product(
      id: '3',
      name: 'Milk 1L',
      price: 0.99,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.8,
      category: 'Dairy',
    ),
    Product(
      id: '4',
      name: 'Potatoes 1kg',
      price: 1.49,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.0,
      category: 'Vegetables',
    ),
  ];

  return products;
});
