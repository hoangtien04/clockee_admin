// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../models/brand.dart';
// import '../models/type.dart';
// import '../models/supplier.dart';
// import '../widgets/product_form.dart';
// import '../services/product_service.dart';

// class OrderManagementScreen extends StatefulWidget {
//   @override
//   OrderManagementScreen createState() => OrderManagementScreen();
// }

// class OrderManagementScreen extends State<OrderManagementScreen> {
//   late Future<List<Product>> _futureProducts;

//  @override
//   void initState() {
//     super.initState();
//     _futureProducts = ProductService.fetchProducts(); // <-- phải gán ở đây!
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Quản lý sản phẩm')),
//       body: FutureBuilder<List<Product>>(
//         future: _futureProducts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Lỗi: ${snapshot.error}'));
//           }
//           final products = snapshot.data!;
//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final p = products[index];
//               return ListTile(
//                 leading: Image.network(p.imageUrl, width: 50, height: 50),
//                 title: Text(p.name),
//                 onTap: () => _showProductDetail(p),
//                 subtitle: Text(p.description),
//                 trailing: Text('${p.sellPrice} VND'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showProductDetail(Product product) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(product.name),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Image.network(product.imageUrl, width: 200, height: 150),
//               ),
//               const SizedBox(height: 16),
//               _detailRow('Mã sản phẩm', product.productId.toString()),
//               _detailRow('Tên', product.name),
//               _detailRow('Thương hiệu ID', product.brandId.toString()),
//               _detailRow('Loại ID', product.typeId.toString()),
//               _detailRow('Nhà cung cấp ID', product.supplierId.toString()),
//               _detailRow('Mô tả', product.description),
//               _detailRow('Giá gốc', product.actualPrice.toString()),
//               _detailRow('Giá bán', product.sellPrice.toString()),
//               _detailRow('Tồn kho', product.stock.toString()),
//               _detailRow('Kích thước mặt', product.faceSize),
//               _detailRow('Độ dày', product.thickness),
//               _detailRow('Độ rộng dây', product.wireSize),
//               _detailRow('Loại năng lượng', product.energy),
//               _detailRow('Dòng sản phẩm', product.productLine),
//               _detailRow('Dạng mặt', product.faceShape),
//               _detailRow('Màu mặt', product.faceColor),
//               _detailRow('Loại dây', product.wireType),
//               _detailRow('Màu dây', product.wireColor),
//               _detailRow('Màu vỏ', product.shellColor),
//               _detailRow('Kiểu vỏ', product.shellStyle),
//               _detailRow('Xuất xứ', product.madeIn),
//               _detailRow('Đang kinh doanh', product.isActive ? "Có" : "Không"),
//               _detailRow('Hiển thị', product.visible ? "Có" : "Không"),
//               _detailRow('Đã xóa', product.isDeleted ? "Có" : "Không"),
//               _detailRow('Số lượt mua', product.purchaseCount.toString()),
//               _detailRow('Nổi bật', product.isHot ? "Có" : "Không"),
//               _detailRow('Giới tính', product.sex ? "Nữ" : "Nam"), // Nếu sex là bool, nếu là int thì sửa lại
//               _detailRow('Model', product.watchModel),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Đóng'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _openProductForm(product: product);
//             },
//             child: Text('Chỉnh sửa'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Hàm widget tiện lợi để tạo 1 dòng thông tin
//   Widget _detailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 140,
//             child: Text(
//               "$label:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }

// void _openProductForm({Product? product}) {
//   showDialog(
//     context: context,
//     builder: (_) => FutureBuilder<List<dynamic>>(
//       future: Future.wait([
//         fetchBrand(),
//         fetchWatchType(),
//         fetchSupplier(),
//       ]),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return AlertDialog(
//             content: Text('Lỗi khi tải dữ liệu'),
//           );
//         }
//         final lists = snapshot.data!;
//         final brandList = lists[0] as List<Brand>;
//         final typeList = lists[1] as List<WatchType>;
//         final supplierList = lists[2] as List<Supplier>;

//         return Dialog(
//           child: ProductForm(
//             product: product,
//             brandList: brandList,
//             typeList: typeList,
//             supplierList: supplierList,
//             onSubmit: (prod) {
//               // Xử lý thêm/sửa
//               Navigator.pop(context);
//               // Gọi setState hoặc refresh lại danh sách sản phẩm nếu cần
//             },
//           ),
//         );
//       },
//     ),
//   );
// }



// }
