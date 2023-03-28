
@Component
public class {{model_name.pascalCase()}}Assembler {

    public {{model_name.pascalCase()}}Model assemble({{entity_name.pascalCase()}}Entity {{entity_name}}){
        {{model_name.pascalCase()}}Model.{{model_name.pascalCase()}}ModelBuilder builder = {{model_name.pascalCase()}}Model.builder();

        builder
        {{#properties}}
            .{{name}}({{entity_name}}.get{{name.pascalCase()}}())
        {{/properties}}

        return builder.build();
    }
}