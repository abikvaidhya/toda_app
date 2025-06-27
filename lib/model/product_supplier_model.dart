ProductSupplierModel getProductSupplierFromJson(Map<String, dynamic> str) =>
    ProductSupplierModel.fromJson(str);

class ProductSupplierModel {
  late int id;
  late String name;
  late bool inBusiness;

  ProductSupplierModel(
      {required this.id, required this.name, required this.inBusiness});

  ProductSupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    inBusiness = json['in_business'];
  }

  Map<String, dynamic> toJson() {
    final vendor = <String, dynamic>{};
    vendor['id'] = id;
    vendor['name'] = name;
    vendor['in_business'] = inBusiness;

    return vendor;
  }
}
