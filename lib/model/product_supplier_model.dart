ProductSupplier getProductSupplierFromJson(Map<String, dynamic> str) =>
    ProductSupplier.fromJson(str);

class ProductSupplier {
  late int id;
  late String name;
  late bool inBusiness;

  ProductSupplier(
      {required this.id, required this.name, required this.inBusiness});

  ProductSupplier.fromJson(Map<String, dynamic> json) {
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
