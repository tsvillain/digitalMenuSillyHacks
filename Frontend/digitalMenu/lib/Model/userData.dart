class UserData {
  String name;
  String email;

  UserData({
    this.name,
    this.email,
  });

  UserData.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.email = map["email"];
  }

  toJson() {
    return {
      "name": this.name,
      "email": this.email,
    };
  }
}
