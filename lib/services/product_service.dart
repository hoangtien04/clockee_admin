import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String apiUrl = 'http://103.77.243.218/adminproduct';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi khi lấy sản phẩm');
    }
  }

  static Future<void> updateProduct(Product product) async {
    final url = Uri.parse('http://103.77.243.218/api/product/${product.productId}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200) {
    } else {
      // Xử lý lỗi
      throw Exception('Lỗi khi cập nhật sản phẩm');
    }
  }

  static Future<void> createProduct(Product product) async {
    final url = Uri.parse('http://103.77.243.218/api/product');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Lỗi khi thêm sản phẩm');
    }
  }
}
