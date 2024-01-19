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
    r'activationMode': PropertySchema(
      id: 0,
      name: r'activationMode',
      type: IsarType.byte,
      enumMap: _PieMenuactivationModeEnumValueMap,
    ),
    r'centerRadius': PropertySchema(
      id: 1,
      name: r'centerRadius',
      type: IsarType.long,
    ),
    r'centerThickness': PropertySchema(
      id: 2,
      name: r'centerThickness',
      type: IsarType.long,
    ),
    r'enabled': PropertySchema(
      id: 3,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'escapeRadius': PropertySchema(
      id: 4,
      name: r'escapeRadius',
      type: IsarType.long,
    ),
    r'fontColor': PropertySchema(
      id: 5,
      name: r'fontColor',
      type: IsarType.long,
    ),
    r'fontName': PropertySchema(
      id: 6,
      name: r'fontName',
      type: IsarType.string,
    ),
    r'fontSize': PropertySchema(
      id: 7,
      name: r'fontSize',
      type: IsarType.long,
    ),
    r'iconColor': PropertySchema(
      id: 8,
      name: r'iconColor',
      type: IsarType.long,
    ),
    r'iconSize': PropertySchema(
      id: 9,
      name: r'iconSize',
      type: IsarType.long,
    ),
    r'mainColor': PropertySchema(
      id: 10,
      name: r'mainColor',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'openInScreenCenter': PropertySchema(
      id: 12,
      name: r'openInScreenCenter',
      type: IsarType.bool,
    ),
    r'pieItemInstances': PropertySchema(
      id: 13,
      name: r'pieItemInstances',
      type: IsarType.objectList,
      target: r'PieItemInstance',
    ),
    r'pieItemRoundness': PropertySchema(
      id: 14,
      name: r'pieItemRoundness',
      type: IsarType.long,
    ),
    r'pieItemSpread': PropertySchema(
      id: 15,
      name: r'pieItemSpread',
      type: IsarType.long,
    ),
    r'pieItemWidth': PropertySchema(
      id: 16,
      name: r'pieItemWidth',
      type: IsarType.long,
    ),
    r'secondaryColor': PropertySchema(
      id: 17,
      name: r'secondaryColor',
      type: IsarType.long,
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
  embeddedSchemas: {r'PieItemInstance': PieItemInstanceSchema},
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
  bytesCount += 3 + object.fontName.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pieItemInstances.length * 3;
  {
    final offsets = allOffsets[PieItemInstance]!;
    for (var i = 0; i < object.pieItemInstances.length; i++) {
      final value = object.pieItemInstances[i];
      bytesCount +=
          PieItemInstanceSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _pieMenuSerialize(
  PieMenu object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.activationMode.index);
  writer.writeLong(offsets[1], object.centerRadius);
  writer.writeLong(offsets[2], object.centerThickness);
  writer.writeBool(offsets[3], object.enabled);
  writer.writeLong(offsets[4], object.escapeRadius);
  writer.writeLong(offsets[5], object.fontColor);
  writer.writeString(offsets[6], object.fontName);
  writer.writeLong(offsets[7], object.fontSize);
  writer.writeLong(offsets[8], object.iconColor);
  writer.writeLong(offsets[9], object.iconSize);
  writer.writeLong(offsets[10], object.mainColor);
  writer.writeString(offsets[11], object.name);
  writer.writeBool(offsets[12], object.openInScreenCenter);
  writer.writeObjectList<PieItemInstance>(
    offsets[13],
    allOffsets,
    PieItemInstanceSchema.serialize,
    object.pieItemInstances,
  );
  writer.writeLong(offsets[14], object.pieItemRoundness);
  writer.writeLong(offsets[15], object.pieItemSpread);
  writer.writeLong(offsets[16], object.pieItemWidth);
  writer.writeLong(offsets[17], object.secondaryColor);
}

PieMenu _pieMenuDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieMenu(
    activationMode:
        _PieMenuactivationModeValueEnumMap[reader.readByteOrNull(offsets[0])] ??
            PieMenuActivationMode.activateOnKeyDown,
    centerRadius: reader.readLongOrNull(offsets[1]) ?? 20,
    centerThickness: reader.readLongOrNull(offsets[2]) ?? 10,
    enabled: reader.readBoolOrNull(offsets[3]) ?? true,
    escapeRadius: reader.readLongOrNull(offsets[4]) ?? 0,
    fontColor: reader.readLongOrNull(offsets[5]) ?? 0xFFFFFFFF,
    fontName: reader.readStringOrNull(offsets[6]) ?? 'Roboto',
    fontSize: reader.readLongOrNull(offsets[7]) ?? 14,
    iconColor: reader.readLongOrNull(offsets[8]) ?? 0xFFFFFFFF,
    iconSize: reader.readLongOrNull(offsets[9]) ?? 32,
    mainColor: reader.readLongOrNull(offsets[10]) ?? 0xFF1DAEAA,
    name: reader.readStringOrNull(offsets[11]) ?? 'New Pie Menu',
    openInScreenCenter: reader.readBoolOrNull(offsets[12]) ?? false,
    pieItemRoundness: reader.readLongOrNull(offsets[14]) ?? 7,
    pieItemSpread: reader.readLongOrNull(offsets[15]) ?? 150,
    secondaryColor: reader.readLongOrNull(offsets[17]) ?? 0xFF282828,
  );
  object.id = id;
  object.pieItemInstances = reader.readObjectList<PieItemInstance>(
        offsets[13],
        PieItemInstanceSchema.deserialize,
        allOffsets,
        PieItemInstance(),
      ) ??
      [];
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
      return (_PieMenuactivationModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PieMenuActivationMode.activateOnKeyDown) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 20) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 10) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0xFFFFFFFF) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? 'Roboto') as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 14) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0xFFFFFFFF) as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 32) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 0xFF1DAEAA) as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? 'New Pie Menu') as P;
    case 12:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 13:
      return (reader.readObjectList<PieItemInstance>(
            offset,
            PieItemInstanceSchema.deserialize,
            allOffsets,
            PieItemInstance(),
          ) ??
          []) as P;
    case 14:
      return (reader.readLongOrNull(offset) ?? 7) as P;
    case 15:
      return (reader.readLongOrNull(offset) ?? 150) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset) ?? 0xFF282828) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PieMenuactivationModeEnumValueMap = {
  'activateOnKeyDown': 0,
};
const _PieMenuactivationModeValueEnumMap = {
  0: PieMenuActivationMode.activateOnKeyDown,
};

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
  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> activationModeEqualTo(
      PieMenuActivationMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activationMode',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      activationModeGreaterThan(
    PieMenuActivationMode value, {
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> activationModeLessThan(
    PieMenuActivationMode value, {
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> activationModeBetween(
    PieMenuActivationMode lower,
    PieMenuActivationMode upper, {
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerRadiusEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerRadius',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerRadiusGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'centerRadius',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerRadiusLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'centerRadius',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerRadiusBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'centerRadius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerThicknessEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerThickness',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      centerThicknessGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'centerThickness',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerThicknessLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'centerThickness',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> centerThicknessBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'centerThickness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> enabledEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> escapeRadiusEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'escapeRadius',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> escapeRadiusGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'escapeRadius',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> escapeRadiusLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'escapeRadius',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> escapeRadiusBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'escapeRadius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontColorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fontName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fontName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fontName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fontName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontName',
        value: '',
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fontName',
        value: '',
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontSizeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontSize',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontSizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontSize',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontSizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontSize',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> fontSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconColorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconSizeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconSize',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconSizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconSize',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconSizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconSize',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> iconSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> mainColorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> mainColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> mainColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> mainColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainColor',
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
      openInScreenCenterEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openInScreenCenter',
        value: value,
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

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemRoundnessEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemRoundness',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemRoundnessGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieItemRoundness',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemRoundnessLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieItemRoundness',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemRoundnessBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieItemRoundness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemSpreadEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemSpread',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      pieItemSpreadGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieItemSpread',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemSpreadLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieItemSpread',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemSpreadBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieItemSpread',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemWidthEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemWidthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pieItemWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemWidthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pieItemWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemWidthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pieItemWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> secondaryColorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition>
      secondaryColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondaryColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> secondaryColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondaryColor',
        value: value,
      ));
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> secondaryColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondaryColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PieMenuQueryObject
    on QueryBuilder<PieMenu, PieMenu, QFilterCondition> {
  QueryBuilder<PieMenu, PieMenu, QAfterFilterCondition> pieItemInstancesElement(
      FilterQuery<PieItemInstance> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pieItemInstances');
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
  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByActivationMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activationMode', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByActivationModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activationMode', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByCenterRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerRadius', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByCenterRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerRadius', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByCenterThickness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerThickness', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByCenterThicknessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerThickness', Sort.desc);
    });
  }

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

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByEscapeRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escapeRadius', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByEscapeRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escapeRadius', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByFontName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontName', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByFontNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontName', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByIconColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByIconColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColor', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByIconSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByIconSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByMainColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByMainColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColor', Sort.desc);
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

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByOpenInScreenCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openInScreenCenter', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByOpenInScreenCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openInScreenCenter', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByPieItemRoundness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemRoundness', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByPieItemRoundnessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemRoundness', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByPieItemSpread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemSpread', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByPieItemSpreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemSpread', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByPieItemWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemWidth', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortByPieItemWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemWidth', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortBySecondaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> sortBySecondaryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.desc);
    });
  }
}

