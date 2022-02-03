import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

class DbHelper {
  static Database _db;

  static Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  static initDb() async {
    Database database;
    try {
      if (Platform.isLinux) {
        database = sqlite3.open("appdb.so");
      } else if (Platform.isWindows) {
        database = sqlite3.open('appdb.dll');
      }
    } catch (err) {
      print("error from init database $err");
    }
    return database;
  }

  static Future createDb() async {
    try {
      Database db = await initDb();
      db.execute('''
    CREATE TABLE IF NOT EXISTS users(
      id INTEGER NOT NULL PRIMARY KEY,
      usernom TEXT,
      useremail TEXT,
      userpass TEXT
    );
  ''');
      db.dispose();
    } catch (err) {
      print("creating database failed $err");
    }
  }

  static Future insert({String tableName, Map<String, dynamic> values}) async {
    final insert = StringBuffer();
    insert.write('INSERT');

    insert.write(' INTO ');
    insert.write(' $tableName');
    insert.write('(');

    final size = (values != null) ? values.length : 0;

    if (size > 0) {
      final sbValues = StringBuffer(') VALUES(');

      var i = 0;
      values.forEach((String colName, dynamic value) {
        if (i++ > 0) {
          insert.write(',');
          sbValues.write(',');
        }
        insert.write(' $colName');
        sbValues.write("'$value'");
      });
      insert.write(sbValues);
    } else {
      throw ArgumentError('column required when inserting data');
    }
    insert.write(')');
    String sql = insert.toString();

    try {
      Database database = await initDb();
      final stmt = database.prepare(sql);
      stmt.execute();
      stmt.dispose();
    } catch (err) {
      print("error from insert statment: $err");
    }
  }

  static Future update({
    String tableName,
    String where,
    Map<String, dynamic> values,
    List<dynamic> whereArgs,
  }) async {
    if (values == null || values.isEmpty) {
      throw ArgumentError('Empty values');
    }

    final update = StringBuffer();
    update.write('UPDATE');

    update.write(' $tableName');
    update.write(' SET ');
    var i = 0;

    values.keys.forEach((String colName) {
      update.write((i++ > 0) ? ', ' : '');
      update.write(colName);
      final dynamic value = values[colName];
      if (value != null) {
        update.write(" = '$value'");
      } else {
        update.write(' = NULL');
      }
    });

    writeClause(update, ' WHERE ', where);
    whereArgs.forEach((arg) {
      update.write(' = $arg');
    });

    try {
      String sql = update.toString();
      Database database = await initDb();
      final stmt = database.prepare(sql);
      stmt.execute();
      stmt.dispose();
    } catch (err) {
      print("error from update statment: $err");
    }
  }

  static Future delete({
    String tableName,
    String where,
    List<dynamic> whereArgs,
  }) async {
    final delete = StringBuffer();
    delete.write('DELETE FROM ');
    delete.write(tableName);
    writeClause(delete, ' WHERE ', where);
    if (whereArgs != null) {
      whereArgs.forEach((arg) {
        delete.write(' = $arg');
      });
    } else {
      throw ArgumentError('Where clause required');
    }
    try {
      String sql = delete.toString();
      Database database = await initDb();
      final stmt = database.prepare(sql);
      stmt.execute();
      stmt.dispose();
    } catch (err) {
      print("error from SQL delete statment $err");
    }
  }

  static void writeClause(StringBuffer s, String name, String clause) {
    if (clause != null) {
      s.write(name);
      s.write(clause);
    }
  }
}
