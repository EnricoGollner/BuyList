import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/src/bloc/shopping_bloc.dart';
import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/pages/widgets/box_text_field.dart';
import 'package:shopping_list/src/utils/validator.dart';

class BoxShoppingList extends StatefulWidget {
  final List<ItemToShop> shopItemsList;

  const BoxShoppingList({super.key, required this.shopItemsList});

  @override
  State<BoxShoppingList> createState() => _BoxShoppingListState();
}

class _BoxShoppingListState extends State<BoxShoppingList> {
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
                    child: BoxTextField(
                      controller: _itemToShopCtrl,
                      hintText: 'Informe o item para adicionar a lista',
                      validatorFunction: Validator.isRequired,
                    )),
              ),
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final ItemToShop itemToShop =
                          ItemToShop.create(itemName: _itemToShopCtrl.text);
                      _addItem(itemToShop: itemToShop);
                      _itemToShopCtrl.clear();
                    }
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    height: 2,
                    thickness: 2,
                  ),
              itemCount: widget.shopItemsList.length,
              itemBuilder: (context, index) {
                final ItemToShop itemToShop = widget.shopItemsList[index];

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
                                      _deleteItem(itemToShop: itemToShop);
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
                    title: Text(itemToShop.itemName),
                    value: itemToShop.isBought,
                    onChanged: (isBought) {
                      setState(() => itemToShop.isBought = isBought!);
                      _updateItem(item: itemToShop);
                    },
                  ),
                );
              }),
        )
      ],
    );
  }

  void _addItem({required ItemToShop itemToShop}) {
    context.read<ShoppingBloc>().inputClient.add(AddShoppingEvent(item: itemToShop));
  }

  void _updateItem({required ItemToShop item}) {
    context.read<ShoppingBloc>().inputClient.add(UpdateItemToShopEvent(item: item));
  }

  void _deleteItem({required ItemToShop itemToShop}) {
    context.read<ShoppingBloc>().inputClient.add(RemoveShoppingEvent(item: itemToShop));
  }
}
