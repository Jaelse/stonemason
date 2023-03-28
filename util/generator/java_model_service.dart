import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';

import 'data_types.dart';
import 'java_property.dart';

abstract class JavaModelService {
  static void verifySeededProperties(
      List<dynamic> seededProperties,
      Logger logger,
      ) {
    for (final property in seededProperties) {
      try {
        JavaProperty.fromJson(jsonEncode(property));
      } catch (e) {
        logger.err('''
                    Could not parse property: $property
                    Please check the variable names of your properties. It should be along the lines of:
                    { "name": "firstName", "type": "String" }
        ''');
        exit(0);
      }
    }
  }

  static void addProperties(
      Logger logger,
      List<Map<String, dynamic>> properties,
      ) {
    logger
      ..info(lightYellow.wrap('enter `e` to exit adding properties'))
      ..info(
        lightYellow.wrap(
            'Format: dataType propertyName e.g. nonnull String myProperty:'),
      );

    while (true) {
      final property =
      logger.prompt(':').replaceAll(RegExp(r'\s+'), ' ').trim();
      if (property.toLowerCase() == 'e') {
        break;
      }

      if (!property.contains(' ')) {
        logger.alert(
          'That was not a valid format -> dataType propertyName e.g, String myProperty',
        );
        continue;
      }

      if ((property.contains('<') && !property.contains('>')) ||
          (properties.contains('>') && !property.contains('<'))) {
        logger.alert(
          'It seems you are missing a < or >, please retype this property',
        );
        continue;
      }

      final splitProperty = property.split(' ');
      final propertyNonNullable = splitProperty[0] == "nonnull";
      final propertyType = splitProperty[1];
      final propertyName = splitProperty[2];

      addProperty(
          properties,
          JavaProperty(
            name: propertyName,
            type: propertyType,
            isNullable: propertyNonNullable,
          ));
    }
  }

  /// Adds a [property] to the [properties] list.
  static void addProperty(
      List<Map<String, dynamic>> properties,
      JavaProperty property,
      ) {
    final hasSpecial = property.type.toLowerCase().contains('<') ||
        property.type.toLowerCase().contains('>');
    final listProperties = getCustomListProperties(hasSpecial, property.type);
    final isCustomDataType =
        !DataTypes.javaValues.contains(property.type) && !hasSpecial;
    properties
      ..forEach((e) => e['isLastProperty'] = false)
      ..add({
        'name': property.name,
        'type': property.type,
        'isNullable': property.isNullable,
        'hasSpecial': hasSpecial,
        'isCustomDataType': isCustomDataType,
        'isLastProperty': true,
        ...listProperties,
      });
  }

  /// Checks to see if the property type is special.
  ///
  /// This check is required due to the mustache syntax:
  /// All variables are HTML escaped by default. If you want
  /// to return unescaped HTML, use the triple mustache: {{{name}}}.
  ///
  /// returns a [Map<String, dynamic>] containing the properties variables
  static Map<String, dynamic> getCustomListProperties(
      bool hasSpecial,
      String propertyType,
      ) {
    if (!hasSpecial || !propertyType.contains('List')) {
      return {
        'isCustomList': false,
      };
    }
    final startIndex = propertyType.indexOf('<');
    final endIndex = propertyType.indexOf('>');
    final listType = propertyType.substring(startIndex + 1, endIndex).trim();
    if (DataTypes.javaValues.contains(listType)) {
      return {
        'isCustomList': false,
      };
    }
    return {
      'isCustomList': true,
      'customListType': listType,
    };
  }
}
