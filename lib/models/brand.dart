import 'dart:convert';

import 'package:http/http.dart' as http;

class Brand {
  final int brandId;
  final String name;
  final int Is_deleted;

  Brand({
    required this.brandId, 
    required this.name,
    required this.Is_deleted
    });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandId: json['Brand_id'],
      name: json['Name'],
      Is_deleted: json['Is_deleted'],
    );
  }
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
