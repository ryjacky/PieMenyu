// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_hotkey_to_pie_menu_id.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfileHotkeyToPieMenuIdCollection on Isar {
  IsarCollection<ProfileHotkeyToPieMenuId> get profileHotkeyToPieMenuIds =>
      this.collection();
}

const ProfileHotkeyToPieMenuIdSchema = CollectionSchema(
  name: r'ProfileHotkeyToPieMenuId',
  id: 5951566584954372904,
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
    r'key': PropertySchema(
      id: 2,
      name: r'key',
      type: IsarType.string,
    ),
    r'pieMenuId': PropertySchema(
      id: 3,
      name: r'pieMenuId',
      type: IsarType.long,
    ),
    r'profileId': PropertySchema(
      id: 4,
      name: r'profileId',
      type: IsarType.long,
    ),
    r'shift': PropertySchema(
      id: 5,
      name: r'shift',
      type: IsarType.bool,
    )
  },
  estimateSize: _profileHotkeyToPieMenuIdEstimateSize,
  serialize: _profileHotkeyToPieMenuIdSerialize,
  deserialize: _profileHotkeyToPieMenuIdDeserialize,
  deserializeProp: _profileHotkeyToPieMenuIdDeserializeProp,
  idName: r'id',
  indexes: {
    r'profileId': IndexSchema(
      id: 6052971939042612300,
      name: r'profileId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'profileId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'pieMenuId': IndexSchema(
      id: -2506973062885602530,
      name: r'pieMenuId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'pieMenuId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _profileHotkeyToPieMenuIdGetId,
  getLinks: _profileHotkeyToPieMenuIdGetLinks,
  attach: _profileHotkeyToPieMenuIdAttach,
  version: '3.1.0+1',
);

int _profileHotkeyToPieMenuIdEstimateSize(
  ProfileHotkeyToPieMenuId object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.key.length * 3;
  return bytesCount;
}

void _profileHotkeyToPieMenuIdSerialize(
  ProfileHotkeyToPieMenuId object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.alt);
  writer.writeBool(offsets[1], object.ctrl);
  writer.writeString(offsets[2], object.key);
  writer.writeLong(offsets[3], object.pieMenuId);
  writer.writeLong(offsets[4], object.profileId);
  writer.writeBool(offsets[5], object.shift);
}

ProfileHotkeyToPieMenuId _profileHotkeyToPieMenuIdDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfileHotkeyToPieMenuId(
    alt: reader.readBoolOrNull(offsets[0]) ?? false,
    ctrl: reader.readBoolOrNull(offsets[1]) ?? false,
    key: reader.readStringOrNull(offsets[2]) ?? "",
    pieMenuId: reader.readLongOrNull(offsets[3]) ?? 0,
    profileId: reader.readLongOrNull(offsets[4]) ?? 0,
    shift: reader.readBoolOrNull(offsets[5]) ?? false,
  );
  object.id = id;
  return object;
}

P _profileHotkeyToPieMenuIdDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profileHotkeyToPieMenuIdGetId(ProfileHotkeyToPieMenuId object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profileHotkeyToPieMenuIdGetLinks(
    ProfileHotkeyToPieMenuId object) {
  return [];
}

void _profileHotkeyToPieMenuIdAttach(
    IsarCollection<dynamic> col, Id id, ProfileHotkeyToPieMenuId object) {
  object.id = id;
}

extension ProfileHotkeyToPieMenuIdQueryWhereSort on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QWhere> {
  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterWhere>
      anyProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'profileId'),
      );
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterWhere>
      anyPieMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'pieMenuId'),
      );
    });
  }
}

extension ProfileHotkeyToPieMenuIdQueryWhere on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QWhereClause> {
  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> profileIdEqualTo(int profileId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'profileId',
        value: [profileId],
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> profileIdNotEqualTo(int profileId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [],
              upper: [profileId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [profileId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [profileId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [],
              upper: [profileId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> profileIdGreaterThan(
    int profileId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'profileId',
        lower: [profileId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> profileIdLessThan(
    int profileId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'profileId',
        lower: [],
        upper: [profileId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> profileIdBetween(
    int lowerProfileId,
    int upperProfileId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'profileId',
        lower: [lowerProfileId],
        includeLower: includeLower,
        upper: [upperProfileId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> pieMenuIdEqualTo(int pieMenuId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pieMenuId',
        value: [pieMenuId],
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> pieMenuIdNotEqualTo(int pieMenuId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieMenuId',
              lower: [],
              upper: [pieMenuId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieMenuId',
              lower: [pieMenuId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieMenuId',
              lower: [pieMenuId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pieMenuId',
              lower: [],
              upper: [pieMenuId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> pieMenuIdGreaterThan(
    int pieMenuId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pieMenuId',
        lower: [pieMenuId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> pieMenuIdLessThan(
    int pieMenuId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pieMenuId',
        lower: [],
        upper: [pieMenuId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterWhereClause> pieMenuIdBetween(
    int lowerPieMenuId,
    int upperPieMenuId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pieMenuId',
        lower: [lowerPieMenuId],
        includeLower: includeLower,
        upper: [upperPieMenuId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProfileHotkeyToPieMenuIdQueryFilter on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QFilterCondition> {
  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> altEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> ctrlEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ctrl',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
          QAfterFilterCondition>
      keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
          QAfterFilterCondition>
      keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> pieMenuIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieMenuId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> pieMenuIdGreaterThan(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> pieMenuIdLessThan(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> pieMenuIdBetween(
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

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> profileIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> profileIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> profileIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> profileIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId,
      QAfterFilterCondition> shiftEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shift',
        value: value,
      ));
    });
  }
}

extension ProfileHotkeyToPieMenuIdQueryObject on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QFilterCondition> {}

extension ProfileHotkeyToPieMenuIdQueryLinks on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QFilterCondition> {}

extension ProfileHotkeyToPieMenuIdQuerySortBy on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QSortBy> {
  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByAlt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByAltDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByCtrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ctrl', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByCtrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ctrl', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByPieMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieMenuId', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByPieMenuIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieMenuId', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      sortByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }
}

extension ProfileHotkeyToPieMenuIdQuerySortThenBy on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QSortThenBy> {
  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByAlt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByAltDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByCtrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ctrl', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByCtrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ctrl', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByPieMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieMenuId', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByPieMenuIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieMenuId', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QAfterSortBy>
      thenByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }
}

extension ProfileHotkeyToPieMenuIdQueryWhereDistinct on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct> {
  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct>
      distinctByAlt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alt');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct>
      distinctByCtrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ctrl');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct>
      distinctByKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct>
      distinctByPieMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pieMenuId');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct>
      distinctByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileId');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QDistinct>
      distinctByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shift');
    });
  }
}

extension ProfileHotkeyToPieMenuIdQueryProperty on QueryBuilder<
    ProfileHotkeyToPieMenuId, ProfileHotkeyToPieMenuId, QQueryProperty> {
  QueryBuilder<ProfileHotkeyToPieMenuId, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, bool, QQueryOperations> altProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alt');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, bool, QQueryOperations>
      ctrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ctrl');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, String, QQueryOperations>
      keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, int, QQueryOperations>
      pieMenuIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieMenuId');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, int, QQueryOperations>
      profileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileId');
    });
  }

  QueryBuilder<ProfileHotkeyToPieMenuId, bool, QQueryOperations>
      shiftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shift');
    });
  }
}
