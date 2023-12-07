// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_item_task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPieItemTaskCollection on Isar {
  IsarCollection<PieItemTask> get pieItemTasks => this.collection();
}

const PieItemTaskSchema = CollectionSchema(
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
  idName: r'id',
  indexes: {},
  links: {
    r'nextTask': LinkSchema(
      id: 2726062798711907089,
      name: r'nextTask',
      target: r'PieItemTask',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _pieItemTaskGetId,
  getLinks: _pieItemTaskGetLinks,
  attach: _pieItemTaskAttach,
  version: '3.1.0+1',
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
            PieItemTaskType.addon,
  );
  object.id = id;
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
          PieItemTaskType.addon) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PieItemTasktaskTypeEnumValueMap = {
  'addon': 0,
  'delay': 1,
  'repeat': 2,
  'arguments': 3,
  'nextTask': 4,
};
const _PieItemTasktaskTypeValueEnumMap = {
  0: PieItemTaskType.addon,
  1: PieItemTaskType.delay,
  2: PieItemTaskType.repeat,
  3: PieItemTaskType.arguments,
  4: PieItemTaskType.nextTask,
};

Id _pieItemTaskGetId(PieItemTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pieItemTaskGetLinks(PieItemTask object) {
  return [object.nextTask];
}

void _pieItemTaskAttach(
    IsarCollection<dynamic> col, Id id, PieItemTask object) {
  object.id = id;
  object.nextTask
      .attach(col, col.isar.collection<PieItemTask>(), r'nextTask', id);
}

extension PieItemTaskQueryWhereSort
    on QueryBuilder<PieItemTask, PieItemTask, QWhere> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PieItemTaskQueryWhere
    on QueryBuilder<PieItemTask, PieItemTask, QWhereClause> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

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

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
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

extension PieItemTaskQueryLinks
    on QueryBuilder<PieItemTask, PieItemTask, QFilterCondition> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> nextTask(
      FilterQuery<PieItemTask> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'nextTask');
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      nextTaskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'nextTask', 0, true, 0, true);
    });
  }
}

extension PieItemTaskQuerySortBy
    on QueryBuilder<PieItemTask, PieItemTask, QSortBy> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> sortByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.asc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> sortByRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.desc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> sortByTaskType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskType', Sort.asc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> sortByTaskTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskType', Sort.desc);
    });
  }
}

extension PieItemTaskQuerySortThenBy
    on QueryBuilder<PieItemTask, PieItemTask, QSortThenBy> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> thenByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.asc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> thenByRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.desc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> thenByTaskType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskType', Sort.asc);
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterSortBy> thenByTaskTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskType', Sort.desc);
    });
  }
}

extension PieItemTaskQueryWhereDistinct
    on QueryBuilder<PieItemTask, PieItemTask, QDistinct> {
  QueryBuilder<PieItemTask, PieItemTask, QDistinct> distinctByArguments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arguments');
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QDistinct> distinctByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeat');
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QDistinct> distinctByTaskType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskType');
    });
  }
}

extension PieItemTaskQueryProperty
    on QueryBuilder<PieItemTask, PieItemTask, QQueryProperty> {
  QueryBuilder<PieItemTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PieItemTask, List<String>, QQueryOperations>
      argumentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arguments');
    });
  }

  QueryBuilder<PieItemTask, int, QQueryOperations> repeatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeat');
    });
  }

  QueryBuilder<PieItemTask, PieItemTaskType, QQueryOperations>
      taskTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskType');
    });
  }
}
