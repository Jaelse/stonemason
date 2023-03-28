@Getter
@Setter
@Builder
public class {{model_name.pascalCase()}}Model{
    {{#properties}}
        private {{type}} {{name}};
    {{/properties}}
}