import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text("Arroz"),
                value: false,
                onChanged: (value) {},
              );
            }),
          ),
        ],
      ),
    );
  }
}
