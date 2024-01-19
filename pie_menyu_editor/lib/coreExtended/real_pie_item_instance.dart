import 'package:pie_menyu_core/db/pie_item.dart';
import 'package:pie_menyu_core/db/pie_menu.dart';

class RealPieItemInstance extends PieItemInstance {
  PieItem pieItem;
  RealPieItemInstance(PieItemInstance pieItemInstance, this.pieItem)
      : super(pieItemId: pieItemInstance.pieItemId, keyCode: pieItemInstance.keyCode);

}