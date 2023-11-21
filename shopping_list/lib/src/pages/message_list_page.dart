import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 20),
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
              child: TextFormField(
                controller: _listController,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Exemplo:\nArroz\nFeijão\nAlface\n...",
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Informe a lista para salvar";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Adicionando lista..."),
                      duration: Duration(seconds: 1, milliseconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text("Salvar lista"),
            )
          ],
        ),
      ),
    );
  }

  List<String> formatToList(String listMessage) {
    List<String> list = listMessage.split("\n");
    return list;
  }

  // void add(String listMessage) {
  //   List<String> listFromMessage = formatToList(listMessage);

  //   List<ShopItem> list = listFromMessage
  //       .map(
  //         (item) => ShopItem.fromItemStr(item),
  //       )
  //       .toList();
  // }
}
