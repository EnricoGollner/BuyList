import 'package:shopping_list/app/data/models/shop_item.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/db_utils.dart';

class ItemShopHelper {
  static final _instance = ItemShopHelper.internal();

  factory ItemShopHelper() => _instance;

  ItemShopHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDB();
    return _db;
  }

  Future<Database?> initDB() async {
    final databasesPath = await getDatabasesPath();

    final String path = "$databasesPath/itemsToShop.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute(DBUtils.createTableQuery);
      },
    );
  }

  Future<ShopItem> saveShopItem(ShopItem item) async {
    Database? dbItemsShop = await db;

    item.id = await dbItemsShop?.insert(DBUtils.itemsToShopTable, item.toMap());
    return item;
  }

  Future<List<ShopItem>?> getAllItemsToShop() async {
    Database? dbItemsToShop = await db;

    List<Map<String, dynamic>>? listMap = await dbItemsToShop
        ?.rawQuery("SELECT * FROM ${DBUtils.itemsToShopTable}");

    if (listMap != null) {
      List<ShopItem> listItemsToShop = listMap
          .map(
            (e) => ShopItem.fromMap(e),
          )
          .toList();
      return listItemsToShop;
    }

    return null;
  }

  Future<ShopItem?> getOneItem(int itemToShopId) async {
    Database? dbItemsToShop = await db;

    List<Map<String, dynamic>>? maps = await dbItemsToShop?.query(
      DBUtils.itemsToShopTable,
      columns: [
        DBUtils.idColumn,
        DBUtils.isAddedColumn,
        DBUtils.itemNameColumn,
      ],
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [itemToShopId],
    );

    if (maps != null && maps.isNotEmpty) {
      return ShopItem.fromMap(maps.first);
    }

    return null;
  }

  Future<int?> deleteById(int itemToShopId) async {
    Database? dbItemsToShop = await db;

    return await dbItemsToShop?.delete(
      DBUtils.itemsToShopTable,
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [itemToShopId],
    );
  }

  Future<int?> updateItem(ShopItem itemToShop) async {
    Database? dbItemsToShop = await db;

    return await dbItemsToShop?.update(
      DBUtils.itemsToShopTable,
      itemToShop.toMap(),
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [itemToShop.id],
    );
  }

  Future<int?> getNumberOfItemsSaved() async {
    Database? dbItemsToshop = await db;

    if (dbItemsToshop != null) {
      return Sqflite.firstIntValue(
        await dbItemsToshop.rawQuery(
          "SELECT COUNT(*) FROM ${DBUtils.itemsToShopTable}",
        ),
      );
    }

    return null;
  }

  Future<void> close() async {
    Database? dbItemsToshop = await db;
    dbItemsToshop?.close();
  }
}
