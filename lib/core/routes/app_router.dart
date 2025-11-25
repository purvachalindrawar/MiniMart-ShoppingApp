import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mini_mart/features/home/home_screen.dart';

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
      // TODO: product detail, cart, profile, onboarding routes will be added later.
    ],
  );
}