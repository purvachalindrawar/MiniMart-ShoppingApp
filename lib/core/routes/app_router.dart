import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mini_mart/features/home/home_screen.dart';
import 'package:mini_mart/features/product_detail/product_detail_screen.dart';
import 'package:mini_mart/features/cart/cart_screen.dart';
import 'package:mini_mart/features/profile/profile_screen.dart';
import 'package:mini_mart/features/onboarding/onboarding_screen.dart';
import 'package:mini_mart/models/product.dart';

class AppRouter {
  AppRouter._(); // private constructor to prevent instantiation

  static final GoRouter router = GoRouter(
    initialLocation: _initialLocation,
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
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CartScreen(),
          );
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OnboardingScreen(),
          );
        },
      ),
    ],
  );
}

const _settingsBoxName = 'settingsBox';
const _onboardingKey = 'onboardingCompleted';

String get _initialLocation {
  final box = Hive.box(_settingsBoxName);
  final completed = box.get(_onboardingKey, defaultValue: false) as bool;
  return completed ? '/' : '/onboarding';
}