import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductImage {
  final int imageId;
  final int productId;
  String imageUrl;

  ProductImage({
    required this.imageId,
    required this.productId,
    required this.imageUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imageId: json['Image_id'],
      productId: json['Product_id'],
      imageUrl: json['Image_url'],
    );
  }
}

Future<List<ProductImage>> fetchProductsImage(int productId) async {
  final url = Uri.parse('http://103.77.243.218/image/$productId');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => ProductImage.fromJson(json)).toList();
  } else {
    throw Exception('Lỗi khi tải hình ảnh sản phẩm');
  }
}
