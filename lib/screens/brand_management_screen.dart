import 'package:clockee_manager/widgets/brand_form.dart';
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$label:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _openProductForm({Brand? brand}) {
    showDialog(
      context: context,
      builder: (_) => FutureBuilder<List<dynamic>>(
        future: () {
          List<Future> futures = [
            fetchBrand(),
          ];
          return Future.wait(futures);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        if (snapshot.hasError) {
          return AlertDialog(
            content: Text('Lỗi khi tải dữ liệu: ${snapshot.error}'),
          );
        }
          final lists = snapshot.data!;
          final brandList = lists[0] as List<Brand>;

          return Dialog(
            child: BrandForm(
              brand: brand,
              brandList: brandList,
              onSubmit: (prod) async {
                try {
                  if (brand == null) {
                    // Thêm sản phẩm mới
                  // await ProductService.createProduct(prod);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Thêm hãng thành công')),
                  );
                  } else {
                    await createProduct(prod);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cập nhật thành công')),
                    );
                  }
                  setState(() {
                    _futureBrands = fetchBrand();
                  });
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Có lỗi khi lưu hãng')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
