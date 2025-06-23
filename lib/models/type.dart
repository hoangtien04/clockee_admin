import 'dart:convert';

import 'package:http/http.dart' as http;

class WatchType {
  final int typeId;
  final String typeName;

  WatchType({required this.typeId, required this.typeName});

  factory WatchType.fromJson(Map<String, dynamic> json) {
    return WatchType(
      typeId: json['Type_id'],
      typeName: json['Type_name'],
    );
  }
}

Future<List<WatchType>> fetchWatchType() async {
  final url = Uri.parse('http://103.77.243.218/type');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => WatchType.fromJson(json)).toList();
  } else {
    throw Exception('Lỗi khi tải loại sản phẩm');
  }
}
