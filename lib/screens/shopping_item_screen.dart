import 'package:flutter/material.dart';

import '../models/shopping_list.dart';
import '../widgets/shopping_item.dart';
import '../models/item.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_toast.dart';
import '../dbhelper.dart';

class ShoppingItemScreen extends StatefulWidget {
  static const String routeName = '/shopping-item';
  const ShoppingItemScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingItemScreen> createState() => _ShoppingItemScreenState();
}

class _ShoppingItemScreenState extends State<ShoppingItemScreen> {
  @override
  Widget build(BuildContext context) {
    final ShoppingList shoppingList =
        ModalRoute.of(context)!.settings.arguments as ShoppingList;
    final items = DbHelper().getItems(shoppingList.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.data!.isEmpty) {
            return Center(child: Image.asset("assets/icons/noItem.png"));
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return ShoppingItem(
                  item: Item(
                    id: snapshot.data![index]["id"],
                    idList: snapshot.data![index]["idList"],
                    name: snapshot.data![index]['name'],
                    quantity: snapshot.data![index]['quantity'],
                    note: snapshot.data![index]['note'],
                  ),
                  handlerDelelte: () {
                    setState(() {
                      DbHelper().deleteItem(snapshot.data![index]['id']);
                    });
                  },
                  handlerEdit: (Item item) {
                    setState(() {
                      DbHelper().editItem(item);
                    });
                  });
            },
            itemCount: snapshot.data!.length,
          );
        },
        future: items,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController name = TextEditingController();
          TextEditingController note = TextEditingController();
          TextEditingController quantity = TextEditingController();
          showDialog(
              context: context,
              builder: (_) {
                return CustomDialog(
                  title: "Add Item",
                  children: [
                    CustomTextField(
                      title: "name",
                      controller: name,
                      maxLength: 50,
                    ),
                    CustomTextField(
                      title: "Quantity",
                      controller: quantity,
                      maxLength: 10,
                    ),
                    CustomTextField(
                      title: "Note",
                      controller: note,
                      maxLength: 50,
                    ),
                  ],
                  onPressed: () {
                    if (name.text == '' || quantity.text == '') {
                      showToast("Invalid Inputs! Retry");
                    } else {
                      setState(() {
                        DbHelper().insertItem(
                          Item(
                            id: 0,
                            idList: shoppingList.id,
                            name: name.text,
                            quantity: quantity.text,
                            note: note.text,
                          ),
                        );
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  titleButton: "Add",
                  iconButton: Icons.add,
                );
              });
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
