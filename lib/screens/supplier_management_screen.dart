import 'package:flutter/material.dart';
import '../models/supplier.dart';

class SupplierManagementScreen extends StatefulWidget {
  @override
  State<SupplierManagementScreen> createState() => _SupplierManagementScreenState();
}

class _SupplierManagementScreenState extends State<SupplierManagementScreen> {
  late Future<List<Supplier>> _futureSuppliers;

  @override
  void initState() {
    super.initState();
    _futureSuppliers = fetchSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Supplier>>(
        future: _futureSuppliers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          final suppliers = snapshot.data ?? [];
          return ListView.builder(
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final s = suppliers[index];
              return ListTile(
                title: Text(s.name),
                subtitle: Text('${s.address} | ${s.phone}'),
                // TODO: Thêm button sửa/xóa nếu muốn
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Hiện form thêm Supplier
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
