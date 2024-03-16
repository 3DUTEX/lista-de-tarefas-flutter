import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/helpers/show_toast.dart';
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/repositories/task_repository.dart';

class CompletedActivity extends StatefulWidget {
  const CompletedActivity({super.key});

  @override
  State<CompletedActivity> createState() => _CompletedActivityState();
}

class _CompletedActivityState extends State<CompletedActivity> {
  TaskRepository taskRepository = TaskRepository();

  Future<void> handleClickDelete(BuildContext context, int id) async {
    bool isDeleted = await taskRepository.delete(id);

    if (!isDeleted) {
      if (context.mounted) {
        showToast(context,
            backgroundColor: Colors.red, msg: "Erro ao apagar tarefa!");
      }
      return;
    }

    if (context.mounted) {
      showToast(context,
          backgroundColor: Colors.green, msg: "Tarefa apagada com sucesso!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: taskRepository.getTasks(status: 1),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // se não tiver dados
          if (snapshot.data!.isEmpty) {
            return const SemTarefas();
          }

          // se tiver dados
          return Container(
            padding: const EdgeInsets.all(5),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Task task = snapshot.data![index];
                  return Card(
                    color: Colors.indigo,
                    elevation: 16,
                    child: ListTile(
                      title: Text(task.title,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Descrição: ${task.desc}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Text("Data conclusão : ${task.date}",
                              style: const TextStyle(color: Colors.white))
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 20,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await handleClickDelete(context, task.id);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class SemTarefas extends StatelessWidget {
  const SemTarefas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Concluídas",
            style: TextStyle(fontSize: 20),
          ),
          Text("Sem tarefas no momento!")
        ],
      ),
    );
  }
}
