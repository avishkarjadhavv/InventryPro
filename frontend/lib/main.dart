import 'screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'constants/app_theme.dart';

void main() {
  runApp(const InventoryProApp());
}

class InventoryProApp extends StatelessWidget {
  const InventoryProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InventoryPro',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InventoryPro"),
      ),
      body: const Center(
        child: Text(
          "Welcome to InventoryPro",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}