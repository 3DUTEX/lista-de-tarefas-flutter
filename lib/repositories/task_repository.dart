// Interface repository
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/database/db.dart';
import 'package:sqflite/sqflite.dart';

abstract class ITaskRepository {
  Future<int> add(Task task);
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasks({int status});
  Future<bool> delete(int id);
  Future<Task> update(int id, Map<String, dynamic> data);
  Future<Task> getOne(int id);
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
  Future<bool> delete(int id) async {
    Database db = await _database.database;
    try {
      await db.delete("tasks", where: "id = ?", whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    Database db = await _database.database;

    List<Map<String, dynamic>> tasks = await db.query("tasks");

    // Colocando tasks do BD em uma lista de instâncias
    List<Task> listTasks = [];
    for (Map<String, dynamic> taskData in tasks) {
      Task task = Task(
          id: taskData["id"],
          title: taskData["title"],
          desc: taskData["desc"],
          date: taskData["date"],
          status: taskData["status"]);
      listTasks.add(task);
    }

    return listTasks;
  }

  @override
  Future<Task> update(int id, Map<String, dynamic> data) async {
    Database db = await _database.database;
    await db.update("tasks", data, where: 'id = ?', whereArgs: [id]);
    return await getOne(id);
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
          id: taskData["id"],
          title: taskData["title"],
          desc: taskData["desc"],
          date: taskData["date"],
          status: taskData["status"]);
      listTasks.add(task);
    }

    return listTasks;
  }

  @override
  Future<Task> getOne(int id) async {
    Database db = await _database.database;

    // Pegando somente o primeiro item da lista
    Map<String, dynamic> task =
        (await db.query("tasks", where: "id = ?", whereArgs: [id]))[0];

    return Task(
        id: task["id"],
        title: task["title"],
        desc: task["desc"],
        status: task["status"],
        date: task["date"]);
  }
}
