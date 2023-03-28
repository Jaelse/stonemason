import 'package:freezed_annotation/freezed_annotation.dart';
{{> relations }}

part '{{entity_name}}_entity.g.dart';
part '{{entity_name}}_entity.freezed.dart';

@freezed
class {{entity_name.pascalCase()}}Entity with _${{entity_name.pascalCase()}}Entity {
const factory {{entity_name.pascalCase()}}Entity({{#hasProperties}} {
{{#properties}}
{{^isNullable}}required{{/isNullable}} {{type}} {{name}},
{{/properties}}
} {{/hasProperties}}) = _{{entity_name.pascalCase()}}Entity;

factory {{entity_name.pascalCase()}}Entity.fromModel({{entity_name.pascalCase()ApiModel model}}) =>
  {{entity_name.pascalCase()}}Entity(
    {{#hasProperties}} { {{#properties}}
        {{name}}: model.{{name}} ,
      {{/properties}} } {{/hasProperties}});
}