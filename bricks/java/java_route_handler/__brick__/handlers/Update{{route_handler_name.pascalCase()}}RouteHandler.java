package {{package_name}};

import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import org.springframework.beans.factory.annotation.Autowired;
import reactor.core.publisher.Mono;


@Component
public class Update{{route_handler_name.pascalCase()}}RouteHandler implements HandlerFunction<ServerResponse> {
        {{#dependencies}}
            private final {{name}} {{name.camelCase()}};
        {{/dependencies}}


        @Autowired
        public Update{{route_handler_name.pascalCase()}}RouteHandler(
                {{#dependencies}}
                    {{name}} {{name.camelCase()}},
                {{/dependencies}}
        ){
        {{#dependencies}}
            this.{{name.camelCase()}}  = {{name.camelCase()}};
        {{/dependencies}}
        }

        @Override
        public Mono<ServerResponse> handle(ServerRequest request) {
            return null;
        }
}