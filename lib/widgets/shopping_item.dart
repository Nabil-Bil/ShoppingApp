import 'package:flutter/material.dart';
import 'custom_dialog.dart';
import '../models/item.dart';
import 'custom_text_field.dart';
import "custom_toast.dart";

class ShoppingItem extends StatelessWidget {
  final Item item;
  final Function() handlerDelelte;
  final Function(Item item) handlerEdit;

  const ShoppingItem(
      {Key? key,
      required this.item,
      required this.handlerEdit,
      required this.handlerDelelte})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 13.0),
        child: Text(
          "Quantity: ${item.quantity}",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              TextEditingController name =
                  TextEditingController(text: item.name);
              TextEditingController quantity =
                  TextEditingController(text: item.quantity);
              TextEditingController note =
                  TextEditingController(text: item.note);

              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                        title: "Edit${item.name}",
                        children: [
                          CustomTextField(
                              title: "Name", controller: name, maxLength: 50),
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
                          if (quantity.text == '' || name.text == '') {
                            showToast("Invalid Inputs! Retry");
                          } else {
                            if (note.text == item.note &&
                                name.text == item.name &&
                                quantity.text == item.quantity) {
                              Navigator.pop(context);
                            } else {
                              handlerEdit(Item(
                                id: item.id,
                                idList: item.idList,
                                name: name.text,
                                note: note.text,
                                quantity: quantity.text,
                              ));
                              Navigator.pop(context);
                            }
                          }
                        },
                        titleButton: "Edit",
                        iconButton: Icons.edit);
                  });
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              handlerDelelte();
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                  title: item.name,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Name : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Text(item.name))
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Quantity : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Text(item.quantity))
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Note : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.note,
                          ),
                        )
                      ],
                    ),
                  ],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  titleButton: 'Exit',
                  iconButton: Icons.exit_to_app);
            });
      },
    );
  }
}
