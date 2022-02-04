import 'db_helper.dart';

class DbManager {
  static Future<void> createTables() async {
    try {
      await DbHelper.createTable(
          "CREATE TABLE IF NOT EXISTS users(userId INTEGER NOT NULL PRIMARY KEY, username TEXT, gender TEXT)");
      await DbHelper.createTable(
          "CREATE TABLE IF NOT EXISTS jobs(jobId INTEGER NOT NULL PRIMARY KEY, userId INTEGER, jobName TEXT)");
    } catch (e) {
      print("error from creating tables $e");
    }
  }
}
