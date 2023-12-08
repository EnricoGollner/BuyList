import 'package:flutter/material.dart';
import 'package:shopping_list/src/bloc/shopping_state.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/pages/widgets/box_shopping_list.dart';

class ItemsPage extends StatefulWidget {
  final AsyncSnapshot<ShoppingState> snapshot;

  const ItemsPage({super.key, required this.snapshot});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {

  @override
  Widget build(BuildContext context) {
    List<ItemToShop> shopItemsList = widget.snapshot.data!.itemsList;

    switch (widget.snapshot.data.runtimeType) {
      case ShoppingLoadingState:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      case ShoppingSuccessState:
        return BoxShoppingList(shopItemsList: shopItemsList);
      default:
        return const BoxShoppingList(shopItemsList: []);
    }
  }
}
