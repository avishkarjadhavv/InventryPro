import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../services/product_service.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductService.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
        backgroundColor: Colors.indigo,
      ),

      body: products.isEmpty
          ? const Center(
              child: Text(
                "No Products Added",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: products.length,

              itemBuilder: (context, index) {
                Product product = products[index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    title: Text(product.name),

                    subtitle: Text(
                      "${product.category}\nQty: ${product.quantity}   Price: ₹${product.price}",
                    ),

                    isThreeLine: true,

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () {
                        setState(() {
                          ProductService.deleteProduct(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}