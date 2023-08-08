import 'package:flutter/material.dart';
import 'package:shopping_list/app/tabs/message_list.dart';
import 'package:shopping_list/app/tabs/shopping_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ShoppingList"),
        ),
        body: const SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.list_alt,
                      color: Colors.green,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.list,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ShoppingList(),
                    MessageList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
