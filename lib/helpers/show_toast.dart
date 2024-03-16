import 'package:flutter/material.dart';

void showToast(context,
    {Color backgroundColor = Colors.cyan, String msg = "Mensagem Vazia!"}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: backgroundColor,
  ));
}
