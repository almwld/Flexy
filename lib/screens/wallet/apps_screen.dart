import 'package:flutter/material.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تطبيقات')),
      body: const Center(child: Text('قيد التطوير')),
    );
  }
}
