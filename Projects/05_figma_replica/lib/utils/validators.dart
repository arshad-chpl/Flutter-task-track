class Validators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email required";
    }

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!regex.hasMatch(value)) {
      return "Enter valid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Password must contain 6 characters";
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name required";
    }

    return null;
  }
}
