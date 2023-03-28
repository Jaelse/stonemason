import 'dart:convert';

class JavaProperty {
  const JavaProperty({
    required this.name,
    required this.type,
    this.isNullable = false
  });

  final String name;
  final String type;
  final bool isNullable;

  factory JavaProperty.fromMap(Map<String, dynamic> map) {
    return JavaProperty(
      name: map['name'] as String,
      type: map['type'] as String,
      isNullable: map['isNullable'],
    );
  }

  factory JavaProperty.fromJson(String source) =>
      JavaProperty.fromMap(json.decode(source) as Map<String, dynamic>);
}
