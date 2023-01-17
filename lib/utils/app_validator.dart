import 'package:wired_social/utils/app_regex.dart';
import 'package:wired_social/utils/app_string.dart';

class AppValidator {
  String? isEmailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emailIsRequired;
    } else if (!RegexExpression.email.hasMatch(email)) {
      return AppStrings.pleaseEnterAValidEmail;
    } else {
      return null;
    }
  }

  String? isNameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return AppStrings.required;
    }
    return null;
  }

  String? isPassWordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.passwordIsRequired;
    }
    if (RegExp(r'[ ]').hasMatch(password)) {
      return AppStrings.noSpace;
    }

    if (!RegExp(r'.{6,}').hasMatch(password)) {
      return AppStrings.passwordFiveCharacters;
    }

    if (!RegexExpression.upperCaseAlphabets.hasMatch(password)) {
      return AppStrings.passwordUpperCase;
    }
    if (!RegexExpression.lowerCaseAlphabets.hasMatch(password)) {
      return AppStrings.passwordLowerCase;
    }

    if (!RegexExpression.noDigits.hasMatch(password)) {
      return AppStrings.passwordAtleastOneNumber;
    }

    if (!RegexExpression.punctuation.hasMatch(password)) {
      return AppStrings.passwordSpecialCharacter;
    }
    return null;
  }
}
