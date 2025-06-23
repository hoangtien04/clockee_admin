import 'package:flutter/material.dart';
import 'product_page.dart';
import 'order_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const ProductPage(),
    const OrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.watch),
                label: Text("Sản phẩm"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt),
                label: Text("Đơn hàng"),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
