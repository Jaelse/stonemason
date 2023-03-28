import lombok.Builder;
import lombok.Getter;
import lombok.experimental.Accessors;
import org.bson.types.ObjectId;

@Getter
@Builder
@Accessors(fluent = true)
public class Create{{dto_name.pascalCase()}}Dto {
    {{#hasProperties}}
        {{#properties}}
            {{^isNullable}}@NonNull{{/isNullable}}
            private {{type}} {{name}};
        {{/properties}}
    {{/hasProperties}}
}