import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mini_mart/core/routes/app_router.dart';

void main() {
  // ProviderScope is the root of all Riverpod providers in the app.
  runApp(
    const ProviderScope(
      child: MiniMartApp(),
    ),
  );
}

class MiniMartApp extends StatelessWidget {
  const MiniMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MiniMart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}

