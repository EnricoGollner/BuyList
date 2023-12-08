import 'package:shopping_list/src/utils/db_utils.dart';
import 'package:uuid/uuid.dart';

class ItemToShop {
  String id;
  bool isBought;
  String itemName;

  ItemToShop({required this.id, required this.isBought, required this.itemName});

  factory ItemToShop.fromMap(Map<String, dynamic> map) {
    return ItemToShop(
      id: map[DBUtils.idColumn],
      isBought: map[DBUtils.isBought] != 0,
      itemName: map[DBUtils.itemNameColumn],
    );
  }

  factory ItemToShop.create({required String itemName}) {
    return ItemToShop(
      id: const Uuid().v4(),
      isBought: false,
      itemName: itemName,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      DBUtils.idColumn: id,
      DBUtils.isBought: isBought ? 1 : 0,
      DBUtils.itemNameColumn: itemName,
    };

    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id, isAdded: $isBought, itemName: $itemName)";
  }

  ItemToShop copyWith({
    String? id,
    bool? isBought,
    String? itemName,
  }) {
    return ItemToShop(
      id: id ?? this.id,
      isBought: isBought ?? this.isBought,
      itemName: itemName ?? this.itemName,
    );
  }
}
