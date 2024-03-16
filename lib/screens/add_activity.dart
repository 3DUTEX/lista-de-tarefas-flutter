import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/repositories/task_repository.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TaskRepository taskRepository = TaskRepository();

  TextEditingController dataPickerController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ObscuredTextFieldSample(
            textEditingController: titleController,
            label: "Titulo tarefa",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: ObscuredTextFieldSample(
              textEditingController: descController,
              label: "Descrição da tarefa",
            ),
          ),
          DataPicker(textEditingController: dataPickerController),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: CustomButton(),
          ),
        ],
      ),
    );
  }
}

// TextField
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

// DataPicker
class DataPicker extends StatefulWidget {
  final TextEditingController textEditingController;

  const DataPicker({required this.textEditingController, super.key});

  @override
  State<DataPicker> createState() => _DataPickerState();
}

class _DataPickerState extends State<DataPicker> {
  // Função que chama o dataPicker
  Future<void> _selectDate() async {
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
        labelText: "Date final de conclusão",
        filled: true,
        prefixIcon: Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true, // Apenas leitura
      onTap: () {
        _selectDate();
      },
      controller: widget.textEditingController,
    );
  }
}

// Button
class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))))),
      child: const Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Text(
            "ADICIONAR TAREFA",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
