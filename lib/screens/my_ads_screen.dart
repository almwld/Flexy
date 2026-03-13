import 'package:flutter/material.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعلاناتي')),
      body: const Center(child: Text('إعلاناتي - قيد التطوير')),
    );
  }
}
