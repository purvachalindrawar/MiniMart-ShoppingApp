import 'package:flutter/material.dart';

/// HomeScreen will eventually contain:
/// - Search bar with debounce
/// - Category list
/// - Product grid
/// - Skeletons / shimmer
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniMart'),
      ),
      body: const Center(
        child: Text('Home screen placeholder'),
      ),
    );
  }
}