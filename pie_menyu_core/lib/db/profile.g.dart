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
    r'exes': PropertySchema(
      id: 1,
      name: r'exes',
      type: IsarType.stringList,
    ),
    r'hotkeyToPieMenuIdList': PropertySchema(
      id: 2,
      name: r'hotkeyToPieMenuIdList',
      type: IsarType.objectList,
      target: r'HotkeyToPieMenuId',
    ),
    r'iconBase64': PropertySchema(
      id: 3,
      name: r'iconBase64',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _profileEstimateSize,
  serialize: _profileSerialize,
  deserialize: _profileDeserialize,
  deserializeProp: _profileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'pieMenus': LinkSchema(
      id: 7685601216207819822,
      name: r'pieMenus',
      target: r'PieMenu',
      single: false,
    )
  },
  embeddedSchemas: {r'HotkeyToPieMenuId': HotkeyToPieMenuIdSchema},
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
  bytesCount += 3 + object.exes.length * 3;
  {
    for (var i = 0; i < object.exes.length; i++) {
      final value = object.exes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.hotkeyToPieMenuIdList.length * 3;
  {
    final offsets = allOffsets[HotkeyToPieMenuId]!;
    for (var i = 0; i < object.hotkeyToPieMenuIdList.length; i++) {
      final value = object.hotkeyToPieMenuIdList[i];
      bytesCount +=
          HotkeyToPieMenuIdSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.iconBase64.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _profileSerialize(
  Profile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeStringList(offsets[1], object.exes);
  writer.writeObjectList<HotkeyToPieMenuId>(
    offsets[2],
    allOffsets,
    HotkeyToPieMenuIdSchema.serialize,
    object.hotkeyToPieMenuIdList,
  );
  writer.writeString(offsets[3], object.iconBase64);
  writer.writeString(offsets[4], object.name);
}

Profile _profileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Profile(
    enabled: reader.readBoolOrNull(offsets[0]) ?? true,
    iconBase64: reader.readStringOrNull(offsets[3]) ?? "",
    name: reader.readStringOrNull(offsets[4]) ?? 'New Profile',
  );
  object.exes = reader.readStringList(offsets[1]) ?? [];
  object.hotkeyToPieMenuIdList = reader.readObjectList<HotkeyToPieMenuId>(
        offsets[2],
        HotkeyToPieMenuIdSchema.deserialize,
        allOffsets,
        HotkeyToPieMenuId(),
      ) ??
      [];
  object.id = id;
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
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readObjectList<HotkeyToPieMenuId>(
            offset,
            HotkeyToPieMenuIdSchema.deserialize,
            allOffsets,
            HotkeyToPieMenuId(),
          ) ??
          []) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? 'New Profile') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profileGetId(Profile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profileGetLinks(Profile object) {
  return [object.pieMenus];
}

void _profileAttach(IsarCollection<dynamic> col, Id id, Profile object) {
  object.id = id;
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

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exes',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      exesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exes',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> exesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hotkeyToPieMenuIdList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hotkeyToPieMenuIdList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hotkeyToPieMenuIdList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hotkeyToPieMenuIdList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hotkeyToPieMenuIdList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hotkeyToPieMenuIdList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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
}

extension ProfileQueryObject
    on QueryBuilder<Profile, Profile, QFilterCondition> {
  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      hotkeyToPieMenuIdListElement(FilterQuery<HotkeyToPieMenuId> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'hotkeyToPieMenuIdList');
    });
  }
}

