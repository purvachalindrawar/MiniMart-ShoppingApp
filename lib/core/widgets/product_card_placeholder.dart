import 'package:flutter/material.dart';

class ProductCardPlaceholder extends StatelessWidget {
  const ProductCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: 80,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 4),
            Container(
              height: 12,
              width: 40,
              color: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
