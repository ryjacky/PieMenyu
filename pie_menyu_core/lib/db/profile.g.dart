// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfileCollection on Isar {
  IsarCollection<Profile> get profiles => this.collection();
}

const ProfileSchema = CollectionSchema(
  name: r'Profile',
  id: 1266279811925214857,
  properties: {
    r'enabled': PropertySchema(
      id: 0,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'iconBase64': PropertySchema(
      id: 1,
      name: r'iconBase64',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'pieMenuHotkeys': PropertySchema(
      id: 3,
      name: r'pieMenuHotkeys',
      type: IsarType.objectList,
      target: r'PieMenuHotkey',
    )
  },
  estimateSize: _profileEstimateSize,
  serialize: _profileSerialize,
  deserialize: _profileDeserialize,
  deserializeProp: _profileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'exes': LinkSchema(
      id: -8697642031775185937,
      name: r'exes',
      target: r'ProfileExe',
      single: false,
      linkName: r'profile',
    ),
    r'pieMenus': LinkSchema(
      id: 7685601216207819822,
      name: r'pieMenus',
      target: r'PieMenu',
      single: false,
    )
  },
  embeddedSchemas: {r'PieMenuHotkey': PieMenuHotkeySchema},
  getId: _profileGetId,
  getLinks: _profileGetLinks,
  attach: _profileAttach,
  version: '3.1.0+1',
);

int _profileEstimateSize(
  Profile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.iconBase64.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pieMenuHotkeys.length * 3;
  {
    final offsets = allOffsets[PieMenuHotkey]!;
    for (var i = 0; i < object.pieMenuHotkeys.length; i++) {
      final value = object.pieMenuHotkeys[i];
      bytesCount +=
          PieMenuHotkeySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _profileSerialize(
  Profile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeString(offsets[1], object.iconBase64);
  writer.writeString(offsets[2], object.name);
  writer.writeObjectList<PieMenuHotkey>(
    offsets[3],
    allOffsets,
    PieMenuHotkeySchema.serialize,
    object.pieMenuHotkeys,
  );
}

Profile _profileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Profile(
    enabled: reader.readBoolOrNull(offsets[0]) ?? true,
    iconBase64: reader.readStringOrNull(offsets[1]) ?? "",
    name: reader.readStringOrNull(offsets[2]) ?? 'New Profile',
  );
  object.id = id;
  object.pieMenuHotkeys = reader.readObjectList<PieMenuHotkey>(
        offsets[3],
        PieMenuHotkeySchema.deserialize,
        allOffsets,
        PieMenuHotkey(),
      ) ??
      [];
  return object;
}

P _profileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? 'New Profile') as P;
    case 3:
      return (reader.readObjectList<PieMenuHotkey>(
            offset,
            PieMenuHotkeySchema.deserialize,
            allOffsets,
            PieMenuHotkey(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profileGetId(Profile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profileGetLinks(Profile object) {
  return [object.exes, object.pieMenus];
}

void _profileAttach(IsarCollection<dynamic> col, Id id, Profile object) {
  object.id = id;
  object.exes.attach(col, col.isar.collection<ProfileExe>(), r'exes', id);
  object.pieMenus.attach(col, col.isar.collection<PieMenu>(), r'pieMenus', id);
}

extension ProfileQueryWhereSort on QueryBuilder<Profile, Profile, QWhere> {
  QueryBuilder<Profile, Profile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProfileQueryWhere on QueryBuilder<Profile, Profile, QWhereClause> {
  QueryBuilder<Profile, Profile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Profile, Profile, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idBetween(
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

extension ProfileQueryFilter
    on QueryBuilder<Profile, Profile, QFilterCondition> {
  QueryBuilder<Profile, Profile, QAfterFilterCondition> enabledEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64EqualTo(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64GreaterThan(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64LessThan(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64Between(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64StartsWith(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64EndsWith(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64Contains(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64Matches(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> iconBase64IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenuHotkeysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieMenuHotkeys',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenuHotkeysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieMenuHotkeys',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenuHotkeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieMenuHotkeys',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenuHotkeysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieMenuHotkeys',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenuHotkeysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieMenuHotkeys',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenuHotkeysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pieMenuHotkeys',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ProfileQueryObject
    on QueryBuilder<Profile, Profile, QFilterCondition> {
  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenuHotkeysElement(
      FilterQuery<PieMenuHotkey> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pieMenuHotkeys');
    });
  }
}

extension ProfileQueryLinks
    on QueryBuilder<Profile, Profile, QFilterCondition> {
  QueryBuilder<Profile, Profile, QAfterFilterCondition> exes(
      FilterQuery<ProfileExe> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'exes');
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exes', length, true, length, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exes', 0, true, 0, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exes', 0, false, 999999, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exes', 0, true, length, include);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exes', length, include, 999999, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'exes', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenus(
      FilterQuery<PieMenu> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'pieMenus');
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenusLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', length, true, length, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', 0, true, 0, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', 0, false, 999999, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenusLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', 0, true, length, include);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      pieMenusLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pieMenus', length, include, 999999, true);
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> pieMenusLengthBetween(
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

extension ProfileQuerySortBy on QueryBuilder<Profile, Profile, QSortBy> {
  QueryBuilder<Profile, Profile, QAfterSortBy> sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByIconBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByIconBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ProfileQuerySortThenBy
    on QueryBuilder<Profile, Profile, QSortThenBy> {
  QueryBuilder<Profile, Profile, QAfterSortBy> thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByIconBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByIconBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconBase64', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ProfileQueryWhereDistinct
    on QueryBuilder<Profile, Profile, QDistinct> {
  QueryBuilder<Profile, Profile, QDistinct> distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByIconBase64(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconBase64', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ProfileQueryProperty
    on QueryBuilder<Profile, Profile, QQueryProperty> {
  QueryBuilder<Profile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Profile, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<Profile, String, QQueryOperations> iconBase64Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconBase64');
    });
  }

  QueryBuilder<Profile, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Profile, List<PieMenuHotkey>, QQueryOperations>
      pieMenuHotkeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieMenuHotkeys');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieMenuHotkeySchema = Schema(
  name: r'PieMenuHotkey',
  id: -2367573848846612281,
  properties: {
    r'alt': PropertySchema(
      id: 0,
      name: r'alt',
      type: IsarType.bool,
    ),
    r'ctrl': PropertySchema(
      id: 1,
      name: r'ctrl',
      type: IsarType.bool,
    ),
    r'keyId': PropertySchema(
      id: 2,
      name: r'keyId',
      type: IsarType.long,
    ),
    r'pieMenuId': PropertySchema(
      id: 3,
      name: r'pieMenuId',
      type: IsarType.long,
    ),
    r'shift': PropertySchema(
      id: 4,
      name: r'shift',
      type: IsarType.bool,
    )
  },
  estimateSize: _pieMenuHotkeyEstimateSize,
  serialize: _pieMenuHotkeySerialize,
  deserialize: _pieMenuHotkeyDeserialize,
  deserializeProp: _pieMenuHotkeyDeserializeProp,
);

int _pieMenuHotkeyEstimateSize(
  PieMenuHotkey object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pieMenuHotkeySerialize(
  PieMenuHotkey object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.alt);
  writer.writeBool(offsets[1], object.ctrl);
  writer.writeLong(offsets[2], object.keyId);
  writer.writeLong(offsets[3], object.pieMenuId);
  writer.writeBool(offsets[4], object.shift);
}

PieMenuHotkey _pieMenuHotkeyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenuHotkey(
    alt: reader.readBoolOrNull(offsets[0]) ?? false,
    ctrl: reader.readBoolOrNull(offsets[1]) ?? false,
    keyId: reader.readLongOrNull(offsets[2]),
    pieMenuId: reader.readLongOrNull(offsets[3]) ?? 0,
    shift: reader.readBoolOrNull(offsets[4]) ?? false,
  );
  return object;
}

P _pieMenuHotkeyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieMenuHotkeyQueryFilter
    on QueryBuilder<PieMenuHotkey, PieMenuHotkey, QFilterCondition> {
  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition> altEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alt',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition> ctrlEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ctrl',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      keyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'keyId',
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      keyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'keyId',
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      keyIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      keyIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      keyIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      keyIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      pieMenuIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieMenuId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      pieMenuIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieMenuId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      pieMenuIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieMenuId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      pieMenuIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieMenuId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenuHotkey, PieMenuHotkey, QAfterFilterCondition>
      shiftEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shift',
        value: value,
      ));
    });
  }
}

extension PieMenuHotkeyQueryObject
    on QueryBuilder<PieMenuHotkey, PieMenuHotkey, QFilterCondition> {}
