// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_menu.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPieMenuCollection on Isar {
  IsarCollection<PieMenu> get pieMenus => this.collection();
}

const PieMenuSchema = CollectionSchema(
  name: r'PieMenu',
  id: -1347626773998044354,
  properties: {
    r'behavior': PropertySchema(
      id: 0,
      name: r'behavior',
      type: IsarType.object,
      target: r'PieMenuBehavior',
    ),
    r'colors': PropertySchema(
      id: 1,
      name: r'colors',
      type: IsarType.object,
      target: r'PieMenuColors',
    ),
    r'enabled': PropertySchema(
      id: 2,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'font': PropertySchema(
      id: 3,
      name: r'font',
      type: IsarType.object,
      target: r'PieMenuFont',
    ),
    r'icon': PropertySchema(
      id: 4,
      name: r'icon',
      type: IsarType.object,
      target: r'PieMenuIcon',
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'pieItemInstances': PropertySchema(
      id: 6,
      name: r'pieItemInstances',
      type: IsarType.objectList,
      target: r'PieItemDelegate',
    ),
    r'shape': PropertySchema(
      id: 7,
      name: r'shape',
      type: IsarType.object,
      target: r'PieMenuShape',
    )
  },
  estimateSize: _pieMenuEstimateSize,
  serialize: _pieMenuSerialize,
  deserialize: _pieMenuDeserialize,
  deserializeProp: _pieMenuDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'profiles': LinkSchema(
      id: -7916542860931486755,
      name: r'profiles',
      target: r'Profile',
      single: false,
      linkName: r'pieMenus',
    )
  },
  embeddedSchemas: {
    r'PieMenuColors': PieMenuColorsSchema,
    r'PieMenuIcon': PieMenuIconSchema,
    r'PieMenuFont': PieMenuFontSchema,
    r'PieMenuBehavior': PieMenuBehaviorSchema,
    r'PieMenuShape': PieMenuShapeSchema,
    r'PieItemDelegate': PieItemDelegateSchema
  },
  getId: _pieMenuGetId,
  getLinks: _pieMenuGetLinks,
  attach: _pieMenuAttach,
  version: '3.1.0+1',
);

int _pieMenuEstimateSize(
  PieMenu object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      PieMenuBehaviorSchema.estimateSize(
          object.behavior, allOffsets[PieMenuBehavior]!, allOffsets);
  bytesCount += 3 +
      PieMenuColorsSchema.estimateSize(
          object.colors, allOffsets[PieMenuColors]!, allOffsets);
  bytesCount += 3 +
      PieMenuFontSchema.estimateSize(
          object.font, allOffsets[PieMenuFont]!, allOffsets);
  bytesCount += 3 +
      PieMenuIconSchema.estimateSize(
          object.iconStyle, allOffsets[PieMenuIconStyle]!, allOffsets);
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pieItemInstances.length * 3;
  {
    final offsets = allOffsets[PieItemDelegate]!;
    for (var i = 0; i < object.pieItemInstances.length; i++) {
      final value = object.pieItemInstances[i];
      bytesCount +=
          PieItemDelegateSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 +
      PieMenuShapeSchema.estimateSize(
          object.shape, allOffsets[PieMenuShape]!, allOffsets);
  return bytesCount;
}

void _pieMenuSerialize(
  PieMenu object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<PieMenuBehavior>(
    offsets[0],
    allOffsets,
    PieMenuBehaviorSchema.serialize,
    object.behavior,
  );
  writer.writeObject<PieMenuColors>(
    offsets[1],
    allOffsets,
    PieMenuColorsSchema.serialize,
    object.colors,
  );
  writer.writeBool(offsets[2], object.enabled);
  writer.writeObject<PieMenuFont>(
    offsets[3],
    allOffsets,
    PieMenuFontSchema.serialize,
    object.font,
  );
  writer.writeObject<PieMenuIconStyle>(
    offsets[4],
    allOffsets,
    PieMenuIconSchema.serialize,
    object.iconStyle,
  );
  writer.writeString(offsets[5], object.name);
  writer.writeObjectList<PieItemDelegate>(
    offsets[6],
    allOffsets,
    PieItemDelegateSchema.serialize,
    object.pieItemInstances,
  );
  writer.writeObject<PieMenuShape>(
    offsets[7],
    allOffsets,
    PieMenuShapeSchema.serialize,
    object.shape,
  );
}

PieMenu _pieMenuDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenu();
  object.behavior = reader.readObjectOrNull<PieMenuBehavior>(
        offsets[0],
        PieMenuBehaviorSchema.deserialize,
        allOffsets,
      ) ??
      PieMenuBehavior();
  object.colors = reader.readObjectOrNull<PieMenuColors>(
        offsets[1],
        PieMenuColorsSchema.deserialize,
        allOffsets,
      ) ??
      PieMenuColors();
  object.enabled = reader.readBool(offsets[2]);
  object.font = reader.readObjectOrNull<PieMenuFont>(
        offsets[3],
        PieMenuFontSchema.deserialize,
        allOffsets,
      ) ??
      PieMenuFont();
  object.iconStyle = reader.readObjectOrNull<PieMenuIconStyle>(
        offsets[4],
        PieMenuIconSchema.deserialize,
        allOffsets,
      ) ??
      PieMenuIconStyle();
  object.id = id;
  object.name = reader.readString(offsets[5]);
  object.pieItemInstances = reader.readObjectList<PieItemDelegate>(
        offsets[6],
        PieItemDelegateSchema.deserialize,
        allOffsets,
        PieItemDelegate(),
      ) ??
      [];
  object.shape = reader.readObjectOrNull<PieMenuShape>(
        offsets[7],
        PieMenuShapeSchema.deserialize,
        allOffsets,
      ) ??
      PieMenuShape();
  return object;
}

P _pieMenuDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<PieMenuBehavior>(
            offset,
            PieMenuBehaviorSchema.deserialize,
            allOffsets,
          ) ??
          PieMenuBehavior()) as P;
    case 1:
      return (reader.readObjectOrNull<PieMenuColors>(
            offset,
            PieMenuColorsSchema.deserialize,
            allOffsets,
          ) ??
          PieMenuColors()) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<PieMenuFont>(
            offset,
            PieMenuFontSchema.deserialize,
            allOffsets,
          ) ??
          PieMenuFont()) as P;
    case 4:
      return (reader.readObjectOrNull<PieMenuIconStyle>(
            offset,
            PieMenuIconSchema.deserialize,
            allOffsets,
          ) ??
          PieMenuIconStyle()) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readObjectList<PieItemDelegate>(
            offset,
            PieItemDelegateSchema.deserialize,
            allOffsets,
            PieItemDelegate(),
          ) ??
          []) as P;
    case 7:
      return (reader.readObjectOrNull<PieMenuShape>(
            offset,
            PieMenuShapeSchema.deserialize,
            allOffsets,
          ) ??
          PieMenuShape()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pieMenuGetId(PieMenu object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pieMenuGetLinks(PieMenu object) {
  return [object.profiles];
}

void _pieMenuAttach(IsarCollection<dynamic> col, Id id, PieMenu object) {
  object.id = id;
  object.profiles.attach(col, col.isar.collection<Profile>(), r'profiles', id);
}

extension PieMenuQueryWhereSort on QueryBuilder<PieMenu, PieMenu, QWhere> {
  QueryBuilder<PieMenu, PieMenu, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PieMenuQueryWhere on QueryBuilder<PieMenu, PieMenu, QWhereClause> {
  QueryBuilder<PieMenu, PieMenu, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PieMenu, PieMenu, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterWhereClause> idBetween(
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

extension PieMenuQueryFilter
    on QueryBuilder<PieMenu, PieMenu, QFilterCondition> {
  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> enabledEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameContains(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemInstancesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieItemInstances',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemInstancesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieItemInstances',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemInstancesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieItemInstances',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemInstancesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieItemInstances',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemInstancesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieItemInstances',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemInstancesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieItemInstances',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PieMenuQueryObject
    on QueryBuilder<PieMenu, PieMenu, QFilterCondition> {
  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> behavior(
      FilterQuery<PieMenuBehavior> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'behavior');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> colors(
      FilterQuery<PieMenuColors> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'colors');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> font(
      FilterQuery<PieMenuFont> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'font');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> icon(
      FilterQuery<PieMenuIconStyle> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'icon');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemInstancesElement(
      FilterQuery<PieItemDelegate> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pieItemInstances');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> shape(
      FilterQuery<PieMenuShape> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'shape');
    });
  }
}

extension PieMenuQueryLinks
    on QueryBuilder<PieMenu, PieMenu, QFilterCondition> {
  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> profiles(
      FilterQuery<Profile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'profiles');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> profilesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'profiles', length, true, length, true);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> profilesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'profiles', 0, true, 0, true);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> profilesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'profiles', 0, false, 999999, true);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> profilesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'profiles', 0, true, length, include);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      profilesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'profiles', length, include, 999999, true);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> profilesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'profiles', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PieMenuQuerySortBy on QueryBuilder<PieMenu, PieMenu, QSortBy> {
  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PieMenuQuerySortThenBy
    on QueryBuilder<PieMenu, PieMenu, QSortThenBy> {
  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PieMenuQueryWhereDistinct
    on QueryBuilder<PieMenu, PieMenu, QDistinct> {
  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension PieMenuQueryProperty
    on QueryBuilder<PieMenu, PieMenu, QQueryProperty> {
  QueryBuilder<PieMenu, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PieMenu, PieMenuBehavior, QQueryOperations> behaviorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'behavior');
    });
  }

  QueryBuilder<PieMenu, PieMenuColors, QQueryOperations> colorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colors');
    });
  }

  QueryBuilder<PieMenu, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<PieMenu, PieMenuFont, QQueryOperations> fontProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'font');
    });
  }

  QueryBuilder<PieMenu, PieMenuIconStyle, QQueryOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icon');
    });
  }

  QueryBuilder<PieMenu, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PieMenu, List<PieItemDelegate>, QQueryOperations>
      pieItemInstancesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieItemInstances');
    });
  }

  QueryBuilder<PieMenu, PieMenuShape, QQueryOperations> shapeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shape');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieMenuColorsSchema = Schema(
  name: r'PieMenuColors',
  id: -5289383185187812041,
  properties: {
    r'primary': PropertySchema(
      id: 0,
      name: r'primary',
      type: IsarType.long,
    ),
    r'secondary': PropertySchema(
      id: 1,
      name: r'secondary',
      type: IsarType.long,
    )
  },
  estimateSize: _pieMenuColorsEstimateSize,
  serialize: _pieMenuColorsSerialize,
  deserialize: _pieMenuColorsDeserialize,
  deserializeProp: _pieMenuColorsDeserializeProp,
);

