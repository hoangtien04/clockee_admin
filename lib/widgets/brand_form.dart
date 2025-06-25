import 'package:clockee_manager/models/brand.dart';
import 'package:clockee_manager/models/product.dart';
import 'package:clockee_manager/models/supplier.dart';
import 'package:clockee_manager/models/product_image.dart';
import 'package:flutter/material.dart';
import 'package:clockee_manager/models/type.dart';



class BrandForm extends StatefulWidget {
  final Brand? brand;
  final List<Brand> brandList;
  final Function(Brand) onSubmit;

  const BrandForm({
    this.brand,
    required this.brandList,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<BrandForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<BrandForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _brandId;
  late bool _isDeleted;

  int? _supplierid;

  @override
  void initState() {
    super.initState();
    final p = widget.brand;
    _name = p?.name ?? '';
    _brandId = p?.brandId ?? 1;
    _isDeleted = p?.Is_deleted ?? false;
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Tên sản phẩm'),
              onSaved: (v) => _name = v ?? '',
              validator: (v) => v == null || v.isEmpty ? 'Nhập tên' : null,
            ),
            SwitchListTile(
              value: _isDeleted,
              title: Text('Đã xóa'),
              onChanged: (v) => setState(() => _isDeleted = v),
            ),
         
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Huỷ'),
                ),
                ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      widget.onSubmit(
        Brand(
          brandId: widget.brand?.brandId,
          name: _name,
          Is_deleted: _isDeleted,
        ),
      );
    }
  },
  child: Text(widget.brand == null ? 'Thêm mới' : 'Cập nhật'),
),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

}
