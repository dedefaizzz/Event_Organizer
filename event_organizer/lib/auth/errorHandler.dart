class ErrorHandler {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'email cannot be empty';
    }
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (!emailRegExp.hasMatch(email)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6 ||
        !RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$').hasMatch(password)) {
      return 'Password must be at least 6 characters and contain both letters and numbers';
    }
    return null;
  }

  static String? validateLogin(String email, String password,
      String registeredemail, String registeredPassword) {
    if (email != registeredemail || password != registeredPassword) {
      return 'Invalid email or password';
    }
    return null;
  }

  static String? validateRegister(String email, String password) {
    String? emailError = validateEmail(email);
    if (emailError != null) {
      return emailError;
    }

    String? passwordError = validatePassword(password);
    if (passwordError != null) {
      return passwordError;
    }

    return null;
  }
}
