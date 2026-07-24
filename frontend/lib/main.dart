import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InventoryPro',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InventoryPro'),
        ),
        body: const Center(
          child: Text(
            'Welcome to InventoryPro!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}