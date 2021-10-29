class UserCredentialsValidator {

  static bool isNotValidEmailFormat(String? email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (email != null && !regex.hasMatch(email))
      return true;
    else
      return false;
  }

  static bool isNotValidPasswordFormat(String? password) {
    if (password != null && password.length<6)
      return true;
    else
      return false;
  }

  static isNotValidPhoneFormat(String? phone) {
    if (phone != null && phone.length<11)
      return true;
    else
      return false;
  }

  static isNotValidNameFormat(String? name) {
    if (name != null && name.length<4)
      return true;
    else
      return false;
  }

}
