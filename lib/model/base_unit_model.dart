BaseUnitModel getBaseUnitFromJson(Map<String, dynamic> str) =>
    BaseUnitModel.fromJson(str);

class BaseUnitModel {
  BaseUnitModel({
    required this.code,
    required this.label,
    required this.description,
  });

  late final int code;
  late final String label;
  late final String description;

  BaseUnitModel.fromJson(Map<String, dynamic> json) {
    code = int.parse(json['id'].toString());
    label = json['label'];
    description = json['value'];
  }

  Map<String, dynamic> toJson() {
    final baseUnit = <String, dynamic>{};
    baseUnit['label'] = label;
    baseUnit['value'] = description;
    return baseUnit;
  }
}
