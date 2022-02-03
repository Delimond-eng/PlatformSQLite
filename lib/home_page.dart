import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart';

import 'services/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform SQLite"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //await DbHelper.createDb();
          //await DbHelper.insert();
          //await _createdb();

          await DbHelper.delete(
              tableName: "users",
              where: "usernom",
              whereArgs: ["'Jason sthatan'"]);
          await readData();
          //await DbHelper.delete(table: "users");
        },
        tooltip: 'Create db & read data',
        child: const Icon(Icons.add),
      ),
    );
  }

  readData() {
    //print('Using sqlite3 ${sqlite3.version}');

    // Create a new in-memory database. To use a database backed by a file, you
    // can replace this with sqlite3.open(yourFilePath).
    final db = sqlite3.open("appdb.so");
    // Create a table and insert some data
    /*db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');*/

    // Prepare a statement to run it multiple times:
    /*final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
    stmt
      ..execute(['Jean'])
      ..execute(['Casteque'])
      ..execute(['Ilunga'])
      ..execute(['Prince']);

    // Dispose a statement when you don't need it anymore to clean up resources.
    stmt.dispose();*/

    final ResultSet resultSet = db.select('SELECT * FROM users');
    resultSet.forEach((element) {
      print(element);
    });
    /*for (final row in resultSet) {
      print('Artist[id: ${row['id']}, name: ${row['name']}]');
    }*/
    db.dispose();
  }
}
