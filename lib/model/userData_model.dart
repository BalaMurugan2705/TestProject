
class UserData {
  String? password;
  String? name;
  bool? isAdmin;
  String? email;

  UserData({this.password, this.name, this.isAdmin, this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    name = json['name'];
    isAdmin = json['isAdmin'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['name'] = name;
    data['isAdmin'] = isAdmin;
    data['email'] = email;
    return data;
  }
}
