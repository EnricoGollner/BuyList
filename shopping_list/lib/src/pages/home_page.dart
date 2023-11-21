import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/src/bloc/shopping_bloc.dart';
import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/bloc/shopping_state.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/pages/widgets/shopping_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ShoppingBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = Provider.of<ShoppingBloc>(context);
    bloc.inputClient.add(LoadShoppingEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.inputClient.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snaphot) {
            List<ShopItem> shopItemsList = [];

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
                return ShoppingList(shopItemsList: shopItemsList);
              default:
                return const ShoppingList(shopItemsList: []);
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Lista"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Inserir por mensagem",
          ),
        ],
      ),
    );
  }
}
