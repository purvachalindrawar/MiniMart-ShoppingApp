import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mini_mart/features/cart/cart_providers.dart';
import 'package:mini_mart/models/cart_item.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _CartItemTile(item: item);
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, -1),
                        blurRadius: 4,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '\u0024${total.toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _CartItemTile extends ConsumerWidget {
  const _CartItemTile({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(item.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(cartProvider.notifier).removeProduct(item.product);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Text(item.product.name[0]),
        ),
        title: Text(item.product.name),
        subtitle: Text(
          '\u0024${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final newQty = item.quantity - 1;
                  ref
                      .read(cartProvider.notifier)
                      .updateQuantity(item.product, newQty);
                },
              ),
              Text('${item.quantity}'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  final newQty = item.quantity + 1;
                  ref
                      .read(cartProvider.notifier)
                      .updateQuantity(item.product, newQty);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
