// Interface repository
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/database/DB.dart';
import 'package:sqflite/sqflite.dart';

abstract class ITaskRepository {
  Future<int> add(Task task);
  Future<List<Task>> getAll();
  bool delete(int id);
  Task update(int id, Map<String, dynamic> data);
}

// Class Repository
class TaskRepository implements ITaskRepository {
  DB database = DB.instance;

  @override
  Future<int> add(Task task) async {
    Database db = await database.database;
    int idInserted = await db.insert('tasks', task.toMap());

    return idInserted;
  }

  @override
  bool delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAll() async {
    Database db = await database.database;

    const String query = "SELECT * FROM tasks";

    List<Map<String, dynamic>> tasks = await db.query(query);

    // Colocando tasks do BD em uma lista de instâncias
    List<Task> listTasks = [];
    for (Map<String, dynamic> taskData in tasks) {
      Task task = Task(
          title: taskData["title"],
          desc: taskData["desc"],
          date: taskData["date"],
          status: taskData["status"]);
      listTasks.add(task);
    }

    return listTasks;
  }

  @override
  Task update(int id, Map<String, dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
