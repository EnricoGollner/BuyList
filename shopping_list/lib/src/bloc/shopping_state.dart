// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shopping_list/src/data/models/shop_item.dart';

class ShoppingState {
  final String responseMensage;
  final List<ItemToShop> itemsList;

  ShoppingState({this.responseMensage = '', required this.itemsList});
}

class ShoppingInitialState extends ShoppingState {
  ShoppingInitialState() : super(itemsList: []);
}

class ShoppingLoadingState extends ShoppingState {
  ShoppingLoadingState() : super(itemsList: []);
}

class ShoppingSuccessState extends ShoppingState {
  ShoppingSuccessState({required List<ItemToShop> itemsList})
      : super(itemsList: itemsList);
}

class ShoppingFailureState extends ShoppingState {
  ShoppingFailureState({required String mensage})
      : super(responseMensage: '', itemsList: []);
}
