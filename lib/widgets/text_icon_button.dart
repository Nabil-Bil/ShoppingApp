import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final IconData icon;
  const TextIconButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24,
              ),
              Text(title)
            ]),
        onPressed: onPressed);
  }
}
