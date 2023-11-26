import 'dart:async';

import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/bloc/shopping_state.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/data/repositories/shopping_repository.dart';

class ShoppingBloc {
  final ShoppingRepository shoppingRepository;

  final StreamController<ShoppingEvent> _inputItemsController =
      StreamController<ShoppingEvent>();
  final StreamController<ShoppingState> _outputItemsController =
      StreamController<ShoppingState>();

  ///Getter of Stream controller of ShoppingEvents - where we send events
  Sink<ShoppingEvent> get inputClient => _inputItemsController.sink;

  ///Getter of items state stream controller - from where we can access state
  Stream<ShoppingState> get stream => _outputItemsController.stream;

  ShoppingBloc({required this.shoppingRepository}) {
    _inputItemsController.stream.listen((event) async {
      _mapEventToState(event);
    });
  }

  Future<void> _mapEventToState(ShoppingEvent event) async {
    List<ItemToShop> items = [];
    _outputItemsController.add(ShoppingLoadingState());

    if (event is LoadShoppingEvent) {
      items = await shoppingRepository.getAllItemsToShop();
    } else if (event is AddShoppingEvent) {
      try {
        await shoppingRepository.addItemToShop(event.item);
        items = await shoppingRepository.getAllItemsToShop();
      } catch (e) {
        _outputItemsController
            .add(ShoppingFailureState(mensage: 'Erro ao salvar o item.\n$e'));
      }
    } else if (event is UpdateItemToShopEvent) {
      try {
        await shoppingRepository.updateItem(event.item);
        items = await shoppingRepository.getAllItemsToShop();
      } catch (e) {
        _outputItemsController.add(ShoppingFailureState(mensage: 'Erro ao atualizar o item.\n$e'));
      }
    } else if (event is RemoveShoppingEvent) {
      try {
        await shoppingRepository.deleteById(event.item.id);
        items = await shoppingRepository.getAllItemsToShop();
      } catch (e) {
        _outputItemsController
            .add(ShoppingFailureState(mensage: 'Erro ao remover item\n$e'));
      }
    }

    _outputItemsController.add(ShoppingSuccessState(itemsList: items));
  }
}
