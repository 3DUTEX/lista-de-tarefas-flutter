// TextField
import 'package:flutter/material.dart';

class ObscuredTextFieldSample extends StatelessWidget {
  final String label;

  final TextEditingController textEditingController;

  const ObscuredTextFieldSample(
      {required this.label, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
