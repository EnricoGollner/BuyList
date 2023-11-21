import 'package:shopping_list/src/utils/db_utils.dart';

class ShopItem {
  int? id;
  bool isBought;
  String itemName;

  ShopItem({this.id, required this.isBought, required this.itemName});

  factory ShopItem.fromMap(Map<String, dynamic> map) {
    return ShopItem(
      id: map[DBUtils.idColumn],
      isBought: map[DBUtils.isBought] != 0,
      itemName: map[DBUtils.itemNameColumn],
    );
  }

  factory ShopItem.fromItemStr(String itemName) {
    return ShopItem(
      isBought: false,
      itemName: itemName,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      DBUtils.isBought: isBought ? 1 : 0,
      DBUtils.itemNameColumn: itemName,
    };

    if (id != null) map[DBUtils.idColumn] = id;

    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id, isAdded: $isBought, itemName: $itemName)";
  }
}
