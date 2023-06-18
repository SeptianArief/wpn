class UserModel {
  late int level;
  late String name;
  late String username;
  late String status;
  int? id;

  UserModel(
      {required this.level,
      required this.name,
      required this.username,
      required this.status});

  UserModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    username = jsonMap['username'];
    name = jsonMap['name'];
    status = jsonMap['is_active'].toString();
    level = 0;
  }
}
