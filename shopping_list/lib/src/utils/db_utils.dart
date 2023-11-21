class DBUtils {
  static const String itemsToShopTable = "itemsTable";

  static const String idColumn = "idColumn";
  static const String itemNameColumn = "itemNameColumn";
  static const String isBought = "addedColumn";

  static const String createTableQuery =
      "CREATE TABLE ${DBUtils.itemsToShopTable}("
      "${DBUtils.idColumn} INTEGER PRIMARY KEY,"
      "${DBUtils.isBought} INTEGER,"
      "${DBUtils.itemNameColumn} VARCHAR(100)"
      ")";
}
