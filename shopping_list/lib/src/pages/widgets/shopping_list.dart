import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/src/bloc/shopping_bloc.dart';
import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/utils/validator.dart';

class ShoppingList extends StatefulWidget {
  final List<ShopItem> shopItemsList;

  const ShoppingList({super.key, required this.shopItemsList});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemToShopCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _itemToShopCtrl,
                    decoration: const InputDecoration(
                        hintText: 'Informe o item para adicionar a lista'),
                    validator: Validator.isRequired,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final ShopItem itemToShop = ShopItem(
                          isBought: false, itemName: _itemToShopCtrl.text);
                      _addItem(itemToShop: itemToShop);
                    }
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) =>
                  Container(color: Colors.black12, height: 2),
              itemCount: widget.shopItemsList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Excluindo item"),
                                content: const Text(
                                    "Deseja mesmo excluir este item da lista de compras?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<ShoppingBloc>(context)
                                          .inputClient
                                          .add(
                                            RemoveShoppingEvent(
                                                item: widget
                                                    .shopItemsList[index]),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Excluir"),
                                  )
                                ],
                              );
                            });
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                    )
                  ]),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(widget.shopItemsList[index].itemName),
                    value: false,
                    onChanged: (value) {
                      setState(() {
                        widget.shopItemsList[index].isBought = value!;
                      });
                    },
                  ),
                );
              }),
        )
      ],
    );
  }

  void _addItem({required ShopItem itemToShop}) {
    Provider.of<ShoppingBloc>(context)
        .inputClient
        .add(AddShoppingEvent(item: itemToShop));
  }
}
