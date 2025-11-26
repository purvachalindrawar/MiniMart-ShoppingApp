import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mini_mart/features/home/home_screen.dart';
import 'package:mini_mart/features/product_detail/product_detail_screen.dart';
import 'package:mini_mart/models/product.dart';

class AppRouter {
  AppRouter._(); // private constructor to prevent instantiation

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: '/product',
        name: 'productDetail',
        pageBuilder: (context, state) {
          final product = state.extra! as Product;
          return MaterialPage(
            child: ProductDetailScreen(product: product),
          );
        },
      ),
      // TODO: cart, profile, onboarding routes will be added later.
    ],
  );
}