int _pieMenuColorsEstimateSize(
  PieMenuColors object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pieMenuColorsSerialize(
  PieMenuColors object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.primary);
  writer.writeLong(offsets[1], object.secondary);
}

PieMenuColors _pieMenuColorsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenuColors();
  object.primary = reader.readLong(offsets[0]);
  object.secondary = reader.readLong(offsets[1]);
  return object;
}

P _pieMenuColorsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieMenuColorsQueryFilter
    on QueryBuilder<PieMenuColors, PieMenuColors, QFilterCondition> {
  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      primaryEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primary',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      primaryGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primary',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      primaryLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primary',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      primaryBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      secondaryEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondary',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      secondaryGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondary',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      secondaryLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondary',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuColors, PieMenuColors, QAfterFilterCondition>
      secondaryBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PieMenuColorsQueryObject
    on QueryBuilder<PieMenuColors, PieMenuColors, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieMenuIconSchema = Schema(
  name: r'PieMenuIcon',
  id: 5631395984661722160,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'size': PropertySchema(
      id: 1,
      name: r'size',
      type: IsarType.double,
    )
  },
  estimateSize: _pieMenuIconEstimateSize,
  serialize: _pieMenuIconSerialize,
  deserialize: _pieMenuIconDeserialize,
  deserializeProp: _pieMenuIconDeserializeProp,
);

