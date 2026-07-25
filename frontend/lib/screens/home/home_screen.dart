import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../inventory/add_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalProducts = 0;
  int totalQuantity = 0;
  int lowStock = 0;
  double totalValue = 0;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    totalProducts = await DatabaseHelper.getTotalProducts();
    totalQuantity = await DatabaseHelper.getTotalQuantity();
    totalValue = await DatabaseHelper.getTotalValue();
    lowStock = await DatabaseHelper.getLowStockCount();

    if (mounted) {
      setState(() {});
    }
  }

  Widget dashboardCard(
      IconData icon,
      Color color,
      String value,
      String title,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 35),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget actionCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.indigo, size: 35),
          const SizedBox(height: 12),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InventoryPro"),
        backgroundColor: Colors.indigo,
      ),
      body: RefreshIndicator(
        onRefresh: loadDashboard,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, AJ 👋",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Manage your inventory efficiently",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
                children: [
                  dashboardCard(
                    Icons.inventory,
                    Colors.indigo,
                    totalProducts.toString(),
                    "Products",
                  ),
                  dashboardCard(
                    Icons.layers,
                    Colors.green,
                    totalQuantity.toString(),
                    "Stock Qty",
                  ),
                  dashboardCard(
                    Icons.currency_rupee,
                    Colors.orange,
                    "₹${totalValue.toStringAsFixed(2)}",
                    "Inventory Value",
                  ),
                  dashboardCard(
                    Icons.warning,
                    Colors.red,
                    lowStock.toString(),
                    "Low Stock",
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
                children: [
                  GestureDetector(
                    onTap: () async {
                      bool? added = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddProductScreen(),
                        ),
                      );

                      if (added == true) {
                        loadDashboard();
                      }
                    },
                    child: actionCard(
                      Icons.add,
                      "Add Product",
                    ),
                  ),

                  actionCard(Icons.receipt_long, "New Bill"),
                  actionCard(Icons.people, "Customers"),
                  actionCard(Icons.local_shipping, "Suppliers"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}