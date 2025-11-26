import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';

import 'package:mini_mart/core/widgets/search_bar.dart';
import 'package:mini_mart/core/widgets/category_chip.dart';
import 'package:mini_mart/core/widgets/product_card_placeholder.dart';
import 'package:mini_mart/features/home/home_providers.dart';
import 'package:mini_mart/models/product.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(searchQueryProvider.notifier).state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final crossAxisCount = isTablet ? 4 : 2;

    final productsAsync = ref.watch(productsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniMart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              context.pushNamed('cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              context.pushNamed('profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MiniMartSearchBar(onChanged: _onSearchChanged),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryChip(
                    label: 'All',
                    selected: selectedCategory == 'All',
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state = 'All';
                    },
                  ),
                  CategoryChip(
                    label: 'Fruits',
                    selected: selectedCategory == 'Fruits',
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state =
                          'Fruits';
                    },
                  ),
                  CategoryChip(
                    label: 'Vegetables',
                    selected: selectedCategory == 'Vegetables',
                    onTap: () {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .state = 'Vegetables';
                    },
                  ),
                  CategoryChip(
                    label: 'Dairy',
                    selected: selectedCategory == 'Dairy',
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state =
                          'Dairy';
                    },
                  ),
                  CategoryChip(
                    label: 'Snacks',
                    selected: selectedCategory == 'Snacks',
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state =
                          'Snacks';
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: productsAsync.when(
                data: (products) {
                  final filtered = products.where((product) {
                    final matchesCategory =
                        selectedCategory == 'All' ||
                            product.category == selectedCategory;
                    final matchesSearch = searchQuery.isEmpty ||
                        product.name
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());
                    return matchesCategory && matchesSearch;
                  }).toList();

                  return _ProductsGrid(
                    products: filtered,
                    crossAxisCount: crossAxisCount,
                  );
                },
                loading: () {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const ProductCardPlaceholder();
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text('Failed to load products'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({
    required this.products,
    required this.crossAxisCount,
  });

  final List<Product> products;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              'productDetail',
              extra: product,
            );
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'product-${product.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(product.rating.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}