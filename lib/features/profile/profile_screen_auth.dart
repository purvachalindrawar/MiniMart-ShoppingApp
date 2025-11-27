import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mini_mart/core/theme/theme_provider.dart';
import 'package:mini_mart/features/auth/auth_provider.dart';
import 'package:mini_mart/features/favorites/favorites_providers.dart';
import 'package:mini_mart/features/home/home_providers.dart';

class ProfileScreenAuth extends ConsumerStatefulWidget {
  const ProfileScreenAuth({super.key});

  @override
  ConsumerState<ProfileScreenAuth> createState() => _ProfileScreenAuthState();
}

class _ProfileScreenAuthState extends ConsumerState<ProfileScreenAuth> {
  final _nameController = TextEditingController(text: 'MiniMart Shopper');
  final _emailController = TextEditingController(text: 'shopper@example.com');

  @override
  void initState() {
    super.initState();
    // Delay reading ref until first frame to avoid lifecycle issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authProvider);
      final user = authState.user;
      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final authState = ref.watch(authProvider);
    final favoriteIds = ref.watch(favoritesProvider);
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark mode'),
                Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    ref
                        .read(themeModeProvider.notifier)
                        .state =
                            value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (authState.user != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).signOut();
                    context.goNamed('login');
                  },
                  child: const Text('Log out'),
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Saved items',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            productsAsync.when(
              data: (products) {
                final savedProducts = products
                    .where((p) => favoriteIds.contains(p.id))
                    .toList();

                if (savedProducts.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      'No saved items yet. Tap the heart icon on a product '
                      'detail page to save it here.',
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: savedProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final product = savedProducts[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                        '\u20b9${product.price.toStringAsFixed(2)}',
                      ),
                    );
                  },
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(8),
                child: LinearProgressIndicator(),
              ),
              error: (error, stackTrace) => const Text(
                'Failed to load saved items.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