int _pieMenuIconEstimateSize(
  PieMenuIconStyle object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pieMenuIconSerialize(
  PieMenuIconStyle object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeDouble(offsets[1], object.size);
}

PieMenuIconStyle _pieMenuIconDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenuIconStyle();
  object.color = reader.readLong(offsets[0]);
  object.size = reader.readDouble(offsets[1]);
  return object;
}

P _pieMenuIconDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieMenuIconQueryFilter
    on QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QFilterCondition> {
  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> colorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition>
      colorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> colorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> colorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> sizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> sizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> sizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QAfterFilterCondition> sizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PieMenuIconQueryObject
    on QueryBuilder<PieMenuIconStyle, PieMenuIconStyle, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieMenuFontSchema = Schema(
  name: r'PieMenuFont',
  id: -1433570879642134295,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'fontFamily': PropertySchema(
      id: 1,
      name: r'fontFamily',
      type: IsarType.string,
    ),
    r'size': PropertySchema(
      id: 2,
      name: r'size',
      type: IsarType.double,
    )
  },
  estimateSize: _pieMenuFontEstimateSize,
  serialize: _pieMenuFontSerialize,
  deserialize: _pieMenuFontDeserialize,
  deserializeProp: _pieMenuFontDeserializeProp,
);

int _pieMenuFontEstimateSize(
  PieMenuFont object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fontFamily.length * 3;
  return bytesCount;
}

