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
          /*await DbHelper.createTables('''CREATE TABLE IF NOT EXISTS agents(
      agentId INTEGER NOT NULL PRIMARY KEY,
      agentNom TEXT,
      agentGender TEXT
    );''');*/
          //await _createdb();

          await DbHelper.update(
            tableName: "agents",
            values: {"agentNom": "Blaise", "agentGender": "Female"},
            where: "agentId",
            whereArgs: [4],
          );

          var res = await DbHelper.query(table: "agents");
          print(res);
          /*await DbHelper.delete(
              tableName: "users",
              where: "usernom",
              whereArgs: ["'Jason sthatan'"]);*/
          //await readData();
          /*var res = await DbHelper.rawQuery("SELECT * FROM users");
          res.forEach((e) {
            print(e['usernom']);
          });*/
          //await DbHelper.delete(table: "users");
        },
        tooltip: 'Create db & read data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
