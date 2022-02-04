import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/job.dart';
import 'models/user.dart';
import 'services/db_helper.dart';
import 'services/db_manager.dart';
import 'widgets/input_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textUserName = TextEditingController();
  final TextEditingController textUserGender = TextEditingController();
  final TextEditingController textJob = TextEditingController();

  List<User> users = [];
  List<Job> usersJobs = [];

  @override
  void initState() {
    super.initState();
    DbManager.createTables();
    initData();
  }

  initData() async {
    var userJsonArray = await DbHelper.query(table: "users");
    users.clear();
    userJsonArray.forEach((e) {
      setState(() {
        users.add(User.fromMap(e));
      });
    });
    emptyUser();
    viewJobs();
  }

  User selectedUser;
  final formKeyUser = GlobalKey<FormState>();
  final formKeyJob = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform SQLite"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKeyUser,
                          child: Column(
                            children: [
                              InputField(
                                errorText: "user name is required !",
                                hintText: "Enter user name",
                                icon: CupertinoIcons.person_crop_square,
                                expandedLabel: "User Name",
                                controller: textUserName,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              InputField(
                                errorText: "user gender is required !",
                                hintText: "Enter user gender(Male or Female)",
                                icon:
                                    CupertinoIcons.rectangle_stack_person_crop,
                                expandedLabel: "User Gender",
                                controller: textUserGender,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      child: RaisedButton(
                                        elevation: 10.0,
                                        color: Colors.green[700],
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => addUser(context),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      child: RaisedButton(
                                        elevation: 10.0,
                                        color: Colors.blue,
                                        child: const Text(
                                          "Update",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKeyJob,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                height: 50.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    menuMaxHeight: 300,
                                    dropdownColor: Colors.white,
                                    alignment: Alignment.centerRight,
                                    borderRadius: BorderRadius.circular(5.0),
                                    style: const TextStyle(color: Colors.black),
                                    value: selectedUser,
                                    hint: Text(
                                      "Select user",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: users.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            e.userName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedUser = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              InputField(
                                errorText: "job name is required !",
                                hintText: "Enter job name",
                                icon: CupertinoIcons.settings,
                                expandedLabel: "Job Name",
                                controller: textJob,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      child: RaisedButton(
                                        elevation: 10.0,
                                        color: Colors.green[700],
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => addJob(context),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      child: RaisedButton(
                                        elevation: 10.0,
                                        color: Colors.blue,
                                        child: const Text(
                                          "Update",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.grey.withOpacity(.3),
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.blue[100],
                        ),
                        height: 60.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "N°",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User name",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User gender",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Job",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Container()],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: usersJobs
                                .map(
                                  (row) => TableBodyJobs(
                                    data: row,
                                    onDelete: () async {
                                      await DbHelper.delete(
                                        tableName: "jobs",
                                        where: "jobId",
                                        whereArgs: [row.jobId],
                                      );
                                      await viewJobs();
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'Create db & read data',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> viewJobs() async {
    var res = await DbHelper.rawQuery(
        "SELECT * FROM users INNER JOIN jobs ON users.userId = jobs.userId");
    usersJobs.clear();
    res.forEach((e) {
      setState(() {
        usersJobs.add(Job.fromMap(e));
      });
    });
  }

  void addUser(context) async {
    if (formKeyUser.currentState.validate()) {
      User user = User(
        userGender: textUserGender.text,
        userName: textUserName.text,
      );
      int lastInsertId = await DbHelper.insert(
        tableName: "users",
        values: user.toMap(),
      );
      if (lastInsertId != null) {
        print(lastInsertId);
        initData();
        formKeyUser.currentState.reset();
      }
    }
  }

  void addJob(context) async {
    if (formKeyJob.currentState.validate()) {
      Job job = Job(jobName: textJob.text, userId: selectedUser.userId);
      int lastInsertId = await DbHelper.insert(
        tableName: "jobs",
        values: job.toMap(),
      );
      if (lastInsertId != null) {
        print(lastInsertId);
        formKeyJob.currentState.reset();
        emptyUser();
        await viewJobs();
      }
    }
  }

  emptyUser({User user}) {
    setState(() {
      selectedUser = user;
    });
  }
}

class TableBodyJobs extends StatelessWidget {
  final Job data;
  final Function onDelete;
  const TableBodyJobs({
    Key key,
    this.data,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.grey.withOpacity(.3),
            offset: Offset.zero,
          ),
        ],
        color: Colors.white,
      ),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.jobId}",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.userName,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.userGender,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.jobName,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RawMaterialButton(
                  onPressed: onDelete,
                  child: const Icon(
                    CupertinoIcons.trash,
                    color: Colors.white,
                    size: 15,
                  ),
                  shape: const CircleBorder(),
                  elevation: 0,
                  fillColor: Colors.grey[800],
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
