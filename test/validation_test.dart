import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class ValidationTestMixin with Validator {}

void main() {
  late ValidationTestMixin validationMixin;

  setUpAll(() {
    validationMixin = ValidationTestMixin();
  });

  group('Email Validation', () {
    test('correct email verification', () {
      String? result = validationMixin.validateEmail('abc@gmail.com');
      expect(result, isNull);
    });
    test('Incorrect email verification', () {
      String? result = validationMixin.validateEmail('abc');
      expect(result, isNotNull);
    });
    test('Empty email verification', () {
      String? result = validationMixin.validateEmail('');
      expect(result, isNotNull);
    });
    test('Empty email verification Blank space', () {
      String? result = validationMixin.validateEmail('   ');
      expect(result, isNotNull);
    });
    test('Empty email verification Blank space : Above ', () {
      String? result = validationMixin.validateEmail(' abc@gmail.com');
      expect(result, isNull);
    });
    test('Empty email verification Blank space : Below ', () {
      String? result = validationMixin.validateEmail('abc@gmail.com ');
      expect(result, isNull);
    });
    test('Empty email verification Blank space : Above-Below ', () {
      String? result = validationMixin.validateEmail(' abc@gmail.com ');
      expect(result, isNull);
    });
  });

  group('Password Validation', () {
    test('Valid password verification', () {
      String? result = validationMixin.validatePassword('Admin@1234');
      expect(result, isNull);
    });
    test('Empty password verification', () {
      String? result = validationMixin.validatePassword('');
      expect(result, isNotNull);
    });
    test('Empty password verification black space', () {
      String? result = validationMixin.validatePassword('    ');
      expect(result, isNotNull);
    });
  });

  group('Firstname Validation', () {
    test('Valid Firstname verification', () {
      String? result = validationMixin.validateName('John', firstName);
      expect(result, isNull);
    });
    test('Invalid Firstname verification', () {
      String? result = validationMixin.validateName('1234', firstName);
      expect(result, isNotNull);
    });
    test('Empty Firstname verification', () {
      String? result = validationMixin.validateName('', firstName);
      expect(result, isNotNull);
    });
    test('Empty Firstname verification', () {
      String? result = validationMixin.validateName('   ', firstName);
      expect(result, isNotNull);
    });
  });

  group('Lastname Validation', () {
    test('Valid Lastname verification', () {
      String? result = validationMixin.validateName('Doe', lastName);
      expect(result, isNull);
    });
    test('Invalid Lastname verification', () {
      String? result = validationMixin.validateName('Advert1234', lastName);
      expect(result, isNotNull);
    });
    test('Empty Lastname verification', () {
      String? result = validationMixin.validateName('', lastName);
      expect(result, isNotNull);
    });
    test('Empty Lastname verification blank space', () {
      String? result = validationMixin.validateName('  ', lastName);
      expect(result, isNotNull);
    });
  });

  group('Mobile Validation', () {
    test('Valid Mobile verification', () {
      String? result = validationMixin.validateMobile('7698914697');
      expect(result, isNull);
    });
    test('Invalid Mobile verification', () {
      String? result = validationMixin.validateMobile('324dsfdf89');
      expect(result, isNotNull);
    });
    test('Invalid Mobile verification Trim behind', () {
      String? result = validationMixin.validateMobile('7698914697 ');
      expect(result, isNull);
    });
    test('Invalid Mobile verification : blank space', () {
      String? result = validationMixin.validateMobile(' ');
      expect(result, isNotNull);
    });
    test('Invalid Mobile verification : blank space with length', () {
      String? result = validationMixin.validateMobile('76989146  ');
      expect(result, isNotNull);
    });
    test('Valid Mobile Length verification', () {
      String? result = validationMixin.validateMobile('7676909116');
      expect(result, isNull);
    });
    test('Invalid Mobile Length verification', () {
      String? result = validationMixin.validateMobile('12345678');
      expect(result, isNotNull);
      String? lengthExceedResult =
          validationMixin.validateMobile('12345678123456781234567812345678');
      expect(lengthExceedResult, isNotNull);
    });
    test('Empty Mobile verification', () {
      String? result = validationMixin.validateMobile('');
      expect(result, isNotNull);
    });
  });

  group('Confirm Password Validation', () {
    test('Valid Confirm Password verification', () {
      String? result =
          validationMixin.confirmPasswordValidate('Admin@123', 'Admin@123', confirmPassword);
      expect(result, isNull);
    });
    test('Invalid Confirm Password verification', () {
      String? result =
          validationMixin.confirmPasswordValidate('Admin@123', 'Admin@1234', confirmPassword);
      expect(result, isNotNull);
    });
    test('Empty Confirm Password verification', () {
      String? result = validationMixin.confirmPasswordValidate('Admin@123', '', confirmPassword);
      expect(result, isNotNull);
    });
  });

  group('OTP Validation', () {
    test('Valid OTP verification', () {
      String? result = validationMixin.validateOTP('123456');
      expect(result, isNull);
    });
    test('InValid OTP verification', () {
      String? result = validationMixin.validateOTP('12345');
      expect(result, isNotNull);
    });
    test('Invalid OTP verification', () {
      String? result = validationMixin.validateOTP('Admin@123');
      expect(result, isNotNull);
    });
    test('Empty OTP verification', () {
      String? result = validationMixin.validateOTP('');
      expect(result, isNotNull);
    });
    test('Empty OTP verification', () {
      String? result = validationMixin.validateOTP('  ');
      expect(result, isNotNull);
    });
  });
}
