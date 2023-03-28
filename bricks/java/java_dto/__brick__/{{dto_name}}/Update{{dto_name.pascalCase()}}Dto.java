import lombok.Builder;
import lombok.Getter;
import lombok.experimental.Accessors;
import org.bson.types.ObjectId;
import java.util.Optional;

@Setter
@Builder
@Accessors(fluent = true)
public class Update{{dto_name.pascalCase()}}Dto {
    {{#hasProperties}}
        {{#properties}}
            private {{{type}}} {{name}};
        {{/properties}}
    {{/hasProperties}}


    {{#properties}}
        public Optional<{{type}}> maybe{{name.pascalCase()}}(){
            return Optional.ofNullable({{name}});
        }

    {{/properties}}
}