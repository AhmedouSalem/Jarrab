class Validators {
  Validators._();

  static bool isEmail(String value) {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value);
  }

  static bool hasMinLength(String value, int min) {
    return value.length >= min;
  }

  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }

  static bool equals(String a, String b) {
    return a == b;
  }
}
