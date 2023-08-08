import 'package:shopping_list/app/utils/db_utils.dart';

class ShopItem {
  int? id;
  bool isAdded;
  String itemName;

  ShopItem({this.id, required this.isAdded, required this.itemName});

  factory ShopItem.fromMap(Map<String, dynamic> map) {
    return ShopItem(
      id: map[DBUtils.idColumn],
      isAdded: map[DBUtils.isAddedColumn],
      itemName: map[DBUtils.itemNameColumn],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      DBUtils.isAddedColumn: isAdded,
      DBUtils.itemNameColumn: itemName,
    };

    if (id != null) map[DBUtils.idColumn] = id;

    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id, isAdded: $isAdded, itemName: $itemName)";
  }
}
