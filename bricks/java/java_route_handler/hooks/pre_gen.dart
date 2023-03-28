import 'package:mason/mason.dart';

import '../../../../util/generator/java_property.dart';
import '../../../../util/generator/java_dto_service.dart';

void run(HookContext context) async {
  final logger = context.logger;
  final dependencies = context.vars['dependencies'] as List<dynamic>;
  dependencies.forEach((element) {
    print(element);
  });
  context.vars = {
    ...context.vars,
    'dependencies': dependencies,
  };
}
