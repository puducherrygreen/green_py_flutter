class ValidationHelper {
  static bool nameValidation({required String value, String? regX}) {
    final re = RegExp(regX ?? r"^[A-Za-z\s]{2,}[A-Za-z][A-Za-z\s]*$");
    return re.hasMatch(value);
  }

  static bool mobileNumberValidation({required String value, String? regX}) {
    final re = RegExp(regX ?? r"^(?:\+91)?[6789]\d{9}$");
    return re.hasMatch(value);
  }

  static bool addressValidation({required String value, String? regX}) {
    final re = RegExp(regX ?? r"^[0-9A-Za-z\s\.,'-]+$");
    return re.hasMatch(value);
  }

  static bool pincodeValidation({required String value, String? regX}) {
    final re = RegExp(regX ?? r"^\d{6}$");
    return re.hasMatch(value);
  }

  static bool emailValidation({required String value, String? regX}) {
    final re =
        RegExp(regX ?? r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return re.hasMatch(value);
  }

  static bool passwordValidation({required String value, String? regX}) {
    final re = RegExp(regX ?? r"^.{6,}$");
    return re.hasMatch(value);
  }
}
