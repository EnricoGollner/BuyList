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

    final path = "$databasesPath/itemsToShop.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute(DBUtils.createTableQuery);
      },
    );
  }

  Future<ShopItem> saveShopItem(ShopItem item) async {
    Database? dbItemShop = await db;

    item.id = await dbItemShop?.insert(DBUtils.itemsToShopTable, item.toMap());

    return item;
  }
}
