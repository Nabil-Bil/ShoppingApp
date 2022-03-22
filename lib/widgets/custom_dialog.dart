import 'package:flutter/material.dart';
import '../widgets/text_icon_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String titleButton;
  final IconData iconButton;
  final List<Widget> children;
  final Function() onPressed;
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.children,
      required this.onPressed,
      required this.titleButton,
      required this.iconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(title),
      content: ListBody(
        children: children,
      ),
      actions: <Widget>[
        TextIconButton(
          title: titleButton,
          onPressed: onPressed,
          icon: iconButton,
        )
      ],
    );
  }
}
