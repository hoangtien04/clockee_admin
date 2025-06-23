import 'dart:convert';

import 'package:http/http.dart' as http;

class Supplier {
  final int supplierId;
  final String name;
  final String address;
  final String phone;
  final String email;

  Supplier({
    required this.supplierId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      supplierId: json['Supplier_id'],
      name: json['Name'],
      address: json['Address'],
      phone: json['Phone'],
      email: json['Email'],
    );
  }
}

Future<List<Supplier>> fetchProducts() async {
  final url = Uri.parse('http://103.77.243.218/supplier');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Supplier.fromJson(json)).toList();
  } else {
    throw Exception('Lỗi khi tải nhà cung cấp');
  }
}
