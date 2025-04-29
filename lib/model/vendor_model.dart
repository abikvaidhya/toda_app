class ProductVendor {
  late int id;
  late String name;
  late bool inBusiness;

  ProductVendor(
      {required this.id, required this.name, required this.inBusiness});

  ProductVendor.fromJson(Map<String, dynamic> json) {
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
