class RegexExpression {
  static RegExp emailOrPhone = RegExp(r'\w+@\w+\.\w+|(^[0-9]{0,10}$)');
  static RegExp upperCaseAlphabets = RegExp(r'[A-Z]');
  static RegExp lowerCaseAlphabets = RegExp(r'[a-z]');
  static RegExp noDigits = RegExp(r'[0-9]');
  static RegExp phoneNo = RegExp(r'^[1-9][0-9]');
  static RegExp email =
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

  static RegExp punctuation = RegExp(r'[!@#\$&*~-]');
  static RegExp specialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
}
