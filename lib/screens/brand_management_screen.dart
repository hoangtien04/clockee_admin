import 'package:flutter/material.dart';
import '../models/brand.dart';  // tự tạo file brand.dart chứa class Brand
// import BrandService để fetch data từ API (giống Product)

class BrandManagementScreen extends StatefulWidget {
  @override
  _BrandManagementScreenState createState() => _BrandManagementScreenState();
}

class _BrandManagementScreenState extends State<BrandManagementScreen> {
  // Giả sử bạn có API, dùng Future<List<Brand>> thay vì list tĩnh
  late Future<List<Brand>> _futureBrands;

  @override
  void initState() {
    super.initState();
    _futureBrands = fetchBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Brand>>(
        future: _futureBrands,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          final brands = snapshot.data ?? [];
          return ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final b = brands[index];
              return ListTile(
                title: Text(b.name),
                subtitle: Text('ID: ${b.brandId}'),
                trailing: b.Is_deleted == 1
                  ? Icon(Icons.delete_forever, color: Colors.red)
                  : null,
                // TODO: Thêm button sửa/xóa nếu muốn
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Hiện form thêm Brand
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
