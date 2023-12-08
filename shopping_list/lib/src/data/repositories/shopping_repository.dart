import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/db_utils.dart';

class ShoppingRepository {
  static final _instance = ShoppingRepository.internal(); // Singleton

  factory ShoppingRepository() => _instance;

  ShoppingRepository.internal();

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

  Future<void> addItemToShop(ItemToShop item) async {
    Database? dbItemsShop = await db;

    await dbItemsShop?.insert(
      DBUtils.itemsToShopTable,
      item.copyWith(id: item.id).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addItemsListToShop(List<ItemToShop> itemsList) async {
    Database? dbItemsShop = await db;

    itemsList.map((item) async {
      await dbItemsShop?.insert(
        DBUtils.itemsToShopTable,
        item.copyWith(id: item.id).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<ItemToShop>> getAllItemsToShop() async {
    Database? dbItemsToShop = await db;

    List<Map<String, dynamic>>? listMap = await dbItemsToShop
        ?.rawQuery("SELECT * FROM ${DBUtils.itemsToShopTable}");

    if (listMap != null) {
      List<ItemToShop> listItemsToShop = listMap
          .map(
            (e) => ItemToShop.fromMap(e),
          )
          .toList();
      return listItemsToShop;
    }

    return [];
  }

  Future<ItemToShop?> getOneItem(String id) async {
    Database? dbItemsToShop = await db;

    List<Map<String, dynamic>>? maps = await dbItemsToShop?.query(
      DBUtils.itemsToShopTable,
      columns: [
        DBUtils.idColumn,
        DBUtils.isBought,
        DBUtils.itemNameColumn,
      ],
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [id],
    );

    if (maps != null && maps.isNotEmpty) {
      return ItemToShop.fromMap(maps.first);
    }

    return null;
  }

  Future<int?> deleteById(String itemToShopId) async {
    Database? dbItemsToShop = await db;

    return await dbItemsToShop?.delete(
      DBUtils.itemsToShopTable,
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [itemToShopId],
    );
  }

  Future<int?> updateItem(ItemToShop item) async {
    Database? dbItemsToShop = await db;

    return await dbItemsToShop?.update(
      DBUtils.itemsToShopTable,
      item.toJson(),
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [item.id],
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
