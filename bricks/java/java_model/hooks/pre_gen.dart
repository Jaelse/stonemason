import 'package:mason/mason.dart';
import '../../../../util/generator/java_model_service.dart';
import '../../../../util/generator/java_property.dart';

void run(HookContext context) async {
  final logger = context.logger;
  final additionals = context.vars['additionals'] as List<dynamic>;
  logger.info(context.vars['dto_name']);
  var hasRelations = context.vars['relations'] != null &&
      (context.vars['relations'] as List).isNotEmpty;
  context.vars = {
    ...context.vars,
    'hasRelations': hasRelations,
    'jsonIndex': ((context.vars['jsonIndex'] as int?) ?? 0),
  };

  final hasSeededProperties = context.vars['properties'] != null &&
      (context.vars['properties'] as List).isNotEmpty;

  final properties = <Map<String, dynamic>>[];

  if (hasSeededProperties) {
    final seededProperties = context.vars['properties'] as List;
    JavaModelService.verifySeededProperties(seededProperties, logger);
    for (final property in seededProperties) {
      JavaModelService.addProperty(
        properties,
        JavaProperty.fromMap(property as Map<String, dynamic>),
      );
    }
  } else if (logger.confirm(
    '? Do you want to add properties to your dto?',
    defaultValue: true,
  )) {
    JavaModelService.addProperties(logger, properties);
  }

  properties.forEach((element) {
    element.forEach((key, value) {
      logger.info("$key: $value");
    });
  });

  logger.info(properties.isNotEmpty.toString());

  context.vars = {
    ...context.vars,
    'properties': properties,
    'hasProperties': properties.isNotEmpty,
  };
}
