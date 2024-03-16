// Interface repository
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/database/db.dart';
import 'package:sqflite/sqflite.dart';

abstract class ITaskRepository {
  Future<int> add(Task task);
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasks({int status});
  bool delete(int id);
  Task update(int id, Map<String, dynamic> data);
}

// Class Repository
class TaskRepository implements ITaskRepository {
  final DB _database = DB.instance;

  @override
  Future<int> add(Task task) async {
    Database db = await _database.database;
    int idInserted = await db.insert('tasks', task.toMap());

    return idInserted;
  }

  @override
  bool delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTasks() async {
    Database db = await _database.database;

    List<Map<String, dynamic>> tasks = await db.query("tasks");

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

  @override
  Future<List<Task>> getTasks({int status = 0}) async {
    Database db = await _database.database;

    List<Map<String, dynamic>> tasks =
        await db.query("tasks", where: "status = ?", whereArgs: [status]);

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
}
