import 'package:flutter/material.dart';
import 'screens/shopping_list_screen.dart';
import './screens/shopping_item_screen.dart';
import 'dbhelper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      initialRoute: '/',
      routes: {
        '/': (context) => const ShopingListScreen(),
        ShoppingItemScreen.routeName: (context) => const ShoppingItemScreen(),
      },
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(63, 81, 181, 1),
          secondary: Colors.pink,
          error: Colors.red,
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
