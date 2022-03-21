// ignore_for_file: avoid_print, unnecessary_string_escapes

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/item.dart';
import 'models/shopping_list.dart';

class DbHelper {
  int version = 1;
  Database? db;

  Future<Database> openDb() async {
    if (db == null) {
      final sqlDb = await openDatabase(
          join(await getDatabasesPath(), 'shopping.db'),
          version: version, onCreate: (database, version) {
        database.execute(
            "CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)");
        database.execute(
            "CREATE TABLE items(id INTEGER PRIMARY KEY,idList INTEGER, name TEXT, quantity TEXT,note TEXT,FOREIGN KEY(idList) REFERENCES lists(id))");
      });
      return sqlDb;
    }
    throw Exception();
  }

  Future testDb() async {
    db = await openDb();
    // db!.execute("INSERT INTO lists values(1,'fruits',2)");
    // db!.execute(
    //     "INSERT INTO items values(1,1,'pomme','5 kg','Acheter des pommes pour la tarte au pomme')");
    List lists = await db!.rawQuery('SELECT * from lists');
    List items = await db!.rawQuery('SELECT * from items');
    print(lists);
    print(items);
  }

  //list queries
  Future<int> insertList(ShoppingList list) async {
    db = await openDb();
    int id = await db!.insert(
      'lists',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  deleteList(int id) async {
    db = await openDb();
    return db!.rawDelete('DELETE FROM lists where id=$id');
  }

  Future<List<Map>> get getLists async {
    db = await openDb();
    List<Map> allLists =
        await db!.rawQuery("SELECT * from lists ORDER BY priority DESC");
    return allLists;
  }

  Future<int> editList(ShoppingList shoppingList) async {
    db = await openDb();
    print(shoppingList);
    return await db!.rawUpdate(
        'UPDATE lists SET name = \"${shoppingList.name}\", priority = ${shoppingList.priority} where id=${shoppingList.id}');
  }

  //items queries

  Future<int> insertItem(Item item) async {
    db = await openDb();
    int id = await db!.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<void> dropDataBase() async => databaseFactory
      .deleteDatabase(join(await getDatabasesPath(), 'shopping.db'));
}
