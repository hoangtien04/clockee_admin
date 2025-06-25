class Product {
  int? productId;
  String name;
  int brandId;
  int typeId;
  int supplierId;
  String description;
  int actualPrice;
  int sellPrice;
  int stock;
  String faceSize;
  String thickness;
  String wireSize;
  String energy;
  String productLine;
  String faceShape;
  String faceColor;
  String wireType;
  String wireColor;
  String shellColor;
  String shellStyle;
  String madeIn;
  bool isActive;
  bool visible;
  bool isDeleted;
  String imageUrl;
  int purchaseCount;
  bool isHot;
  bool sex;
  String watchModel;

  Product({
    required this.productId,
    required this.name,
    required this.brandId,
    required this.typeId,
    required this.supplierId,
    required this.description,
    required this.actualPrice,
    required this.sellPrice,
    required this.stock,
    required this.faceSize,
    required this.thickness,
    required this.wireSize,
    required this.energy,
    required this.productLine,
    required this.faceShape,
    required this.faceColor,
    required this.wireType,
    required this.wireColor,
    required this.shellColor,
    required this.shellStyle,
    required this.madeIn,
    required this.isActive,
    required this.visible,
    required this.isDeleted,
    required this.imageUrl,
    required this.purchaseCount,
    required this.isHot,
    required this.sex,
    required this.watchModel,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Product_id'],
      name: json['Name'],
      brandId: json['Brand_id'],
      typeId: json['Type_id'],
      supplierId: json['Supplier_id'],
      description: json['Description'],
      actualPrice: json['Actual_price'],
      sellPrice: json['Sell_price'],
      stock: json['Stock'],
      faceSize: json['Face_size'],
      thickness: json['Thickness'],
      wireSize: json['Wire_size'],
      energy: json['Energy'],
      productLine: json['Product_line'],
      faceShape: json['Face_shape'],
      faceColor: json['Face_color'],
      wireType: json['Wire_type'],
      wireColor: json['Wire_color'],
      shellColor: json['Shell_color'],
      shellStyle: json['Shell_style'],
      madeIn: json['Made_in'],
      isActive: json['Is_active'] == 1,
      visible: json['Visible'] == 1,
      isDeleted: json['Is_deleted'] == 1,
      isHot: json['Is_hot'] == 1,
      imageUrl: json['Image_url'],
      purchaseCount: json['Purchase_count'],
      sex: json['Sex'] == 1,
      watchModel: json['Watch_model'],
    );
  }
  Map<String, dynamic> toJson() => {
    "Product_id": productId,
    "Name": name,
    "Brand_id": brandId,
    "Type_id": typeId,
    "Supplier_id": supplierId,
    "Description": description,
    "Actual_price": actualPrice,
    "Sell_price": sellPrice,
    "Stock": stock,
    "Face_size": faceSize,
    "Thickness": thickness,
    "Wire_size": wireSize,
    "Energy": energy,
    "Product_line": productLine,
    "Face_shape": faceShape,
    "Face_color": faceColor,
    "Wire_type": wireType,
    "Wire_color": wireColor,
    "Shell_color": shellColor,
    "Shell_style": shellStyle,
    "Made_in": madeIn,
    "Is_active": isActive ? 1 : 0,
    "Visible": visible ? 1 : 0,
    "Is_deleted": isDeleted ? 1 : 0,
    "Image_url": imageUrl,
    "Purchase_count": purchaseCount,
    "Is_hot": isHot ? 1 : 0,
    "Sex": sex ? 1 : 0,      // Nếu sex là bool
    "Watch_model": watchModel,
  };

}