void _pieMenuFontSerialize(
  PieMenuFont object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeString(offsets[1], object.fontFamily);
  writer.writeDouble(offsets[2], object.size);
}

PieMenuFont _pieMenuFontDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenuFont();
  object.color = reader.readLong(offsets[0]);
  object.fontFamily = reader.readString(offsets[1]);
  object.size = reader.readDouble(offsets[2]);
  return object;
}

P _pieMenuFontDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieMenuFontQueryFilter
    on QueryBuilder<PieMenuFont, PieMenuFont, QFilterCondition> {
  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> colorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      colorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> colorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> colorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontFamily',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fontFamily',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontFamily',
        value: '',
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition>
      fontFamilyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fontFamily',
        value: '',
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> sizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> sizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> sizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuFont, PieMenuFont, QAfterFilterCondition> sizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PieMenuFontQueryObject
    on QueryBuilder<PieMenuFont, PieMenuFont, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieMenuBehaviorSchema = Schema(
  name: r'PieMenuBehavior',
  id: 3078188730846525007,
  properties: {
    r'activationMode': PropertySchema(
      id: 0,
      name: r'activationMode',
      type: IsarType.byte,
      enumMap: _PieMenuBehavioractivationModeEnumValueMap,
    ),
    r'escapeRadius': PropertySchema(
      id: 1,
      name: r'escapeRadius',
      type: IsarType.double,
    ),
    r'openInScreenCenter': PropertySchema(
      id: 2,
      name: r'openInScreenCenter',
      type: IsarType.bool,
    ),
    r'subMenuActivationMode': PropertySchema(
      id: 3,
      name: r'subMenuActivationMode',
      type: IsarType.byte,
      enumMap: _PieMenuBehaviorsubMenuActivationModeEnumValueMap,
    )
  },
  estimateSize: _pieMenuBehaviorEstimateSize,
  serialize: _pieMenuBehaviorSerialize,
  deserialize: _pieMenuBehaviorDeserialize,
  deserializeProp: _pieMenuBehaviorDeserializeProp,
);

int _pieMenuBehaviorEstimateSize(
  PieMenuBehavior object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pieMenuBehaviorSerialize(
  PieMenuBehavior object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.activationMode.index);
  writer.writeDouble(offsets[1], object.escapeRadius);
  writer.writeBool(offsets[2], object.openInScreenCenter);
  writer.writeByte(offsets[3], object.subMenuActivationMode.index);
}

PieMenuBehavior _pieMenuBehaviorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenuBehavior();
  object.activationMode = _PieMenuBehavioractivationModeValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      ActivationMode.onRelease;
  object.escapeRadius = reader.readDouble(offsets[1]);
  object.openInScreenCenter = reader.readBool(offsets[2]);
  object.subMenuActivationMode =
      _PieMenuBehaviorsubMenuActivationModeValueEnumMap[
              reader.readByteOrNull(offsets[3])] ??
          ActivationMode.onRelease;
  return object;
}

