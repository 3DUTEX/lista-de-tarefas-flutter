import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

// Singleton
class DB {
  static const _databaseName = "listaTarefas.db";

  // torna o construtor privado
  DB._();
  static final DB instance = DB._();

  // abre o banco de dados
  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase(); // se for null, cria BD

  // inicializa o banco de dados
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // cria a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        desc TEXT NOT NULL,
        date DateTime NOT NULL,
        status INTEGER NOT NULL
      )
      ''');
  }

  // // insere um registro
  // Future<int> insert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert('todo', row);
  // }

  // // recupera todos os registros
  // Future<List<TodoItem>> queryAll() async {
  //   Database db = await instance.database;
  //   var data = await db.query('todo');

  //   List<TodoItem> listTodo = [];

  //   for (var item in data) {
  //     TodoItem todoItem = TodoItem(
  //         id: item["id"] as int,
  //         name: item["name"] as String,
  //         status: item["status"] as int);
  //     listTodo.add(todoItem);
  //   }

  //   return listTodo;
  // }

  // // atualiza um registro
  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row['id'];
  //   return await db.update('todo', row, where: 'id = ?', whereArgs: [id]);
  // }

  // // exclui um registro
  // Future<int> delete(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete('todo', where: 'idd = ?', whereArgs: [id]);
  // }
}
