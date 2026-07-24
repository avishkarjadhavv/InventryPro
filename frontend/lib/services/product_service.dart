import '../models/product.dart';

class ProductService {
  static final List<Product> products = [];

  static void addProduct(Product product) {
    products.add(product);
  }

  static List<Product> getProducts() {
    return products;
  }

  static void deleteProduct(int index) {
    products.removeAt(index);
  }
}