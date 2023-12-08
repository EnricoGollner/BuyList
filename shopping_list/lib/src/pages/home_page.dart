import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/src/bloc/shopping_bloc.dart';
import 'package:shopping_list/src/bloc/shopping_events.dart';
import 'package:shopping_list/src/pages/items_page.dart';
import 'package:shopping_list/src/pages/message_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    context.read<ShoppingBloc>().inputClient.add(LoadShoppingEvent());
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    context.read<ShoppingBloc>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: StreamBuilder(
        stream: context.read<ShoppingBloc>().stream,
        builder: (context, snaphot) {
          if (snaphot.hasData) {
            return PageView(
              controller: _pageController,
              onPageChanged: _setCurrentPage,
              children: [
                ItemsPage(snapshot: snaphot),
                const MessageList(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Lista",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Inserir por mensagem",
          ),
        ],
        onTap: (pageIndex) {
          _pageController.animateToPage(pageIndex,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }

  void _setCurrentPage(int pageIndex) {
    setState(() => _currentPage = pageIndex);
  }
}
