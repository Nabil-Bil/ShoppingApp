import 'package:flutter/material.dart';

import '../models/shopping_list.dart';

import 'custom_dialog.dart';
import 'custom_text_field.dart';

class ShoppingListItem extends StatelessWidget {
  final ShoppingList listItem;
  final Function handlerDelete;
  final Function(ShoppingList shoppingList) handlerEdit;
  const ShoppingListItem(
      {Key? key,
      required this.listItem,
      required this.handlerDelete,
      required this.handlerEdit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Text('${listItem.priority}'),
      ),
      title: Text(listItem.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                final TextEditingController name =
                    TextEditingController(text: listItem.name);
                final TextEditingController priority =
                    TextEditingController(text: listItem.priority.toString());
                showDialog(
                  context: context,
                  builder: (_) => CustomDialog(
                    title: 'Edit',
                    children: <Widget>[
                      CustomTextField(
                          title: 'Name',
                          controller: name,
                          keyboardType: TextInputType.text),
                      CustomTextField(
                          title: 'Priority',
                          controller: priority,
                          keyboardType: TextInputType.number)
                    ],
                    onPressed: () {
                      if (priority.text == '' || name.text == '') {
                        const snackBar = SnackBar(
                          content: Text('Invalid Inputs.Retry'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (int.tryParse(priority.text) == null ||
                          int.parse(priority.text) <= 0) {
                        const snackBar = SnackBar(
                          content: Text('Priority must be a positive integer'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        handlerEdit(ShoppingList(
                            id: listItem.id,
                            name: name.text,
                            priority: int.parse(priority.text)));
                      }

                      Navigator.pop(context);
                    },
                    titleButton: 'Edit',
                    iconButton: Icons.edit,
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: () {
                handlerDelete();
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              )),
        ],
      ),
      onTap: () {},
    );
  }
}
