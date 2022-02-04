class Job {
  int jobId;
  int userId;
  String userName;
  String userGender;
  String jobName;
  Job({
    this.jobId,
    this.userId,
    this.jobName,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["userId"] = userId;
    data["jobName"] = jobName;
    return data;
  }

  Job.fromMap(Map<String, dynamic> map) {
    jobId = map["jobId"];
    userId = map["userId"];
    jobName = map["jobName"];
    userName = map["username"];
    userGender = map["gender"];
  }
}
