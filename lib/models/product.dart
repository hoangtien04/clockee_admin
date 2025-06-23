import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  final int productId;
  String name;
  int brandId;
  int typeId;
  int supplierId;
  String description;
  int actualPrice;
  int sellPrice;
  int stock;
  String faceSize;
  String thickness;
  String wireSize;
  String energy;
  String productLine;
  String faceShape;
  String faceColor;
  String wireType;
  String wireColor;
  String shellColor;
  String shellStyle;
  String madeIn;
  int isActive;
  int visible;
  int isDeleted;
  String imageUrl;
  int purchaseCount;
  int isHot;
  int sex;
  String watchModel;

  // Optional (for joined data like type_name)
  String? typeName;

  Product({
    required this.productId,
    required this.name,
    required this.brandId,
    required this.typeId,
    required this.supplierId,
    required this.description,
    required this.actualPrice,
    required this.sellPrice,
    required this.stock,
    required this.faceSize,
    required this.thickness,
    required this.wireSize,
    required this.energy,
    required this.productLine,
    required this.faceShape,
    required this.faceColor,
    required this.wireType,
    required this.wireColor,
    required this.shellColor,
    required this.shellStyle,
    required this.madeIn,
    required this.isActive,
    required this.visible,
    required this.isDeleted,
    required this.imageUrl,
    required this.purchaseCount,
    required this.isHot,
    required this.sex,
    required this.watchModel,
    this.typeName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Product_id'],
      name: json['Name'],
      brandId: json['Brand_id'],
      typeId: json['Type_id'],
      supplierId: json['Supplier_id'],
      description: json['Description'],
      actualPrice: json['Actual_price'],
      sellPrice: json['Sell_price'],
      stock: json['Stock'],
      faceSize: json['Face_size'],
      thickness: json['Thickness'],
      wireSize: json['Wire_size'],
      energy: json['Energy'],
      productLine: json['Product_line'],
      faceShape: json['Face_shape'],
      faceColor: json['Face_color'],
      wireType: json['Wire_type'],
      wireColor: json['Wire_color'],
      shellColor: json['Shell_color'],
      shellStyle: json['Shell_style'],
      madeIn: json['Made_in'],
      isActive: json['Is_active'],
      visible: json['Visible'],
      isDeleted: json['Is_deleted'],
      imageUrl: json['Image_url'],
      purchaseCount: json['Purchase_count'],
      isHot: json['Is_hot'],
      sex: json['Sex'],
      watchModel: json['Watch_model'],
      typeName: json['Type_name'], // optional field if exists
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Product_id': productId,
      'Name': name,
      'Brand_id': brandId,
      'Type_id': typeId,
      'Supplier_id': supplierId,
      'Description': description,
      'Actual_price': actualPrice,
      'Sell_price': sellPrice,
      'Stock': stock,
      'Face_size': faceSize,
      'Thickness': thickness,
      'Wire_size': wireSize,
      'Energy': energy,
      'Product_line': productLine,
      'Face_shape': faceShape,
      'Face_color': faceColor,
      'Wire_type': wireType,
      'Wire_color': wireColor,
      'Shell_color': shellColor,
      'Shell_style': shellStyle,
      'Made_in': madeIn,
      'Is_active': isActive,
      'Visible': visible,
      'Is_deleted': isDeleted,
      'Image_url': imageUrl,
      'Purchase_count': purchaseCount,
      'Is_hot': isHot,
      'Sex': sex,
      'Watch_model': watchModel,
      'Type_name': typeName,
    };
  }
}


Future<List<Product>> fetchProducts() async {
  final url = Uri.parse('http://103.77.243.218/product');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Lỗi khi tải sản phẩm');
  }
}

Future<bool> updateProduct(Product product) async {
  final url = Uri.parse('http://103.77.243.218/api/product/${product.productId}');

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      // Thêm nếu có token: 'Authorization': 'Bearer your_token',
    },
    body: jsonEncode(product.toJson()),
  );

  if (response.statusCode == 200) {
    print('Cập nhật sản phẩm thành công');
    return true;
  } else {
    print('Lỗi cập nhật: ${response.statusCode} ${response.body}');
    return false;
  }
}