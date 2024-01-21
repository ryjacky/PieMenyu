// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_item_task.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieItemTaskSchema = Schema(
  name: r'PieItemTask',
  id: 5168616107860454445,
  properties: {
    r'arguments': PropertySchema(
      id: 0,
      name: r'arguments',
      type: IsarType.stringList,
    ),
    r'repeat': PropertySchema(
      id: 1,
      name: r'repeat',
      type: IsarType.long,
    ),
    r'taskType': PropertySchema(
      id: 2,
      name: r'taskType',
      type: IsarType.byte,
      enumMap: _PieItemTasktaskTypeEnumValueMap,
    )
  },
  estimateSize: _pieItemTaskEstimateSize,
  serialize: _pieItemTaskSerialize,
  deserialize: _pieItemTaskDeserialize,
  deserializeProp: _pieItemTaskDeserializeProp,
);

int _pieItemTaskEstimateSize(
  PieItemTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.arguments.length * 3;
  {
    for (var i = 0; i < object.arguments.length; i++) {
      final value = object.arguments[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _pieItemTaskSerialize(
  PieItemTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.arguments);
  writer.writeLong(offsets[1], object.repeat);
  writer.writeByte(offsets[2], object.taskType.index);
}

PieItemTask _pieItemTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItemTask(
    arguments: reader.readStringList(offsets[0]) ?? const [],
    repeat: reader.readLongOrNull(offsets[1]) ?? 1,
    taskType:
        _PieItemTasktaskTypeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
            PieItemTaskType.sendKey,
  );
  return object;
}

P _pieItemTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? const []) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 2:
      return (_PieItemTasktaskTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          PieItemTaskType.sendKey) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PieItemTasktaskTypeEnumValueMap = {
  'sendKey': 0,
  'mouseClick': 1,
  'runFile': 2,
  'openSubMenu': 3,
  'openFolder': 4,
  'openApp': 5,
  'openUrl': 6,
  'openEditor': 7,
  'resizeWindow': 8,
  'moveWindow': 9,
  'sendText': 10,
};
const _PieItemTasktaskTypeValueEnumMap = {
  0: PieItemTaskType.sendKey,
  1: PieItemTaskType.mouseClick,
  2: PieItemTaskType.runFile,
  3: PieItemTaskType.openSubMenu,
  4: PieItemTaskType.openFolder,
  5: PieItemTaskType.openApp,
  6: PieItemTaskType.openUrl,
  7: PieItemTaskType.openEditor,
  8: PieItemTaskType.resizeWindow,
  9: PieItemTaskType.moveWindow,
  10: PieItemTaskType.sendText,
};

extension PieItemTaskQueryFilter
    on QueryBuilder<PieItemTask, PieItemTask, QFilterCondition> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arguments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arguments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arguments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arguments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'arguments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'arguments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'arguments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'arguments',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arguments',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'arguments',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> repeatEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeat',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      repeatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeat',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> repeatLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeat',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> repeatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> taskTypeEqualTo(
      PieItemTaskType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskType',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      taskTypeGreaterThan(
    PieItemTaskType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskType',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      taskTypeLessThan(
    PieItemTaskType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskType',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> taskTypeBetween(
    PieItemTaskType lower,
    PieItemTaskType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PieItemTaskQueryObject
    on QueryBuilder<PieItemTask, PieItemTask, QFilterCondition> {}
