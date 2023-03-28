import 'package:bloc_structure/core/app_constants.dart';
import 'package:bloc_structure/core/app_string.dart';

mixin Validator {
  String? emptyValidate(String value, String key) =>
      (value.isEmpty) ? '$key $mustNotBeEmpty' : null;

  String? validateName(String value, String key) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return '$key $mustNotBeEmpty';
    } else if (!regExp.hasMatch(value)) {
      return '$key $containsCharacters';
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return '$mobile $mustNotBeEmpty';
    } else if (value.length != mobileMaxLength) {
      return '$mobile $mustBe $mobileMaxLength $digits.';
    } else if (!regExp.hasMatch(value)) {
      return validMobile;
    }
    return null;
  }

  String? validatePostCode(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return '$pinCode $mustNotBeEmpty';
    } else if (value.length != postCodeMaxLength) {
      return '$pinCode $mustBe $postCodeMaxLength $digits.';
    } else if (!regExp.hasMatch(value)) {
      return validPinCode;
    }
    return null;
  }

  String? validateOTP(String value) {
    if (value.isEmpty) {
      return '$otp $mustNotBeEmpty';
    } else if (value.length != otpMaxLength) {
      return '$otp $mustBe $otpMaxLength $digits.';
    }
    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return '$email $mustNotBeEmpty';
    } else if (!regExp.hasMatch(value)) {
      return validEmail;
    }
    return null;
  }

  String? validatePassword(String? value) => (value?.isEmpty ?? true)
      ? '$password $mustNotBeEmpty'
      : (value!.length < passwordMaxLength)
          ? '$password $validPasswordLength $passwordMaxLength.'
          : null;

  String? confirmPasswordValidate(String newPassword, String confirmPassword, String key) {
    if (confirmPassword.isEmpty) {
      return '$key $mustNotBeEmpty';
    } else if (newPassword.trim().compareTo(confirmPassword.trim()) != 0) {
      return passwordNotMatched;
    }
    return null;
  }
}
