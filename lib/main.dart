import 'package:flutter/material.dart';
import 'screens/product_management_screen.dart';
import 'screens/brand_management_screen.dart';
import 'screens/supplier_management_screen.dart';
import 'screens/watchtype_management_screen.dart';
import 'screens/order_management_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Store Management',
      debugShowCheckedModeBanner: false,
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    ProductManagementScreen(),
    BrandManagementScreen(),
    SupplierManagementScreen(),
    WatchTypeManagementScreen(),
    // OrderManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watch Store Admin')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Sản phẩm'),
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Thương hiệu'),
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Nhà cung cấp'),
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Loại đồng hồ'),
              onTap: () {
                setState(() => _selectedIndex = 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Quản lí đơn hàng'),
              onTap: () {
                setState(() => _selectedIndex = 4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
