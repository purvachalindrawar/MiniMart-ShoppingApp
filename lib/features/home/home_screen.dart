import 'package:flutter/material.dart';

import 'package:mini_mart/core/widgets/search_bar.dart';
import 'package:mini_mart/core/widgets/category_chip.dart';
import 'package:mini_mart/core/widgets/product_card_placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final crossAxisCount = isTablet ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniMart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiniMartSearchBar(),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryChip(label: 'All', selected: true),
                  CategoryChip(label: 'Fruits'),
                  CategoryChip(label: 'Vegetables'),
                  CategoryChip(label: 'Dairy'),
                  CategoryChip(label: 'Snacks'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}