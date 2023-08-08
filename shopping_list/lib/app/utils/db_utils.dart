class DBUtils {
  static const String itemsToShopTable = "itemsTable";
  static const String idColumn = "idColumn";
  static const String isAddedColumn = "addedColumn";
  static const String itemNameColumn = "itemNameColumn";

  static const String createTableQuery =
      "CREATE TABLE ${DBUtils.itemsToShopTable}("
      "${DBUtils.idColumn} INTEGER PRIMARY KEY,"
      "${DBUtils.isAddedColumn} INTEGER,"
      "${DBUtils.itemNameColumn} VARCHAR(100)"
      ")";
}
