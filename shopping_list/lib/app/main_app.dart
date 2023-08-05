import 'package:flutter/material.dart';
import 'package:shopping_list/app/pages/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}
