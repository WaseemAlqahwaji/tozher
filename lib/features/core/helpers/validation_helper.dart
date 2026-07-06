class ValidationHelper {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp _strongPasswordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);
  static bool isValidStrongPassword(String password) => _strongPasswordRegex.hasMatch(password);

  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^[0-9+\s\-()]+$').hasMatch(phone);
  }

  static bool isNullOrEmpty(String? value) => value == null || value.isEmpty;
}