P _pieMenuBehaviorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_PieMenuBehavioractivationModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ActivationMode.onRelease) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (_PieMenuBehaviorsubMenuActivationModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ActivationMode.onRelease) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PieMenuBehavioractivationModeEnumValueMap = {
  'onRelease': 0,
  'onHover': 1,
  'onClick': 2,
};
const _PieMenuBehavioractivationModeValueEnumMap = {
  0: ActivationMode.onRelease,
  1: ActivationMode.onHover,
  2: ActivationMode.onClick,
};
const _PieMenuBehaviorsubMenuActivationModeEnumValueMap = {
  'onRelease': 0,
  'onHover': 1,
  'onClick': 2,
};
const _PieMenuBehaviorsubMenuActivationModeValueEnumMap = {
  0: ActivationMode.onRelease,
  1: ActivationMode.onHover,
  2: ActivationMode.onClick,
};

extension PieMenuBehaviorQueryFilter
    on QueryBuilder<PieMenuBehavior, PieMenuBehavior, QFilterCondition> {
  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      activationModeEqualTo(ActivationMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      activationModeGreaterThan(
    ActivationMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      activationModeLessThan(
    ActivationMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      activationModeBetween(
    ActivationMode lower,
    ActivationMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activationMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      escapeRadiusEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'escapeRadius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      escapeRadiusGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'escapeRadius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      escapeRadiusLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'escapeRadius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      escapeRadiusBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'escapeRadius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      openInScreenCenterEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openInScreenCenter',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      subMenuActivationModeEqualTo(ActivationMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subMenuActivationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      subMenuActivationModeGreaterThan(
    ActivationMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subMenuActivationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      subMenuActivationModeLessThan(
    ActivationMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subMenuActivationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuBehavior, PieMenuBehavior, QAfterFilterCondition>
      subMenuActivationModeBetween(
    ActivationMode lower,
    ActivationMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subMenuActivationMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PieMenuBehaviorQueryObject
    on QueryBuilder<PieMenuBehavior, PieMenuBehavior, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieMenuShapeSchema = Schema(
  name: r'PieMenuShape',
  id: 4148130021120429092,
  properties: {
    r'centerRadius': PropertySchema(
      id: 0,
      name: r'centerRadius',
      type: IsarType.double,
    ),
    r'centerThickness': PropertySchema(
      id: 1,
      name: r'centerThickness',
      type: IsarType.double,
    ),
    r'pieItemRoundness': PropertySchema(
      id: 2,
      name: r'pieItemRoundness',
      type: IsarType.double,
    ),
    r'pieItemSpread': PropertySchema(
      id: 3,
      name: r'pieItemSpread',
      type: IsarType.double,
    )
  },
  estimateSize: _pieMenuShapeEstimateSize,
  serialize: _pieMenuShapeSerialize,
  deserialize: _pieMenuShapeDeserialize,
  deserializeProp: _pieMenuShapeDeserializeProp,
);

int _pieMenuShapeEstimateSize(
  PieMenuShape object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pieMenuShapeSerialize(
  PieMenuShape object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.centerRadius);
  writer.writeDouble(offsets[1], object.centerThickness);
  writer.writeDouble(offsets[2], object.pieItemRoundness);
  writer.writeDouble(offsets[3], object.pieItemSpread);
}

PieMenuShape _pieMenuShapeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenuShape();
  object.centerRadius = reader.readDouble(offsets[0]);
  object.centerThickness = reader.readDouble(offsets[1]);
  object.pieItemRoundness = reader.readDouble(offsets[2]);
  object.pieItemSpread = reader.readDouble(offsets[3]);
  return object;
}

P _pieMenuShapeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieMenuShapeQueryFilter
    on QueryBuilder<PieMenuShape, PieMenuShape, QFilterCondition> {
  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerRadiusEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerRadius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerRadiusGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'centerRadius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerRadiusLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'centerRadius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerRadiusBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'centerRadius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerThicknessEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerThickness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerThicknessGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'centerThickness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerThicknessLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'centerThickness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      centerThicknessBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'centerThickness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemRoundnessEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemRoundness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemRoundnessGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieItemRoundness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemRoundnessLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieItemRoundness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemRoundnessBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieItemRoundness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemSpreadEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemSpread',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemSpreadGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieItemSpread',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemSpreadLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieItemSpread',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PieMenuShape, PieMenuShape, QAfterFilterCondition>
      pieItemSpreadBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieItemSpread',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PieMenuShapeQueryObject
    on QueryBuilder<PieMenuShape, PieMenuShape, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieItemDelegateSchema = Schema(
  name: r'PieItemDelegate',
  id: 1829940434680981578,
  properties: {
    r'activationMode': PropertySchema(
      id: 0,
      name: r'activationMode',
      type: IsarType.byte,
      enumMap: _PieItemDelegateactivationModeEnumValueMap,
    ),
    r'keyCode': PropertySchema(
      id: 1,
      name: r'keyCode',
      type: IsarType.string,
    ),
    r'pieItemId': PropertySchema(
      id: 2,
      name: r'pieItemId',
      type: IsarType.long,
    )
  },
  estimateSize: _pieItemDelegateEstimateSize,
  serialize: _pieItemDelegateSerialize,
  deserialize: _pieItemDelegateDeserialize,
  deserializeProp: _pieItemDelegateDeserializeProp,
);

int _pieItemDelegateEstimateSize(
  PieItemDelegate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.keyCode.length * 3;
  return bytesCount;
}

void _pieItemDelegateSerialize(
  PieItemDelegate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.activationMode.index);
  writer.writeString(offsets[1], object.keyCode);
  writer.writeLong(offsets[2], object.pieItemId);
}

PieItemDelegate _pieItemDelegateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItemDelegate(
    keyCode: reader.readStringOrNull(offsets[1]) ?? "",
    pieItemId: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  object.activationMode = _PieItemDelegateactivationModeValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      ActivationMode.onRelease;
  return object;
}

P _pieItemDelegateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_PieItemDelegateactivationModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ActivationMode.onRelease) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PieItemDelegateactivationModeEnumValueMap = {
  'onRelease': 0,
  'onHover': 1,
  'onClick': 2,
};
const _PieItemDelegateactivationModeValueEnumMap = {
  0: ActivationMode.onRelease,
  1: ActivationMode.onHover,
  2: ActivationMode.onClick,
};

extension PieItemDelegateQueryFilter
    on QueryBuilder<PieItemDelegate, PieItemDelegate, QFilterCondition> {
  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      activationModeEqualTo(ActivationMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      activationModeGreaterThan(
    ActivationMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      activationModeLessThan(
    ActivationMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      activationModeBetween(
    ActivationMode lower,
    ActivationMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activationMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      keyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      pieItemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      pieItemIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      pieItemIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemDelegate, PieItemDelegate, QAfterFilterCondition>
      pieItemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PieItemDelegateQueryObject
    on QueryBuilder<PieItemDelegate, PieItemDelegate, QFilterCondition> {}
