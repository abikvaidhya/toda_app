import 'package:cloud_firestore/cloud_firestore.dart';

class BaseUnit {
  BaseUnit({
    required this.code,
    required this.label,
    required this.description,
  });

  late final int code;
  late final String label;
  late final String description;

  BaseUnit.fromJson(Map<String, dynamic> json) {
    code = int.parse(json['id'].toString());
    label = json['label'];
    description = json['value'];
  }

  factory BaseUnit.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return BaseUnit(
        code: int.parse(documentSnapshot.id.toString()),
        label: (docData['label']).toString(),
        description: (docData['value']).toString());
  }

  Map<String, dynamic> toJson() {
    final baseUnit = <String, dynamic>{};
    baseUnit['label'] = label;
    baseUnit['value'] = description;
    return baseUnit;
  }
}
