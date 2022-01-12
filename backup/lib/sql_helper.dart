import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
    CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('books.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  // add
  static Future<int> addBook(String title, String desc) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'desc': desc};
    return await db.insert('books', data);
  }

  // read
  static Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await SQLHelper.db();
    return db.query('books');
  }

  // update
  static Future<int> updateBooks(int id, String title, String desc) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'desc': desc};
    return await db.update('books', data, where: "id = $id");
  }

  // delete
  static Future<void> deleteBook(int id) async {
    final db = await SQLHelper.db();
    await db.delete('books', where: "id = $id");
  }
}
