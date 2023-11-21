import 'package:shopping_list/src/data/models/shop_item.dart';

class ShoppingEvent {}

class LoadShoppingEvent extends ShoppingEvent {}

class AddShoppingEvent extends ShoppingEvent {
  ShopItem item;

  AddShoppingEvent({required this.item});
}

class RemoveShoppingEvent extends ShoppingEvent {
  ShopItem item;

  RemoveShoppingEvent({required this.item});
}
