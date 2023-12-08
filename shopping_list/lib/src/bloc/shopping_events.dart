import 'package:shopping_list/src/data/models/shop_item.dart';

abstract class ShoppingEvent {}

class LoadShoppingEvent extends ShoppingEvent {}

class AddShoppingEvent extends ShoppingEvent {
  final ItemToShop item;

  AddShoppingEvent({required this.item});
}

class AddListShoppingEvent extends ShoppingEvent {
  final List<ItemToShop> itemsList;

  AddListShoppingEvent({required this.itemsList});
}

class UpdateItemToShopEvent extends ShoppingEvent {
  final ItemToShop item;

  UpdateItemToShopEvent({required this.item});
}

class RemoveShoppingEvent extends ShoppingEvent {
  final ItemToShop item;

  RemoveShoppingEvent({required this.item});
}
