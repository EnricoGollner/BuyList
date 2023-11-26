import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/src/bloc/shopping_bloc.dart';
import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/bloc/shopping_state.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/pages/widgets/box_shopping_list.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late ShoppingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ShoppingBloc>();
    bloc.inputClient.add(LoadShoppingEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.inputClient.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snaphot) {
          List<ItemToShop> shopItemsList = [];

          if (snaphot.hasData) {
            shopItemsList = snaphot.data!.itemsList;
          }

          switch (snaphot.data.runtimeType) {
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
        });
  }
}
