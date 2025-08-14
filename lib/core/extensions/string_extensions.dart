extension StringValidation on String {
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 6;
  }

  bool get isNotEmpty {
    return trim().isNotEmpty;
  }

  bool matches(String other) {
    return this == other;
  }

  String? validateEmail({String? message}) {
    if (!isValidEmail) {
      return message ?? 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword({String? message, int minLength = 6}) {
    if (length < minLength) {
      return message ?? 'Password must be at least $minLength characters';
    }
    return null;
  }

  String? validateNotEmpty({String? message}) {
    if (!isNotEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  String? validateMatch(String other, {String? message}) {
    if (!matches(other)) {
      return message ?? 'Fields do not match';
    }
    return null;
  }
}
