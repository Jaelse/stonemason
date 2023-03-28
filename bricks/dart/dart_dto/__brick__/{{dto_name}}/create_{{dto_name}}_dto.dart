import 'package:freezed_annotation/freezed_annotation.dart';
{{> relations }}

part 'create_{{dto_name}}_dto.g.dart';
part 'create_{{dto_name}}_dto.freezed.dart';

@freezed
class Create{{dto_name.pascalCase()}}Dto with _$Create{{dto_name.pascalCase()}}Dto {
  const factory Create{{dto_name.pascalCase()}}Dto({{#hasProperties}} {
    {{#properties}}
        {{^isNullable}}required{{/isNullable}} {{type}} {{name}},
    {{/properties}}
} {{/hasProperties}}) = _Create{{dto_name.pascalCase()}}Dto;

  factory Create{{dto_name.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) =>
      _$Create{{dto_name.pascalCase()}}DtoFromJson(json);
}