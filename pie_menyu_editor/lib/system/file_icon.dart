import 'dart:io';
import 'package:path/path.dart' as p;

class FileIcon {
  static Future<String> getBase64(String path) async {
    ProcessResult result = await Process.run(
        p.join(Directory(Platform.resolvedExecutable).parent.path, "data",
            "flutter_assets", "support", "get_icon_base64.exe"),
        [path]);

    return result.stdout.trim();
  }
}
