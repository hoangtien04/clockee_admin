import 'package:flutter/material.dart';
import '../models/type.dart';

class WatchTypeManagementScreen extends StatefulWidget {
  @override
  State<WatchTypeManagementScreen> createState() => _WatchTypeManagementScreenState();
}

class _WatchTypeManagementScreenState extends State<WatchTypeManagementScreen> {
  late Future<List<WatchType>> _futureTypes;

  @override
  void initState() {
    super.initState();
    _futureTypes = fetchWatchType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WatchType>>(
        future: _futureTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          final types = snapshot.data ?? [];
          return ListView.builder(
            itemCount: types.length,
            itemBuilder: (context, index) {
              final t = types[index];
              return ListTile(
                title: Text(t.typeName),
                subtitle: Text('ID: ${t.typeId}'),
                // TODO: Thêm button sửa/xóa nếu muốn
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Hiện form thêm WatchType
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
