import 'package:pie_menyu/db/pie_item_task.dart';

class OpenUrlTask extends PieItemTask {
  OpenUrlTask();

  set url(String value) {
    arguments = [value];
  }

  String get url => arguments[0];
}