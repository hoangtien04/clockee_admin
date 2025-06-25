import 'package:clockee_manager/models/brand.dart';
import 'package:clockee_manager/models/product.dart';
import 'package:clockee_manager/models/supplier.dart';
import 'package:clockee_manager/models/product_image.dart';
import 'package:flutter/material.dart';
import 'package:clockee_manager/models/type.dart';



class ProductForm extends StatefulWidget {
  final Product? product;
  final List<Brand> brandList;
  final List<WatchType> typeList;
  final List<Supplier> supplierList;
  final List<ProductImage> imageList;
  final Function(Product, List<ProductImage>) onSubmit;

  const ProductForm({
    this.product,
    required this.brandList,
    required this.typeList,
    required this.supplierList,
    required this.imageList,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _brandId, _typeId, _supplierId, _actualPrice, _sellPrice, _stock, _purchaseCount;
  late String _description, _faceSize, _thickness, _wireSize, _energy, _productLine, _faceShape, _faceColor, _wireType, _wireColor, _shellColor, _shellStyle, _madeIn, _imageUrl, _watchModel;
  late bool _isActive, _visible, _isDeleted, _isHot, _sex;
  late String _imageUrl1, _imageUrl2, _imageUrl3;

  int? _supplierid;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _name = p?.name ?? '';
    _brandId = p?.brandId ?? 1;
    _typeId = p?.typeId ?? 1;
    _supplierId = p?.supplierId ?? 1;
    _description = p?.description ?? '';
    _actualPrice = p?.actualPrice ?? 0;
    _sellPrice = p?.sellPrice ?? 0;
    _stock = p?.stock ?? 0;
    _faceSize = p?.faceSize ?? '';
    _thickness = p?.thickness ?? '';
    _wireSize = p?.wireSize ?? '';
    _energy = p?.energy ?? '';
    _productLine = p?.productLine ?? '';
    _faceShape = p?.faceShape ?? '';
    _faceColor = p?.faceColor ?? '';
    _wireType = p?.wireType ?? '';
    _wireColor = p?.wireColor ?? '';
    _shellColor = p?.shellColor ?? '';
    _shellStyle = p?.shellStyle ?? '';
    _madeIn = p?.madeIn ?? '';
    _isActive = p?.isActive ?? true;
    _visible = p?.visible ?? true;
    _isDeleted = p?.isDeleted ?? false;
    _imageUrl = p?.imageUrl ?? '';
    _purchaseCount = p?.purchaseCount ?? 0;
    _isHot = p?.isHot ?? true;
    _sex = p?.sex ?? false;
    _watchModel = p?.watchModel ?? '';
    _imageUrl1 = widget.imageList.length > 0 ? widget.imageList[0].imageUrl : '';
    _imageUrl2 = widget.imageList.length > 1 ? widget.imageList[1].imageUrl : '';
    _imageUrl3 = widget.imageList.length > 2 ? widget.imageList[2].imageUrl : '';
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
            TextFormField(
              initialValue: _actualPrice.toString(),
              decoration: InputDecoration(labelText: 'Giá gốc'),
              keyboardType: TextInputType.number,
              onSaved: (v) => _actualPrice = int.tryParse(v ?? '0') ?? 0,
            ),
            TextFormField(
              initialValue: _sellPrice.toString(),
              decoration: InputDecoration(labelText: 'Giá bán'),
              keyboardType: TextInputType.number,
              onSaved: (v) => _sellPrice = int.tryParse(v ?? '0') ?? 0,
            ),
            TextFormField(
              initialValue: _stock.toString(),
              decoration: InputDecoration(labelText: 'Kho'),
              keyboardType: TextInputType.number,
              onSaved: (v) => _stock = int.tryParse(v ?? '0') ?? 0,
            ),
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Mô tả'),
              onSaved: (v) => _description = v ?? '',
              maxLines: 2,
            ),
            TextFormField(
              initialValue: _imageUrl,
              decoration: InputDecoration(labelText: 'Ảnh chính sản phẩm (URL)'),
              onSaved: (v) => _imageUrl = v ?? '',
            ),
            TextFormField(
              initialValue: widget.imageList.length > 0 ? widget.imageList[0].imageUrl : '',
              decoration: InputDecoration(labelText: 'Ảnh 1 sản phẩm (URL)'),
              onSaved: (v) => _imageUrl1 = v ?? '',
            ),
            TextFormField(
              initialValue: widget.imageList.length > 1 ? widget.imageList[1].imageUrl : '',
              decoration: InputDecoration(labelText: 'Ảnh 2 sản phẩm (URL)'),
              onSaved: (v) => _imageUrl2 = v ?? '',
            ),
            TextFormField(
              initialValue: widget.imageList.length > 2 ? widget.imageList[2].imageUrl : '',
              decoration: InputDecoration(labelText: 'Ảnh 3 sản phẩm (URL)'),
              onSaved: (v) => _imageUrl3 = v ?? '',
            ),
            DropdownButtonFormField<int>(
              value: _brandId ?? 1,
              decoration: InputDecoration(labelText: 'Thương hiệu'),
              items: widget.brandList
                  .map((brand) => DropdownMenuItem(
                      value: brand.brandId, child: Text(brand.name)))
                  .toList(),
              onChanged: (v) => setState(() => _brandId = v!),
            ),
            // Dropdown type
            DropdownButtonFormField<int>(
              value: _typeId ?? 1,
              decoration: InputDecoration(labelText: 'Loại đồng hồ'),
              items: widget.typeList
                  .map((type) => DropdownMenuItem(
                      value: type.typeId, child: Text(type.typeName)))
                  .toList(),
              onChanged: (v) => setState(() => _typeId = v!),
            ),
            // Dropdown supplier
            DropdownButtonFormField<int>(
              value: _supplierId ?? 1,
              decoration: InputDecoration(labelText: 'Nhà cung cấp'),
              items: widget.supplierList
                  .map((s) => DropdownMenuItem(
                      value: s.supplierId, child: Text(s.name)))
                  .toList(),
              onChanged: (v) => setState(() => _supplierId = v!),
            ),
            TextFormField(
              initialValue: _faceSize,
              decoration: InputDecoration(labelText: 'Kích thước mặt'),
              onSaved: (v) => _faceSize = v ?? '',
            ),
            TextFormField(
              initialValue: _thickness,
              decoration: InputDecoration(labelText: 'Độ dày'),
              onSaved: (v) => _thickness = v ?? '',
            ),
            TextFormField(
              initialValue: _wireSize,
              decoration: InputDecoration(labelText: 'Độ rộng dây'),
              onSaved: (v) => _wireSize = v ?? '',
            ),
            TextFormField(
              initialValue: _energy,
              decoration: InputDecoration(labelText: 'Loại năng lượng'),
              onSaved: (v) => _energy = v ?? '',
            ),
            TextFormField(
              initialValue: _productLine,
              decoration: InputDecoration(labelText: 'Dòng sản phẩm'),
              onSaved: (v) => _productLine = v ?? '',
            ),
            TextFormField(
              initialValue: _faceShape,
              decoration: InputDecoration(labelText: 'Dạng mặt'),
              onSaved: (v) => _faceShape = v ?? '',
            ),
            TextFormField(
              initialValue: _faceColor,
              decoration: InputDecoration(labelText: 'Màu mặt'),
              onSaved: (v) => _faceColor = v ?? '',
            ),
            TextFormField(
              initialValue: _wireType,
              decoration: InputDecoration(labelText: 'Loại dây'),
              onSaved: (v) => _wireType = v ?? '',
            ),
            TextFormField(
              initialValue: _wireColor,
              decoration: InputDecoration(labelText: 'Màu dây'),
              onSaved: (v) => _wireColor = v ?? '',
            ),
            TextFormField(
              initialValue: _shellColor,
              decoration: InputDecoration(labelText: 'Màu vỏ'),
              onSaved: (v) => _shellColor = v ?? '',
            ),
            TextFormField(
              initialValue: _shellStyle,
              decoration: InputDecoration(labelText: 'Kiểu vỏ'),
              onSaved: (v) => _shellStyle = v ?? '',
            ),
            TextFormField(
              initialValue: _madeIn,
              decoration: InputDecoration(labelText: 'Xuất xứ'),
              onSaved: (v) => _madeIn = v ?? '',
            ),
            TextFormField(
              initialValue: _watchModel,
              decoration: InputDecoration(labelText: 'Model'),
              onSaved: (v) => _watchModel = v ?? '',
            ),
               // Dropdown sex
            DropdownButtonFormField<bool>(
              value: _sex ?? false,
              decoration: InputDecoration(labelText: 'Giới tính'),
              items: [
                DropdownMenuItem(value: false, child: Text('Nữ')),
                DropdownMenuItem(value: true, child: Text('Nam')),
                // Nếu có Unisex, cần sửa lại model sex kiểu int
              ],
              onChanged: (v) => setState(() => _sex = v!),
            ),
            // Bool switch
            SwitchListTile(
              value: _isActive,
              title: Text('Đang kinh doanh'),
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SwitchListTile(
              value: _visible,
              title: Text('Hiển thị'),
              onChanged: (v) => setState(() => _visible = v),
            ),
            SwitchListTile(
              value: _isDeleted,
              title: Text('Đã xóa'),
              onChanged: (v) => setState(() => _isDeleted = v),
            ),
            SwitchListTile(
              value: _isHot,
              title: Text('Nổi bật'),
              onChanged: (v) => setState(() => _isHot = v),
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

      final List<ProductImage> imageList = [
        ProductImage(
          imageId: widget.imageList.length > 0 ? widget.imageList[0].imageId : 0,
          productId: widget.product?.productId ?? 0,
          imageUrl: _imageUrl1,
        ),
        ProductImage(
          imageId: widget.imageList.length > 1 ? widget.imageList[1].imageId : 0,
          productId: widget.product?.productId ?? 0,
          imageUrl: _imageUrl2,
        ),
        ProductImage(
          imageId: widget.imageList.length > 2 ? widget.imageList[2].imageId : 0,
          productId: widget.product?.productId ?? 0,
          imageUrl: _imageUrl3,
        ),
      ];

      widget.onSubmit(
        Product(
          productId: widget.product?.productId,
          name: _name,
          brandId: _brandId,
          typeId: _typeId,
          supplierId: _supplierId,
          description: _description,
          actualPrice: _actualPrice,
          sellPrice: _sellPrice,
          stock: _stock,
          faceSize: _faceSize,
          thickness: _thickness,
          wireSize: _wireSize,
          energy: _energy,
          productLine: _productLine,
          faceShape: _faceShape,
          faceColor: _faceColor,
          wireType: _wireType,
          wireColor: _wireColor,
          shellColor: _shellColor,
          shellStyle: _shellStyle,
          madeIn: _madeIn,
          isActive: _isActive,
          visible: _visible,
          isDeleted: _isDeleted,
          imageUrl: _imageUrl,
          purchaseCount: _purchaseCount,
          isHot: _isHot,
          sex: _sex,
          watchModel: _watchModel,
        ),
        imageList, // <-- truyền list ảnh qua đây
      );
    }
  },
  child: Text('Cập nhật'),
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
