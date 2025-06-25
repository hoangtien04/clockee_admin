import 'dart:convert';

import 'package:http/http.dart' as http;

class Brand{
  final int? brandId;
  final String name;
  final bool Is_deleted;

  Brand({required this.brandId, required this.name, required this.Is_deleted});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandId: json['Brand_id'],
      name: json['Name'],
      Is_deleted: json['Is_deleted'],
    );
  }
    Map<String, dynamic> toJson() => {
    "Brand_id": brandId,
    "Name": name,
    "Is_deleted": Is_deleted ? 1 : 0,
  };
}

Future<List<Brand>> fetchBrand() async {
  final url = Uri.parse('http://103.77.243.218/brand');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Brand.fromJson(json)).toList();
  } else {
    throw Exception('Lỗi khi tải hãng sản phẩm');
  }
}

Future<void> createProduct(Brand brand) async {
  final url = Uri.parse('http://103.77.243.218/api/brand');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(brand.toJson()),
  );
  if (response.statusCode != 201) {
    throw Exception('Lỗi khi thêm hãng');
  }
}
