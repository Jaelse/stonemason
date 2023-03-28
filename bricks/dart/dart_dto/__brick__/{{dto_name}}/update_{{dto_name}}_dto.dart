import 'package:freezed_annotation/freezed_annotation.dart';
{{> relations }}

part 'update_{{dto_name}}_dto.g.dart';
part 'update_{{dto_name}}_dto.freezed.dart';

@freezed
class Update{{dto_name.pascalCase()}}Dto with _$Update{{dto_name.pascalCase()}}Dto {
const factory Update{{dto_name.pascalCase()}}Dto({{#hasProperties}} {
{{#properties}}
{{^isNullable}}required{{/isNullable}} {{type}} {{name}},
{{/properties}}
} {{/hasProperties}}) = _Update{{dto_name.pascalCase()}}Dto;

factory Update{{dto_name.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) =>
_$Update{{dto_name.pascalCase()}}DtoFromJson(json);
}