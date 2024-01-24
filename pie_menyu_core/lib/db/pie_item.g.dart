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
  properties: {
    r'iconBase64': PropertySchema(
      id: 0,
      name: r'iconBase64',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'tasks': PropertySchema(
      id: 2,
      name: r'tasks',
      type: IsarType.objectList,
      target: r'PieItemTask',
    )
  },
  estimateSize: _pieItemEstimateSize,
  serialize: _pieItemSerialize,
  deserialize: _pieItemDeserialize,
  deserializeProp: _pieItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'PieItemTask': PieItemTaskSchema},
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
  bytesCount += 3 + object.iconBase64.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.tasks.length * 3;
  {
    final offsets = allOffsets[PieItemTask]!;
    for (var i = 0; i < object.tasks.length; i++) {
      final value = object.tasks[i];
      bytesCount += PieItemTaskSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _pieItemSerialize(
  PieItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.iconBase64);
  writer.writeString(offsets[1], object.name);
  writer.writeObjectList<PieItemTask>(
    offsets[2],
    allOffsets,
    PieItemTaskSchema.serialize,
    object.tasks,
  );
}

PieItem _pieItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItem(
    iconBase64: reader.readStringOrNull(offsets[0]) ?? '',
    name: reader.readStringOrNull(offsets[1]) ?? '',
  );
  object.id = id;
  object.tasks = reader.readObjectList<PieItemTask>(
        offsets[2],
        PieItemTaskSchema.deserialize,
        allOffsets,
        PieItemTask(),
      ) ??
      [];
  return object;
}

P _pieItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readObjectList<PieItemTask>(
            offset,
            PieItemTaskSchema.deserialize,
            allOffsets,
            PieItemTask(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pieItemGetId(PieItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pieItemGetLinks(PieItem object) {
  return [];
}

void _pieItemAttach(IsarCollection<dynamic> col, Id id, PieItem object) {
  object.id = id;
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
  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconBase64',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconBase64',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> iconBase64IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconBase64',
        value: '',
      ));
    });
  }

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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PieItemQueryObject
    on QueryBuilder<PieItem, PieItem, QFilterCondition> {
  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> tasksElement(
      FilterQuery<PieItemTask> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tasks');
    });
  }
}

extension PieItemQueryLinks
    on QueryBuilder<PieItem, PieItem, QFilterCondition> {}

extension PieItemQuerySortBy on QueryBuilder<PieItem, PieItem, QSortBy> {
  QueryBuilder<PieItem, PieItem, QAfterSortBy> sortByIconBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.asc);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterSortBy> sortByIconBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.desc);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PieItemQuerySortThenBy
    on QueryBuilder<PieItem, PieItem, QSortThenBy> {
  QueryBuilder<PieItem, PieItem, QAfterSortBy> thenByIconBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.asc);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterSortBy> thenByIconBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.desc);
    });
  }

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

  QueryBuilder<PieItem, PieItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PieItemQueryWhereDistinct
    on QueryBuilder<PieItem, PieItem, QDistinct> {
  QueryBuilder<PieItem, PieItem, QDistinct> distinctByIconBase64(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconBase64', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PieItem, PieItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension PieItemQueryProperty
    on QueryBuilder<PieItem, PieItem, QQueryProperty> {
  QueryBuilder<PieItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PieItem, String, QQueryOperations> iconBase64Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconBase64');
    });
  }

  QueryBuilder<PieItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PieItem, List<PieItemTask>, QQueryOperations> tasksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tasks');
    });
  }
}