extension ProfileQueryLinks
    on QueryBuilder<Profile, Profile, QFilterCondition> {
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

  QueryBuilder<Profile, Profile, QDistinct> distinctByExes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exes');
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

  QueryBuilder<Profile, List<String>, QQueryOperations> exesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exes');
    });
  }

  QueryBuilder<Profile, List<HotkeyToPieMenuId>, QQueryOperations>
      hotkeyToPieMenuIdListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hotkeyToPieMenuIdList');
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
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const HotkeyToPieMenuIdSchema = Schema(
  name: r'HotkeyToPieMenuId',
  id: -6507779408773911994,
  properties: {
    r'keyCode': PropertySchema(
      id: 0,
      name: r'keyCode',
      type: IsarType.byte,
      enumMap: _HotkeyToPieMenuIdkeyCodeEnumValueMap,
    ),
    r'keyModifiers': PropertySchema(
      id: 1,
      name: r'keyModifiers',
      type: IsarType.byteList,
      enumMap: _HotkeyToPieMenuIdkeyModifiersEnumValueMap,
    ),
    r'pieMenuId': PropertySchema(
      id: 2,
      name: r'pieMenuId',
      type: IsarType.long,
    )
  },
  estimateSize: _hotkeyToPieMenuIdEstimateSize,
  serialize: _hotkeyToPieMenuIdSerialize,
  deserialize: _hotkeyToPieMenuIdDeserialize,
  deserializeProp: _hotkeyToPieMenuIdDeserializeProp,
);

int _hotkeyToPieMenuIdEstimateSize(
  HotkeyToPieMenuId object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.keyModifiers.length;
  return bytesCount;
}

void _hotkeyToPieMenuIdSerialize(
  HotkeyToPieMenuId object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.keyCode.index);
  writer.writeByteList(
      offsets[1], object.keyModifiers.map((e) => e.index).toList());
  writer.writeLong(offsets[2], object.pieMenuId);
}

HotkeyToPieMenuId _hotkeyToPieMenuIdDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HotkeyToPieMenuId(
    keyCode: _HotkeyToPieMenuIdkeyCodeValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        KeyCode.space,
    keyModifiers: reader
            .readByteList(offsets[1])
            ?.map((e) =>
                _HotkeyToPieMenuIdkeyModifiersValueEnumMap[e] ??
                KeyModifier.capsLock)
            .toList() ??
        const [],
    pieMenuId: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  return object;
}

P _hotkeyToPieMenuIdDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_HotkeyToPieMenuIdkeyCodeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          KeyCode.space) as P;
    case 1:
      return (reader
              .readByteList(offset)
              ?.map((e) =>
                  _HotkeyToPieMenuIdkeyModifiersValueEnumMap[e] ??
                  KeyModifier.capsLock)
              .toList() ??
          const []) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _HotkeyToPieMenuIdkeyCodeEnumValueMap = {
  'hyper': 0,
  'superKey': 1,
  'fnLock': 2,
  'suspend': 3,
  'resume': 4,
  'sleep': 5,
  'wakeUp': 6,
  'keyA': 7,
  'keyB': 8,
  'keyC': 9,
  'keyD': 10,
  'keyE': 11,
  'keyF': 12,
  'keyG': 13,
  'keyH': 14,
  'keyI': 15,
  'keyJ': 16,
  'keyK': 17,
  'keyL': 18,
  'keyM': 19,
  'keyN': 20,
  'keyO': 21,
  'keyP': 22,
  'keyQ': 23,
  'keyR': 24,
  'keyS': 25,
  'keyT': 26,
  'keyU': 27,
  'keyV': 28,
  'keyW': 29,
  'keyX': 30,
  'keyY': 31,
  'keyZ': 32,
  'digit1': 33,
  'digit2': 34,
  'digit3': 35,
  'digit4': 36,
  'digit5': 37,
  'digit6': 38,
  'digit7': 39,
  'digit8': 40,
  'digit9': 41,
  'digit0': 42,
  'enter': 43,
  'escape': 44,
  'backspace': 45,
  'tab': 46,
  'space': 47,
  'add': 48,
  'minus': 49,
  'numberSign': 50,
  'multiply': 51,
  'equal': 52,
  'bracketLeft': 53,
  'bracketRight': 54,
  'backslash': 55,
  'semicolon': 56,
  'quote': 57,
  'backquote': 58,
  'comma': 59,
  'period': 60,
  'slash': 61,
  'capsLock': 62,
  'f1': 63,
  'f2': 64,
  'f3': 65,
  'f4': 66,
  'f5': 67,
  'f6': 68,
  'f7': 69,
  'f8': 70,
  'f9': 71,
  'f10': 72,
  'f11': 73,
  'f12': 74,
  'printScreen': 75,
  'scrollLock': 76,
  'pause': 77,
  'insert': 78,
  'home': 79,
  'pageUp': 80,
  'delete': 81,
  'end': 82,
  'pageDown': 83,
  'arrowRight': 84,
  'arrowLeft': 85,
  'arrowDown': 86,
  'arrowUp': 87,
  'numLock': 88,
  'numpadDivide': 89,
  'numpadMultiply': 90,
  'numpadSubtract': 91,
  'numpadAdd': 92,
  'numpadEnter': 93,
  'numpad1': 94,
  'numpad2': 95,
  'numpad3': 96,
  'numpad4': 97,
  'numpad5': 98,
  'numpad6': 99,
  'numpad7': 100,
  'numpad8': 101,
  'numpad9': 102,
  'numpad0': 103,
  'numpadDecimal': 104,
  'intlBackslash': 105,
  'contextMenu': 106,
  'power': 107,
  'numpadEqual': 108,
  'f13': 109,
  'f14': 110,
  'f15': 111,
  'f16': 112,
  'f17': 113,
  'f18': 114,
  'f19': 115,
  'f20': 116,
  'f21': 117,
  'f22': 118,
  'f23': 119,
  'f24': 120,
  'open': 121,
  'help': 122,
  'select': 123,
  'again': 124,
  'undo': 125,
  'cut': 126,
  'copy': 127,
  'paste': 128,
  'find': 129,
  'audioVolumeMute': 130,
  'audioVolumeUp': 131,
  'audioVolumeDown': 132,
  'numpadComma': 133,
  'intlRo': 134,
  'kanaMode': 135,
  'intlYen': 136,
  'convert': 137,
  'nonConvert': 138,
  'lang1': 139,
  'lang2': 140,
  'lang3': 141,
  'lang4': 142,
  'lang5': 143,
  'abort': 144,
  'props': 145,
  'numpadParenLeft': 146,
  'numpadParenRight': 147,
  'controlLeft': 148,
  'shiftLeft': 149,
  'altLeft': 150,
  'metaLeft': 151,
  'controlRight': 152,
  'shiftRight': 153,
  'altRight': 154,
  'metaRight': 155,
  'info': 156,
  'closedCaptionToggle': 157,
  'brightnessUp': 158,
  'brightnessDown': 159,
  'mediaLast': 160,
  'launchPhone': 161,
  'exit': 162,
  'channelUp': 163,
  'channelDown': 164,
  'mediaPlay': 165,
  'mediaPause': 166,
  'mediaRecord': 167,
  'mediaFastForward': 168,
  'mediaRewind': 169,
  'mediaTrackNext': 170,
  'mediaTrackPrevious': 171,
  'mediaStop': 172,
  'eject': 173,
  'mediaPlayPause': 174,
  'speechInputToggle': 175,
  'launchWordProcessor': 176,
  'launchSpreadsheet': 177,
  'launchMail': 178,
  'launchContacts': 179,
  'launchCalendar': 180,
  'logOff': 181,
  'launchControlPanel': 182,
  'spellCheck': 183,
  'launchScreenSaver': 184,
  'launchAssistant': 185,
  'newKey': 186,
  'close': 187,
  'save': 188,
  'print': 189,
  'browserSearch': 190,
  'browserHome': 191,
  'browserBack': 192,
  'browserForward': 193,
  'browserStop': 194,
  'browserRefresh': 195,
  'browserFavorites': 196,
  'zoomIn': 197,
  'zoomOut': 198,
  'zoomToggle': 199,
  'redo': 200,
  'mailReply': 201,
  'mailForward': 202,
  'mailSend': 203,
  'gameButton1': 204,
  'gameButton2': 205,
  'gameButton3': 206,
  'gameButton4': 207,
  'gameButton5': 208,
  'gameButton6': 209,
  'gameButton7': 210,
  'gameButton8': 211,
  'gameButton9': 212,
  'gameButton10': 213,
  'gameButton11': 214,
  'gameButton12': 215,
  'gameButton13': 216,
  'gameButton14': 217,
  'gameButton15': 218,
  'gameButton16': 219,
  'gameButtonA': 220,
  'gameButtonB': 221,
  'gameButtonC': 222,
  'gameButtonLeft1': 223,
  'gameButtonLeft2': 224,
  'gameButtonMode': 225,
  'gameButtonRight1': 226,
  'gameButtonRight2': 227,
  'gameButtonSelect': 228,
  'gameButtonStart': 229,
  'gameButtonThumbLeft': 230,
  'gameButtonThumbRight': 231,
  'gameButtonX': 232,
  'gameButtonY': 233,
  'gameButtonZ': 234,
  'fn': 235,
  'shift': 236,
  'meta': 237,
  'alt': 238,
  'control': 239,
};
const _HotkeyToPieMenuIdkeyCodeValueEnumMap = {
  0: KeyCode.hyper,
  1: KeyCode.superKey,
  2: KeyCode.fnLock,
  3: KeyCode.suspend,
  4: KeyCode.resume,
  5: KeyCode.sleep,
  6: KeyCode.wakeUp,
  7: KeyCode.keyA,
  8: KeyCode.keyB,
  9: KeyCode.keyC,
  10: KeyCode.keyD,
  11: KeyCode.keyE,
  12: KeyCode.keyF,
  13: KeyCode.keyG,
  14: KeyCode.keyH,
  15: KeyCode.keyI,
  16: KeyCode.keyJ,
  17: KeyCode.keyK,
  18: KeyCode.keyL,
  19: KeyCode.keyM,
  20: KeyCode.keyN,
  21: KeyCode.keyO,
  22: KeyCode.keyP,
  23: KeyCode.keyQ,
  24: KeyCode.keyR,
  25: KeyCode.keyS,
  26: KeyCode.keyT,
  27: KeyCode.keyU,
  28: KeyCode.keyV,
  29: KeyCode.keyW,
  30: KeyCode.keyX,
  31: KeyCode.keyY,
  32: KeyCode.keyZ,
  33: KeyCode.digit1,
  34: KeyCode.digit2,
  35: KeyCode.digit3,
  36: KeyCode.digit4,
  37: KeyCode.digit5,
  38: KeyCode.digit6,
  39: KeyCode.digit7,
  40: KeyCode.digit8,
  41: KeyCode.digit9,
  42: KeyCode.digit0,
  43: KeyCode.enter,
  44: KeyCode.escape,
  45: KeyCode.backspace,
  46: KeyCode.tab,
  47: KeyCode.space,
  48: KeyCode.add,
  49: KeyCode.minus,
  50: KeyCode.numberSign,
  51: KeyCode.multiply,
  52: KeyCode.equal,
  53: KeyCode.bracketLeft,
  54: KeyCode.bracketRight,
  55: KeyCode.backslash,
  56: KeyCode.semicolon,
  57: KeyCode.quote,
  58: KeyCode.backquote,
  59: KeyCode.comma,
  60: KeyCode.period,
  61: KeyCode.slash,
  62: KeyCode.capsLock,
  63: KeyCode.f1,
  64: KeyCode.f2,
  65: KeyCode.f3,
  66: KeyCode.f4,
  67: KeyCode.f5,
  68: KeyCode.f6,
  69: KeyCode.f7,
  70: KeyCode.f8,
  71: KeyCode.f9,
  72: KeyCode.f10,
  73: KeyCode.f11,
  74: KeyCode.f12,
  75: KeyCode.printScreen,
  76: KeyCode.scrollLock,
  77: KeyCode.pause,
  78: KeyCode.insert,
  79: KeyCode.home,
  80: KeyCode.pageUp,
  81: KeyCode.delete,
  82: KeyCode.end,
  83: KeyCode.pageDown,
  84: KeyCode.arrowRight,
  85: KeyCode.arrowLeft,
  86: KeyCode.arrowDown,
  87: KeyCode.arrowUp,
  88: KeyCode.numLock,
  89: KeyCode.numpadDivide,
  90: KeyCode.numpadMultiply,
  91: KeyCode.numpadSubtract,
  92: KeyCode.numpadAdd,
  93: KeyCode.numpadEnter,
  94: KeyCode.numpad1,
  95: KeyCode.numpad2,
  96: KeyCode.numpad3,
  97: KeyCode.numpad4,
  98: KeyCode.numpad5,
  99: KeyCode.numpad6,
  100: KeyCode.numpad7,
  101: KeyCode.numpad8,
  102: KeyCode.numpad9,
  103: KeyCode.numpad0,
  104: KeyCode.numpadDecimal,
  105: KeyCode.intlBackslash,
  106: KeyCode.contextMenu,
  107: KeyCode.power,
  108: KeyCode.numpadEqual,
  109: KeyCode.f13,
  110: KeyCode.f14,
  111: KeyCode.f15,
  112: KeyCode.f16,
  113: KeyCode.f17,
  114: KeyCode.f18,
  115: KeyCode.f19,
  116: KeyCode.f20,
  117: KeyCode.f21,
  118: KeyCode.f22,
  119: KeyCode.f23,
  120: KeyCode.f24,
  121: KeyCode.open,
  122: KeyCode.help,
  123: KeyCode.select,
  124: KeyCode.again,
  125: KeyCode.undo,
  126: KeyCode.cut,
  127: KeyCode.copy,
  128: KeyCode.paste,
  129: KeyCode.find,
  130: KeyCode.audioVolumeMute,
  131: KeyCode.audioVolumeUp,
  132: KeyCode.audioVolumeDown,
  133: KeyCode.numpadComma,
  134: KeyCode.intlRo,
  135: KeyCode.kanaMode,
  136: KeyCode.intlYen,
  137: KeyCode.convert,
  138: KeyCode.nonConvert,
  139: KeyCode.lang1,
  140: KeyCode.lang2,
  141: KeyCode.lang3,
  142: KeyCode.lang4,
  143: KeyCode.lang5,
  144: KeyCode.abort,
  145: KeyCode.props,
  146: KeyCode.numpadParenLeft,
  147: KeyCode.numpadParenRight,
  148: KeyCode.controlLeft,
  149: KeyCode.shiftLeft,
  150: KeyCode.altLeft,
  151: KeyCode.metaLeft,
  152: KeyCode.controlRight,
  153: KeyCode.shiftRight,
  154: KeyCode.altRight,
  155: KeyCode.metaRight,
  156: KeyCode.info,
  157: KeyCode.closedCaptionToggle,
  158: KeyCode.brightnessUp,
  159: KeyCode.brightnessDown,
  160: KeyCode.mediaLast,
  161: KeyCode.launchPhone,
  162: KeyCode.exit,
  163: KeyCode.channelUp,
  164: KeyCode.channelDown,
  165: KeyCode.mediaPlay,
  166: KeyCode.mediaPause,
  167: KeyCode.mediaRecord,
  168: KeyCode.mediaFastForward,
  169: KeyCode.mediaRewind,
  170: KeyCode.mediaTrackNext,
  171: KeyCode.mediaTrackPrevious,
  172: KeyCode.mediaStop,
  173: KeyCode.eject,
  174: KeyCode.mediaPlayPause,
  175: KeyCode.speechInputToggle,
  176: KeyCode.launchWordProcessor,
  177: KeyCode.launchSpreadsheet,
  178: KeyCode.launchMail,
  179: KeyCode.launchContacts,
  180: KeyCode.launchCalendar,
  181: KeyCode.logOff,
  182: KeyCode.launchControlPanel,
  183: KeyCode.spellCheck,
  184: KeyCode.launchScreenSaver,
  185: KeyCode.launchAssistant,
  186: KeyCode.newKey,
  187: KeyCode.close,
  188: KeyCode.save,
  189: KeyCode.print,
  190: KeyCode.browserSearch,
  191: KeyCode.browserHome,
  192: KeyCode.browserBack,
  193: KeyCode.browserForward,
  194: KeyCode.browserStop,
  195: KeyCode.browserRefresh,
  196: KeyCode.browserFavorites,
  197: KeyCode.zoomIn,
  198: KeyCode.zoomOut,
  199: KeyCode.zoomToggle,
  200: KeyCode.redo,
  201: KeyCode.mailReply,
  202: KeyCode.mailForward,
  203: KeyCode.mailSend,
  204: KeyCode.gameButton1,
  205: KeyCode.gameButton2,
  206: KeyCode.gameButton3,
  207: KeyCode.gameButton4,
  208: KeyCode.gameButton5,
  209: KeyCode.gameButton6,
  210: KeyCode.gameButton7,
  211: KeyCode.gameButton8,
  212: KeyCode.gameButton9,
  213: KeyCode.gameButton10,
  214: KeyCode.gameButton11,
  215: KeyCode.gameButton12,
  216: KeyCode.gameButton13,
  217: KeyCode.gameButton14,
  218: KeyCode.gameButton15,
  219: KeyCode.gameButton16,
  220: KeyCode.gameButtonA,
  221: KeyCode.gameButtonB,
  222: KeyCode.gameButtonC,
  223: KeyCode.gameButtonLeft1,
  224: KeyCode.gameButtonLeft2,
  225: KeyCode.gameButtonMode,
  226: KeyCode.gameButtonRight1,
  227: KeyCode.gameButtonRight2,
  228: KeyCode.gameButtonSelect,
  229: KeyCode.gameButtonStart,
  230: KeyCode.gameButtonThumbLeft,
  231: KeyCode.gameButtonThumbRight,
  232: KeyCode.gameButtonX,
  233: KeyCode.gameButtonY,
  234: KeyCode.gameButtonZ,
  235: KeyCode.fn,
  236: KeyCode.shift,
  237: KeyCode.meta,
  238: KeyCode.alt,
  239: KeyCode.control,
};
const _HotkeyToPieMenuIdkeyModifiersEnumValueMap = {
  'capsLock': 0,
  'shift': 1,
  'control': 2,
  'alt': 3,
  'meta': 4,
  'fn': 5,
};
const _HotkeyToPieMenuIdkeyModifiersValueEnumMap = {
  0: KeyModifier.capsLock,
  1: KeyModifier.shift,
  2: KeyModifier.control,
  3: KeyModifier.alt,
  4: KeyModifier.meta,
  5: KeyModifier.fn,
};

extension HotkeyToPieMenuIdQueryFilter
    on QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QFilterCondition> {
  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyCodeEqualTo(KeyCode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyCode',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyCodeGreaterThan(
    KeyCode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyCode',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyCodeLessThan(
    KeyCode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyCode',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyCodeBetween(
    KeyCode lower,
    KeyCode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersElementEqualTo(KeyModifier value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyModifiers',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersElementGreaterThan(
    KeyModifier value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyModifiers',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersElementLessThan(
    KeyModifier value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyModifiers',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersElementBetween(
    KeyModifier lower,
    KeyModifier upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyModifiers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyModifiers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyModifiers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyModifiers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyModifiers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyModifiers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      keyModifiersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyModifiers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
      pieMenuIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieMenuId',
        value: value,
      ));
    });
  }

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
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

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
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

  QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QAfterFilterCondition>
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
}

extension HotkeyToPieMenuIdQueryObject
    on QueryBuilder<HotkeyToPieMenuId, HotkeyToPieMenuId, QFilterCondition> {}
