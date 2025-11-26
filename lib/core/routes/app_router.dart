import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mini_mart/features/home/home_screen.dart';
import 'package:mini_mart/features/product_detail/product_detail_screen.dart';
import 'package:mini_mart/features/cart/cart_screen.dart';
import 'package:mini_mart/features/profile/profile_screen.dart';
import 'package:mini_mart/features/onboarding/onboarding_screen.dart';
import 'package:mini_mart/features/auth/login_screen.dart';

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
          return _buildTransitionPage(
            state,
            const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: '/product',
        name: 'productDetail',
        pageBuilder: (context, state) {
          final product = state.extra! as Product;
          return _buildTransitionPage(
            state,
            ProductDetailScreen(product: product),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state,
            const CartScreen(),
          );
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state,
            const ProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state,
            const OnboardingScreen(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state,
            const LoginScreen(),
          );
        },
      ),
    ],
  );
}

const _settingsBoxName = 'settingsBox';
const _onboardingKey = 'onboardingCompleted';
const _authUserKey = 'authUser';

String get _initialLocation {
  final box = Hive.box(_settingsBoxName);
  final completed = box.get(_onboardingKey, defaultValue: false) as bool;
  if (!completed) {
    return '/onboarding';
  }

  final storedUser = box.get(_authUserKey);
  if (storedUser is Map) {
    return '/';
  }

  return '/login';
}

CustomTransitionPage<void> _buildTransitionPage(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.08),
        end: Offset.zero,
      ).animate(curved);

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },
  );
}