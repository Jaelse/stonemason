import 'package:mason/mason.dart';

import '../../../../util/generator/dart_dto_service.dart';
import '../../../../util/generator/property.dart';

void run(HookContext context) async {
  final logger = context.logger;
  logger.info(context.vars['dto_name']);
  final additionals = context.vars['additionals'] as List<dynamic>;
  final modelStyle = context.vars['style'] as String;
  var hasRelations = context.vars['relations'] != null &&
      (context.vars['relations'] as List).isNotEmpty;
  context.vars = {
    ...context.vars,
    'hasRelations': hasRelations,
    'use_copywith': additionals.contains('copyWith'),
    'use_json': additionals.contains('json'),
    'use_equatable': additionals.contains('equatable'),
    'use_tostring': additionals.contains('toString'),
    'use_none': modelStyle == 'basic',
    'use_serializable': modelStyle == 'json_serializable',
    'use_freezed': modelStyle == 'freezed',
    'jsonIndex': ((context.vars['jsonIndex'] as int?) ?? 0),
  };

  final hasSeededProperties = context.vars['properties'] != null &&
      (context.vars['properties'] as List).isNotEmpty;

  final properties = <Map<String, dynamic>>[];

  if (hasSeededProperties) {
    final seededProperties = context.vars['properties'] as List;
    DartDtoService.verifySeededProperties(seededProperties, logger);
    for (final property in seededProperties) {
      DartDtoService.addProperty(
        properties,
        Property.fromMap(property as Map<String, dynamic>),
      );
    }
  } else if (logger.confirm(
    '? Do you want to add properties to your dto?',
    defaultValue: true,
  )) {
    DartDtoService.addProperties(logger, properties);
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
