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
      future: taskRepository.getAll(),
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
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(data[index].title),
                            subtitle: Text(data[index].desc),
                            trailing: const Wrap(
                              children: [
                                Icon(Icons.delete),
                                Icon(Icons.delete)
                              ],
                            ),
                          );
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
