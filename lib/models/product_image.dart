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

  Map<String, dynamic> toJson() => {
  "Product_id": productId,
  "Image_url": imageUrl,
};
}

Future<List<ProductImage>> fetchProductsImage(int? productId) async {
  final url = Uri.parse('http://103.77.243.218/image/$productId');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => ProductImage.fromJson(json)).toList();
  } else {
    throw Exception('Lỗi khi tải hình ảnh sản phẩm');
  }
}


Future<void> insertProductsImages(int productId, List<ProductImage> images) async {
  final url = Uri.parse('http://103.77.243.218/images');
  final data = images.map((img) => {
    "Product_id": productId,
    "Image_url": img.imageUrl,
  }).toList();

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );

  if (response.statusCode != 201) {
    throw Exception('Lỗi khi thêm danh sách hình ảnh');
  }
}

Future<void> updateProductsImages(int productId, List<ProductImage> images) async {
  final url = Uri.parse('http://103.77.243.218/api/images/$productId');
  final data = images.map((img) => {
    "Image_url": img.imageUrl,
  }).toList();

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );

  if (response.statusCode != 200) {
    throw Exception('Lỗi khi cập nhật danh sách hình ảnh');
  }
}