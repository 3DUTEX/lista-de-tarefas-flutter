import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/components/data_picker.dart';
import 'package:lista_de_tarefas/components/text_field_custom.dart';
import 'package:lista_de_tarefas/helpers/show_toast.dart';
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/repositories/task_repository.dart';

class EditActivity extends StatefulWidget {
  final Task task;

  const EditActivity({required this.task, super.key});

  @override
  State<EditActivity> createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  TaskRepository taskRepository = TaskRepository();

  TextEditingController dataPickerController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool statusState = false;

  // Valida campos
  bool validateFields() {
    if (titleController.text == "") return false;
    if (descController.text == "") return false;
    if (dataPickerController.text == "") return false;

    return true;
  }

  Future<Task?> changeTask(BuildContext context) async {
    if (!validateFields()) {
      if (context.mounted) {
        showToast(context,
            backgroundColor: Colors.red,
            msg: "Todos os campos devem estar preenchidos!");
      }
      return null;
    }

    Task newValue = Task(
        title: titleController.text,
        desc: descController.text,
        date: dataPickerController.text,
        status: statusState ? 1 : 0);

    Task taskUpdated =
        await taskRepository.update(widget.task.id, newValue.toMap());

    if (context.mounted) {
      showToast(context,
          backgroundColor: Colors.green, msg: "Tarefa alterada com sucesso!");
    }

    setTaskOnInputs(taskUpdated);
    Navigator.pop(context);
    return taskUpdated;
  }

  void setTaskOnInputs(Task task) {
    setState(() {
      dataPickerController.text = task.date;
      titleController.text = task.title;
      descController.text = task.desc;
      statusState = task.status == 1 ? true : false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTaskOnInputs(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Alterar tarefa",
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(statusState ? 'Concluído' : 'Pendente'),
                  Switch(
                      activeColor: Colors.indigo,
                      value: statusState,
                      onChanged: (value) => setState(() {
                            statusState = value;
                          })),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextButton(
                onPressed: () {
                  changeTask(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4))))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    Text(
                      "ALTERAR TAREFA",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
