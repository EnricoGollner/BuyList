import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/src/bloc/shopping_bloc.dart';
import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/data/models/shop_item.dart';
import 'package:shopping_list/src/pages/widgets/box_snack_bar.dart';
import 'package:shopping_list/src/pages/widgets/box_text_field.dart';
import 'package:shopping_list/src/utils/validator.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _listController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Lista de compras:",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 25, 88, 26),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: BoxTextField(
                controller: _listController,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                hintText: "Exemplo:\nArroz\nFeijão\nAlface\n...",
                validatorFunction: Validator.isRequired,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showSnackBar(
                    context,
                    message: 'Adicionando lista...',
                    backgroundColor: Colors.greenAccent,
                  );

                  _addItemsFromMessage(messageList: _listController.text);
                }
              },
              child: const Text("Salvar lista"),
            )
          ],
        ),
      ),
    );
  }

  void _addItemsFromMessage({required String messageList}) {
    List<String> listFromMessage = _formatToList(messageList);

    List<ItemToShop> itemsList = listFromMessage.map(
          (itemName) => ItemToShop.create(itemName: itemName),
        ).toList();

    Provider.of<ShoppingBloc>(context, listen: false).inputClient.add(AddListShoppingEvent(itemsList: itemsList));

    showSnackBar(
      context,
      message: 'Lista adicionada com sucesso!',
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );
  }

  List<String> _formatToList(String listMessage) {
    List<String> list = listMessage.split("\n");
    return list;
  }
}
