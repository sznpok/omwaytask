class ValidationMixin {
  validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value.trim())) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  validateName(String value, {String? title}) {
    if (value.isEmpty) {
      return title == null ? "required*" : "$title is required ";
    }
    return null;
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value.length < 7) {
      return "Password must be 8 digit";
    }
    return null;
  }
}
