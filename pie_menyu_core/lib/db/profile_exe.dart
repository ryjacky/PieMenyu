library pie_menyu_core;

import 'package:isar/isar.dart';
import 'package:pie_menyu_core/db/profile.dart';

part 'profile_exe.g.dart';

@collection
class ProfileExe {
  Id id = Isar.autoIncrement;

  @Index()
  String path = '';

  IsarLink<Profile> profile = IsarLink<Profile>();

  ProfileExe({
    this.path = '',
  });
}