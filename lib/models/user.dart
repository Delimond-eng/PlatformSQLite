class User {
  int userId;
  String userName, userGender;
  User({
    this.userId,
    this.userGender,
    this.userName,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["username"] = userName;
    data["gender"] = userGender;
    return data;
  }

  User.fromMap(Map<String, dynamic> map) {
    userId = map["userId"];
    userName = map["username"];
    userGender = map["gender"];
  }
}