extension PieMenuQuerySortThenBy
    on QueryBuilder<PieMenu, PieMenu, QSortThenBy> {
  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByActivationMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activationMode', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByActivationModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activationMode', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByCenterRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerRadius', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByCenterRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerRadius', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByCenterThickness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerThickness', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByCenterThicknessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerThickness', Sort.desc);
    });
  }

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

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByEscapeRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escapeRadius', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByEscapeRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escapeRadius', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByFontName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontName', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByFontNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontName', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByIconColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByIconColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColor', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByIconSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByIconSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.desc);
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

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByMainColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByMainColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColor', Sort.desc);
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

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByOpenInScreenCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openInScreenCenter', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByOpenInScreenCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openInScreenCenter', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByPieItemRoundness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemRoundness', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByPieItemRoundnessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemRoundness', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByPieItemSpread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemSpread', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByPieItemSpreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemSpread', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByPieItemWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemWidth', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenByPieItemWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pieItemWidth', Sort.desc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenBySecondaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.asc);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QAfterSortBy> thenBySecondaryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.desc);
    });
  }
}

extension PieMenuQueryWhereDistinct
    on QueryBuilder<PieMenu, PieMenu, QDistinct> {
  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByActivationMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activationMode');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByCenterRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'centerRadius');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByCenterThickness() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'centerThickness');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByEscapeRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'escapeRadius');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontColor');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByFontName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontSize');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByIconColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconColor');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByIconSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconSize');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByMainColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainColor');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByOpenInScreenCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openInScreenCenter');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByPieItemRoundness() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pieItemRoundness');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByPieItemSpread() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pieItemSpread');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctByPieItemWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pieItemWidth');
    });
  }

  QueryBuilder<PieMenu, PieMenu, QDistinct> distinctBySecondaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryColor');
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

  QueryBuilder<PieMenu, PieMenuActivationMode, QQueryOperations>
      activationModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activationMode');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> centerRadiusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'centerRadius');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> centerThicknessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'centerThickness');
    });
  }

  QueryBuilder<PieMenu, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> escapeRadiusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'escapeRadius');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> fontColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontColor');
    });
  }

  QueryBuilder<PieMenu, String, QQueryOperations> fontNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontName');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> fontSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontSize');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> iconColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconColor');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> iconSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconSize');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> mainColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainColor');
    });
  }

  QueryBuilder<PieMenu, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PieMenu, bool, QQueryOperations> openInScreenCenterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openInScreenCenter');
    });
  }

  QueryBuilder<PieMenu, List<PieItemInstance>, QQueryOperations>
      pieItemInstancesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieItemInstances');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> pieItemRoundnessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieItemRoundness');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> pieItemSpreadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieItemSpread');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> pieItemWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pieItemWidth');
    });
  }

  QueryBuilder<PieMenu, int, QQueryOperations> secondaryColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryColor');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PieItemInstanceSchema = Schema(
  name: r'PieItemInstance',
  id: -3357939713037499918,
  properties: {
    r'keyCode': PropertySchema(
      id: 0,
      name: r'keyCode',
      type: IsarType.string,
    ),
    r'pieItemId': PropertySchema(
      id: 1,
      name: r'pieItemId',
      type: IsarType.long,
    )
  },
  estimateSize: _pieItemInstanceEstimateSize,
  serialize: _pieItemInstanceSerialize,
  deserialize: _pieItemInstanceDeserialize,
  deserializeProp: _pieItemInstanceDeserializeProp,
);

int _pieItemInstanceEstimateSize(
  PieItemInstance object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.keyCode.length * 3;
  return bytesCount;
}

void _pieItemInstanceSerialize(
  PieItemInstance object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.keyCode);
  writer.writeLong(offsets[1], object.pieItemId);
}

PieItemInstance _pieItemInstanceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PieItemInstance(
    keyCode: reader.readStringOrNull(offsets[0]) ?? "",
    pieItemId: reader.readLongOrNull(offsets[1]) ?? 0,
  );
  return object;
}

P _pieItemInstanceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PieItemInstanceQueryFilter
    on QueryBuilder<PieItemInstance, PieItemInstance, QFilterCondition> {
  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
      keyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
      keyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
      keyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
      keyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
      pieItemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pieItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

  QueryBuilder<PieItemInstance, PieItemInstance, QAfterFilterCondition>
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

extension PieItemInstanceQueryObject
    on QueryBuilder<PieItemInstance, PieItemInstance, QFilterCondition> {}
