import 'package:flutter/material.dart';

import '../dbhelper.dart';
import '../models/shopping_list.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/shopping_list_item.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_toast.dart';

class ShopingListScreen extends StatefulWidget {
  const ShopingListScreen({Key? key}) : super(key: key);

  @override
  State<ShopingListScreen> createState() => _ShopingListScreenState();
}

class _ShopingListScreenState extends State<ShopingListScreen> {
  @override
  Widget build(BuildContext context) {
    final allLists = DbHelper().getLists;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: FutureBuilder(
        future: allLists,
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.data!.isEmpty) {
            return Center(child: Image.asset("assets/icons/noItem.png"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ShoppingListItem(
              listItem: ShoppingList(
                  id: snapshot.data![index]['id'],
                  name: snapshot.data![index]['name'],
                  priority: snapshot.data![index]['priority']),
              handlerDelete: () {
                setState(() {
                  DbHelper().deleteList(snapshot.data![index]['id']);
                });
              },
              handlerEdit: (ShoppingList shoppingList) {
                setState(() {
                  DbHelper().editList(shoppingList);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController name = TextEditingController();
          TextEditingController priority = TextEditingController();

          showDialog(
              context: context,
              builder: (ctx) => CustomDialog(
                    title: 'Add Shopping List',
                    children: <Widget>[
                      CustomTextField(
                        title: 'Name',
                        controller: name,
                        maxLength: 20,
                      ),
                      CustomTextField(
                        title: 'Priority',
                        controller: priority,
                        keyboardType: TextInputType.number,
                      )
                    ],
                    onPressed: () {
                      setState(() {
                        if (priority.text == '' || name.text == '') {
                          showToast("Invalid Inputs! Retry");
                        } else if (int.tryParse(priority.text) == null ||
                            int.parse(priority.text) <= 0) {
                          showToast("Priority must be a positive integer");
                        } else {
                          DbHelper().insertList(
                            ShoppingList(
                              id: 0,
                              name: name.text,
                              priority: (int.parse(
                                priority.text,
                              )),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      });
                    },
                    titleButton: 'Add',
                    iconButton: Icons.add,
                  ));
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 10,
      ),
    );
  }
}
