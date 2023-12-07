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
    ),
    r'beginningTask': LinkSchema(
      id: 1390805873144296387,
      name: r'beginningTask',
      target: r'PieItemTask',
      single: true,
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
  return [object.pieMenus, object.beginningTask];
}

void _pieItemAttach(IsarCollection<dynamic> col, Id id, PieItem object) {
  object.id = id;
  object.pieMenus.attach(col, col.isar.collection<PieMenu>(), r'pieMenus', id);
  object.beginningTask
      .attach(col, col.isar.collection<PieItemTask>(), r'beginningTask', id);
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

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> beginningTask(
      FilterQuery<PieItemTask> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'beginningTask');
    });
  }

  QueryBuilder<PieItem, PieItem, QAfterFilterCondition> beginningTaskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'beginningTask', 0, true, 0, true);
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
