import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/repositories/task_repository.dart';

class PendingActivity extends StatefulWidget {
  const PendingActivity({super.key});

  @override
  State<PendingActivity> createState() => _PendingActivityState();
}

class _PendingActivityState extends State<PendingActivity> {
  TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: taskRepository.getTasks(status: 0),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Task> data = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pendentes",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return TaskItem(task: data[index]);
                        }))
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text("Descrição: ${task.desc}"),
          ),
          Text("Data conclusão : ${task.date}")
        ],
      ),
      trailing: Wrap(
        spacing: 20,
        children: [
          const Icon(Icons.edit),
          GestureDetector(
            onTap: () {
              print(task.id);
            },
            child: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
