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
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Lista de compras:",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 25, 88, 26),
            ),
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _listController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Informe a lista para salvar";
                }
                return null;
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Adicionando lista..."),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text("Salvar lista"),
            ),
          )
        ],
      ),
    );
  }
}
