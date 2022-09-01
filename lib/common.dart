import 'package:flutter/material.dart';

Widget getRoute(BuildContext context, String text, String routeName) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, routeName);
    },
    child: Text(text),
  );
}
