import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/components/data_picker.dart';
import 'package:lista_de_tarefas/components/text_field_custom.dart';
import 'package:lista_de_tarefas/helpers/show_toast.dart';
import 'package:lista_de_tarefas/models/task.dart';
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

  // Valida campos
  bool validateFields() {
    if (titleController.text == "") return false;
    if (descController.text == "") return false;
    if (dataPickerController.text == "") return false;

    return true;
  }

  void clearFields() {
    setState(() {
      titleController.text = "";
      descController.text = "";
      dataPickerController.text = "";
    });
  }

  Future<int> addTask(BuildContext context) async {
    if (!validateFields()) {
      if (context.mounted) {
        showToast(context,
            backgroundColor: Colors.red,
            msg: "Todos os campos devem ser preenchidos!");
      }
      return 0;
    }

    Task task = Task(
        title: titleController.text,
        desc: descController.text,
        date: dataPickerController.text,
        status: 0);

    int id = await taskRepository.add(task);

    if (context.mounted) {
      showToast(context,
          backgroundColor: Colors.green, msg: "Tarefa inserida com sucesso!");
    }

    clearFields();

    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Adicionar uma tarefa",
              style: TextStyle(fontSize: 20),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: TextButton(
              onPressed: () => addTask(context),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ),
        ],
      ),
    );
  }
}
