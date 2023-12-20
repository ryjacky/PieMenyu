import 'package:pie_menyu/db/pie_item_task.dart';

class SendTextTask extends PieItemTask {
  SendTextTask();

  set text(String value) {
    arguments = [value];
  }

  String get text => arguments[0];
}