import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static const String tableName = "products";

  // Get Database Instance
  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize Database
  static Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "inventorypro.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            price REAL NOT NULL
          )
        ''');
      },
    );
  }

  // ==========================
  // CRUD OPERATIONS
  // ==========================

  // Insert Product
  static Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await getDatabase();

    return await db.insert(
      tableName,
      product,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get All Products
  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await getDatabase();

    return await db.query(
      tableName,
      orderBy: "name ASC",
    );
  }

  // Update Product
  static Future<int> updateProduct(Map<String, dynamic> product) async {
    final db = await getDatabase();

    return await db.update(
      tableName,
      product,
      where: "id = ?",
      whereArgs: [product["id"]],
    );
  }

  // Delete Product
  static Future<int> deleteProduct(int id) async {
    final db = await getDatabase();

    return await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // ==========================
  // DASHBOARD STATISTICS
  // ==========================

  // Total Products
  static Future<int> getTotalProducts() async {
    final db = await getDatabase();

    final result = await db.rawQuery(
      "SELECT COUNT(*) AS count FROM $tableName",
    );

    return (result.first["count"] as num).toInt();
  }

  // Total Stock Quantity
  static Future<int> getTotalQuantity() async {
    final db = await getDatabase();

    final result = await db.rawQuery(
      "SELECT SUM(quantity) AS total FROM $tableName",
    );

    return ((result.first["total"] ?? 0) as num).toInt();
  }

  // Total Inventory Value
  static Future<double> getTotalValue() async {
    final db = await getDatabase();

    final result = await db.rawQuery(
      "SELECT SUM(quantity * price) AS total FROM $tableName",
    );

    return ((result.first["total"] ?? 0) as num).toDouble();
  }

  // Low Stock Items (Quantity <= 5)
  static Future<int> getLowStockCount() async {
    final db = await getDatabase();

    final result = await db.rawQuery(
      "SELECT COUNT(*) AS count FROM $tableName WHERE quantity <= 5",
    );

    return (result.first["count"] as num).toInt();
  }
}