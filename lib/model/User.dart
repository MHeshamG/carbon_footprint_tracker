import 'dart:developer';

class CUser {
  String? email;
  String? name;
  String? phone;
  String? id;

  CUser(this.email);

  CUser.createUserWithWholeData(this.email, this.name, this.phone);

  Map<String, dynamic> toJsonFormat() {
    return {
      "email": email,
      "name": name,
      "phone": phone
    };
  }

  void loadData(Map<String, dynamic> data) {
    name = data["name"];
    phone = data["phone"];
    log("User Data: ${name} ${phone}");
  }
}
