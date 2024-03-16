// DataPicker
import 'package:flutter/material.dart';

class DataPicker extends StatefulWidget {
  final TextEditingController textEditingController;

  const DataPicker({required this.textEditingController, super.key});

  @override
  State<DataPicker> createState() => _DataPickerState();
}

class _DataPickerState extends State<DataPicker> {
  // Função que chama o dataPicker
  Future<void> selectDate() async {
    DateTime? dateSelected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));

    if (dateSelected != null) {
      setState(() {
        widget.textEditingController.text =
            // Cortando os minutos e segundos da data
            dateSelected.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Data final de conclusão",
        filled: true,
        prefixIcon: Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true, // Apenas leitura
      onTap: () {
        selectDate();
      },
      controller: widget.textEditingController,
    );
  }
}
