import 'package:clockee_manager/models/brand.dart';
import 'package:clockee_manager/models/supplier.dart';
import 'package:clockee_manager/models/type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:clockee_manager/models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> _futureProducts;
  Product? _selectedProduct;
  bool _initialSelected = false; // 🔸 để không set lại nhiều lần

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý sản phẩm")),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có sản phẩm nào.'));
          }

          final products = snapshot.data!;

          // ✅ Chỉ chọn dòng đầu tiên duy nhất 1 lần
          if (!_initialSelected && products.isNotEmpty) {
            _selectedProduct = products[0];
            _initialSelected = true;
          }

          return Row(
            children: [
              // Danh sách sản phẩm bên trái
              Flexible(
                flex: 2,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    final isSelected = _selectedProduct?.productId == p.productId;
                    return Card(
                      color: isSelected ? Colors.blue.shade100 : null,
                      child: ListTile(
                        leading: Image.network(
                          p.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.watch),
                        ),
                        title: Text('${p.name} ${p.watchModel}'),
                        subtitle: Text('Giá: ${p.sellPrice} VND'),
                        onTap: () {
                          setState(() {
                            _selectedProduct = p;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              // Chi tiết sản phẩm bên phải
              Flexible(
                flex: 3,
                child: _selectedProduct == null
                    ? const Center(child: Text('Chọn sản phẩm để xem chi tiết'))
                    : ProductDetailForm(
                        key: ValueKey(_selectedProduct!.productId), // 🔑 quan trọng: reset form nếu chọn sản phẩm khác
                        product: _selectedProduct!,
                        onSave: (updatedProduct) {
                          setState(() {
                            _selectedProduct = updatedProduct;
                          });
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductDetailForm extends StatefulWidget {
  final Product product;
  final void Function(Product updatedProduct) onSave;

  const ProductDetailForm({
    super.key,
    required this.product,
    required this.onSave,
  });

  @override
  State<ProductDetailForm> createState() => _ProductDetailFormState();
}

class _ProductDetailFormState extends State<ProductDetailForm> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController imageUrlController;
  late TextEditingController descriptionController;
  late TextEditingController actualPriceController;
  late TextEditingController sellPriceController;
  late TextEditingController faceSizeController;
  late TextEditingController thicknessController;
  late TextEditingController wireSizeController;
  late TextEditingController energyController;
  late TextEditingController productLineController;
  late TextEditingController faceShapeController;
  late TextEditingController faceColorController;
  late TextEditingController wireTypeController;
  late TextEditingController wireColorController;
  late TextEditingController shellColorController;
  late TextEditingController shellStyleController;
  late TextEditingController madeInController;
  late TextEditingController purchaseCountController;
  late TextEditingController sexController;
  late TextEditingController watchModelController;
  late TextEditingController typeNameController;

  List<Brand> _brands = [];
  List<Supplier> _suppliers = [];
  List<WatchType> _types = [];
  Brand? _selectedBrand;
  Supplier? _selectedSupplier;
  WatchType? _selectedType;

  late bool isActiveValue;
  late bool visibleValue;
  
  late bool isDeletedValue;

 @override
void initState() {
  super.initState();
  nameController = TextEditingController(text: widget.product.name);
  descriptionController = TextEditingController(text: widget.product.description);
  actualPriceController = TextEditingController(text: widget.product.actualPrice.toString());
  sellPriceController = TextEditingController(text: widget.product.sellPrice.toString());
  stockController = TextEditingController(text: widget.product.stock.toString());
  faceSizeController = TextEditingController(text: widget.product.faceSize);
  thicknessController = TextEditingController(text: widget.product.thickness);
  wireSizeController = TextEditingController(text: widget.product.wireSize);
  energyController = TextEditingController(text: widget.product.energy);
  productLineController = TextEditingController(text: widget.product.productLine);
  faceShapeController = TextEditingController(text: widget.product.faceShape);
  faceColorController = TextEditingController(text: widget.product.faceColor);
  wireTypeController = TextEditingController(text: widget.product.wireType);
  wireColorController = TextEditingController(text: widget.product.wireColor);
  shellColorController = TextEditingController(text: widget.product.shellColor);
  shellStyleController = TextEditingController(text: widget.product.shellStyle);
  madeInController = TextEditingController(text: widget.product.madeIn);
  imageUrlController = TextEditingController(text: widget.product.imageUrl);
  purchaseCountController = TextEditingController(text: widget.product.purchaseCount.toString());
  sexController = TextEditingController(text: widget.product.sex.toString());
  watchModelController = TextEditingController(text: widget.product.watchModel);
  typeNameController = TextEditingController(text: widget.product.typeName);

  isActiveValue = widget.product.isActive == 1;
  visibleValue = widget.product.visible == 1;
  isDeletedValue = widget.product.isDeleted == 1;

  fetchBrand().then((value) {
    Brand? sel;
    for (var b in value) {
      if (b.brandId == widget.product.brandId) {
        sel = b;
        break;
      }
    }
    setState(() {
      _brands = value;
      _selectedBrand = sel ?? (value.isNotEmpty ? value.first : null);
    });
  });

  fetchSupplier().then((value) {
    Supplier? sel;
    for (var s in value) {
      if (s.supplierId == widget.product.supplierId) {
        sel = s;
        break;
      }
    }
    setState(() {
      _suppliers = value;
      _selectedSupplier = sel ?? (value.isNotEmpty ? value.first : null);
    });
  });

  fetchWatchType().then((value) {
    WatchType? sel;
    for (var t in value) {
      if (t.typeId == widget.product.typeId) {
        sel = t;
        break;
      }
    }
    setState(() {
      _types = value;
      _selectedType = sel ?? (value.isNotEmpty ? value.first : null);
    });
  });
}

  @override
  void didUpdateWidget(covariant ProductDetailForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.product.productId != widget.product.productId) {
      nameController.text = widget.product.name;
      priceController.text = widget.product.sellPrice.toString();
      stockController.text = widget.product.stock.toString();
      imageUrlController.text = widget.product.imageUrl;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _save() async {
  final updated = Product(
    productId: widget.product.productId,
    name: nameController.text,
    brandId: _selectedBrand?.brandId ?? widget.product.brandId,
    typeId: _selectedType?.typeId ?? widget.product.typeId,
    supplierId: _selectedSupplier?.supplierId ?? widget.product.supplierId,
    description: descriptionController.text,
    actualPrice: int.tryParse(actualPriceController.text) ?? 0,
    sellPrice: int.tryParse(sellPriceController.text) ?? 0,
    stock: int.tryParse(stockController.text) ?? 0,
    faceSize: faceSizeController.text,
    thickness: thicknessController.text,
    wireSize: wireSizeController.text,
    energy: energyController.text,
    productLine: productLineController.text,
    faceShape: faceShapeController.text,
    faceColor: faceColorController.text,
    wireType: wireTypeController.text,
    wireColor: wireColorController.text,
    shellColor: shellColorController.text,
    shellStyle: shellStyleController.text,
    madeIn: madeInController.text,
    imageUrl: imageUrlController.text,
    purchaseCount: int.tryParse(purchaseCountController.text) ?? 0,
    sex: int.tryParse(sexController.text) ?? 0,
    watchModel: watchModelController.text,
    typeName: typeNameController.text,
    isActive: isActiveValue ? 1 : 0,
    visible: visibleValue ? 1 : 0,
    isDeleted: isDeletedValue ? 1 : 0, 
    isHot: 0,
  );

  final url = Uri.parse('http://103.77.243.218/api/product/${updated.productId}');
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(updated.toJson()),
  );

  if (response.statusCode == 200) {
    if (!mounted) return;
    widget.onSave(updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã cập nhật sản phẩm thành công')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lỗi: ${response.statusCode} - ${response.body}')),
    );
  }
}

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thông tin sản phẩm', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),

          Center(
            child: Image.network(
              imageUrlController.text,
              height: 150,
              errorBuilder: (_, __, ___) => const Icon(Icons.watch, size: 100),
            ),
          ),
          const SizedBox(height: 16),

          _buildTextField('Tên sản phẩm', nameController),
          _buildDropdown<Brand>(
            label: 'Brand',
            value: _selectedBrand,
            items: _brands,
            itemLabel: (b) => b.name,
            onChanged: (val) => setState(() => _selectedBrand = val),
          ),
          _buildDropdown<WatchType>(
            label: 'Type',
            value: _selectedType,
            items: _types,
            itemLabel: (t) => t.typeName,
            onChanged: (val) => setState(() => _selectedType = val),
          ),
          _buildDropdown<Supplier>(
            label: 'Supplier',
            value: _selectedSupplier,
            items: _suppliers,
            itemLabel: (s) => s.name,
            onChanged: (val) => setState(() => _selectedSupplier = val),
          ),
          _buildTextField('Mô tả', descriptionController, maxLines: 3),
          _buildTextField('Giá gốc', actualPriceController, isNumber: true),
          _buildTextField('Giá bán', sellPriceController, isNumber: true),
          _buildTextField('Tồn kho', stockController, isNumber: true),
          _buildTextField('Kích thước mặt', faceSizeController),
          _buildTextField('Độ dày', thicknessController),
          _buildTextField('Kích thước dây', wireSizeController),
          _buildTextField('Nguồn năng lượng', energyController),
          _buildTextField('Dòng sản phẩm', productLineController),
          _buildTextField('Hình dạng mặt', faceShapeController),
          _buildTextField('Màu mặt', faceColorController),
          _buildTextField('Loại dây', wireTypeController),
          _buildTextField('Màu dây', wireColorController),
          _buildTextField('Màu vỏ', shellColorController),
          _buildTextField('Kiểu vỏ', shellStyleController),
          _buildTextField('Nơi sản xuất', madeInController),
          _buildTextField('URL ảnh đại diện', imageUrlController, onChanged: (_) => setState(() {})),
          _buildTextField('Số lần mua', purchaseCountController, isNumber: true),
          _buildTextField('Giới tính', sexController, isNumber: true),
          _buildTextField('Model', watchModelController),
          _buildTextField('Tên loại', typeNameController),

          // Checkbox cho isActive, visible, isDeleted
          Row(
            children: [
              _buildCheckbox('Hoạt động', isActiveValue, (val) => setState(() => isActiveValue = val ?? false)),
              _buildCheckbox('Hiển thị', visibleValue, (val) => setState(() => visibleValue = val ?? false)),
            ],
          ),

          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('Lưu thay đổi'),
            ),
          )
        ],
      ),
    ),
  );
}

// Helper widget xây dựng TextField gọn
Widget _buildTextField(String label, TextEditingController controller,
    {bool isNumber = false, int maxLines = 1, void Function(String)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    ),
  );
}

// Helper widget for Dropdown
Widget _buildDropdown<T>({
  required String label,
  required T? value,
  required List<T> items,
  required String Function(T) itemLabel,
  required ValueChanged<T?> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: Text(itemLabel(e)),
              ))
          .toList(),
      onChanged: onChanged,
    ),
  );
}

// Helper widget xây dựng Checkbox
Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
  return Expanded(
    child: Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Flexible(child: Text(label)),
      ],
    ),
  );
}
}
