// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPieItemCollection on Isar {
  IsarCollection<PieItem> get pieItems => this.collection();
}

const PieItemSchema = CollectionSchema(
  name: r'PieItem',
  id: 2206230188476552550,
  properties: {},
  estimateSize: _pieItemEstimateSize,
  serialize: _pieItemSerialize,
  deserialize: _pieItemDeserialize,
  deserializeProp: _pieItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'pieMenus': LinkSchema(
      id: 6484480270944672114,
      name: r'pieMenus',
      target: r'PieMenu',
      single: false,
      linkName: r'pieItems',
    )
  },
  embeddedSchemas: {},
  getId: _pieItemGetId,
  getLinks: _pieItemGetLinks,
  attach: _pieItemAttach,
  version: '3.1.0+1',
);

int _pieItemEstimateSize(
  PieItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pieItemSerialize(
  PieItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {}
PieItem _pieItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItem();
  object.id = id;
  return object;
}

P _pieItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pieItemGetId(PieItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pieItemGetLinks(PieItem object) {
  return [object.pieMenus];
}

void _pieItemAttach(IsarCollection<dynamic> col, Id id, PieItem object) {
  object.id = id;
  object.pieMenus.attach(col, col.isar.collection<PieMenu>(), r'pieMenus', id);
}

extension PieItemQueryWhereSort on QueryBuilder<PieItem, PieItem, QWhere> {
  QueryBuilder<PieItem, PieItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PieItemQueryWhere on QueryBuilder<PieItem, PieItem, QWhereClause> {
  QueryBuilder<PieItem, PieItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PieItem, PieItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterWhereClause> idBetween(
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

extension PieItemQueryFilter
    on QueryBuilder<PieItem, PieItem, QFilterCondition> {
  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> idBetween(
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
}

extension PieItemQueryObject
    on QueryBuilder<PieItem, PieItem, QFilterCondition> {}

extension PieItemQueryLinks
    on QueryBuilder<PieItem, PieItem, QFilterCondition> {
  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> pieMenus(
      FilterQuery<PieMenu> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'pieMenus');
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> pieMenusLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', length, true, length, true);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> pieMenusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', 0, true, 0, true);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> pieMenusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', 0, false, 999999, true);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> pieMenusLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', 0, true, length, include);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition>
      pieMenusLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', length, include, 999999, true);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> pieMenusLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'pieMenus', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PieItemQuerySortBy on QueryBuilder<PieItem, PieItem, QSortBy> {}

extension PieItemQuerySortThenBy
    on QueryBuilder<PieItem, PieItem, QSortThenBy> {
  QueryBuilder<PieItem, PieItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension PieItemQueryWhereDistinct
    on QueryBuilder<PieItem, PieItem, QDistinct> {}

extension PieItemQueryProperty
    on QueryBuilder<PieItem, PieItem, QQueryProperty> {
  QueryBuilder<PieItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieItemTaskSchema = Schema(
  name: r'PieItemTask',
  id: 5168616107860454445,
  properties: {
    r'addonId': PropertySchema(
      id: 0,
      name: r'addonId',
      type: IsarType.string,
    ),
    r'arguments': PropertySchema(
      id: 1,
      name: r'arguments',
      type: IsarType.objectList,
      target: r'PieItemTaskArgument',
    ),
    r'delay': PropertySchema(
      id: 2,
      name: r'delay',
      type: IsarType.long,
    ),
    r'repeat': PropertySchema(
      id: 3,
      name: r'repeat',
      type: IsarType.long,
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
  bytesCount += 3 + object.addonId.length * 3;
  bytesCount += 3 + object.arguments.length * 3;
  {
    final offsets = allOffsets[PieItemTaskArgument]!;
    for (var i = 0; i < object.arguments.length; i++) {
      final value = object.arguments[i];
      bytesCount +=
          PieItemTaskArgumentSchema.estimateSize(value, offsets, allOffsets);
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
  writer.writeString(offsets[0], object.addonId);
  writer.writeObjectList<PieItemTaskArgument>(
    offsets[1],
    allOffsets,
    PieItemTaskArgumentSchema.serialize,
    object.arguments,
  );
  writer.writeLong(offsets[2], object.delay);
  writer.writeLong(offsets[3], object.repeat);
}

PieItemTask _pieItemTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItemTask();
  object.addonId = reader.readString(offsets[0]);
  object.arguments = reader.readObjectList<PieItemTaskArgument>(
        offsets[1],
        PieItemTaskArgumentSchema.deserialize,
        allOffsets,
        PieItemTaskArgument(),
      ) ??
      [];
  object.delay = reader.readLong(offsets[2]);
  object.repeat = reader.readLong(offsets[3]);
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
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<PieItemTaskArgument>(
            offset,
            PieItemTaskArgumentSchema.deserialize,
            allOffsets,
            PieItemTaskArgument(),
          ) ??
          []) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieItemTaskQueryFilter
    on QueryBuilder<PieItemTask, PieItemTask, QFilterCondition> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> addonIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addonId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      addonIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addonId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> addonIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addonId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> addonIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addonId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      addonIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addonId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> addonIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addonId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> addonIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addonId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> addonIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addonId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      addonIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addonId',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      addonIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addonId',
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

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> delayEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'delay',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      delayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'delay',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> delayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'delay',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition> delayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'delay',
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
}

extension PieItemTaskQueryObject
    on QueryBuilder<PieItemTask, PieItemTask, QFilterCondition> {
  QueryBuilder<PieItemTask, PieItemTask, QAfterFilterCondition>
      argumentsElement(FilterQuery<PieItemTaskArgument> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'arguments');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieItemTaskArgumentSchema = Schema(
  name: r'PieItemTaskArgument',
  id: -8115335963055004307,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 1,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _pieItemTaskArgumentEstimateSize,
  serialize: _pieItemTaskArgumentSerialize,
  deserialize: _pieItemTaskArgumentDeserialize,
  deserializeProp: _pieItemTaskArgumentDeserializeProp,
);

int _pieItemTaskArgumentEstimateSize(
  PieItemTaskArgument object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _pieItemTaskArgumentSerialize(
  PieItemTaskArgument object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.value);
}

PieItemTaskArgument _pieItemTaskArgumentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItemTaskArgument();
  object.name = reader.readString(offsets[0]);
  object.value = reader.readString(offsets[1]);
  return object;
}

P _pieItemTaskArgumentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieItemTaskArgumentQueryFilter on QueryBuilder<PieItemTaskArgument,
    PieItemTaskArgument, QFilterCondition> {
  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemTaskArgument, PieItemTaskArgument, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension PieItemTaskArgumentQueryObject on QueryBuilder<PieItemTaskArgument,
    PieItemTaskArgument, QFilterCondition> {}
