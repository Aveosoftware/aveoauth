import 'package:aveoauth/aveoauth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('Email', () {
      test('Email Empty Validation', () {
        expect(Validator.emailValidator(''), 'Please enter an email address');
      });
      test('Email Format Validation', () {
        expect(Validator.emailValidator('vinitkarkeracom'),
            'Please enter a valid email address');
      });
      test('Email Validation', () {
        expect(Validator.emailValidator('vinit@karkera.com'), null);
      });
    });
    group('Phone', () {
      test('Phone Empty Validation', () {
        expect(Validator.phoneNumberFormatValidator(''),
            'Please input phone number');
      });
      test('Phone Length Validation', () {
        expect(Validator.phoneNumberFormatValidator('+9179898989000000'),
            'Mobile number must be between 9 and 15 digits');
      });
      test('Phone Format Validation', () {
        expect(Validator.phoneNumberFormatValidator('adbhsjklh`'),
            'Please input the right phone number format');
      });
      test('Phone Validation', () {
        expect(Validator.phoneNumberFormatValidator('+918329585097'), null);
      });
    });
    group('Password', () {
      test('Old Password Validation', () {
        expect(Validator.passwordValidator(isOldPassword: true, value: ''),
            'Please enter your old password');
      });
      test('New Password Validation', () {
        expect(Validator.passwordValidator(isNewPassword: true, value: ''),
            'Please enter your new password');
      });
      test('Confirm Password Validation', () {
        expect(Validator.passwordValidator(isConfirmPassword: true, value: ''),
            'Please enter your confirm password');
      });
      test('General Password Validation', () {
        expect(Validator.passwordValidator(isGeneralPassword: true, value: ''),
            'Please enter password');
      });
      test('Match Password Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: 'vinit@911998',
                value: 'vinit@1998'),
            'Password does not match');
      });
      test('Password Length Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: 'v@19',
                value: 'v@19'),
            'Password must be at least 6 characters');
      });
      test('Password containing number Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: 'vinit@karkera',
                value: 'vinit@karkera'),
            'Password must contain at least one number');
      });
      test('Password containing one letter Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: '1111@1234569',
                value: '1111@1234569'),
            'Password must contain at least one letter');
      });
      test('Password containing one uppercase letter Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: 'vinit@1234569',
                value: 'vinit@1234569'),
            'Password must contain at least one uppercase letter');
      });
      test('Password containing one lowercase letter Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: 'VINIT@1234569',
                value: 'VINIT@1234569'),
            'Password must contain at least one lowercase letter');
      });
      test('Password Validation', () {
        expect(
            Validator.passwordValidator(
                isConfirmPassword: true,
                confirmPasswdText: 'Vinit@1234569',
                value: 'Vinit@1234569'),
            null);
      });
    });
    group('OTP', () {
      test('OTP Empty field Validation', () {
        expect(Validator.otpValidator(''), 'This field is required');
      });
      test('OTP Validation', () {
        expect(Validator.otpValidator('234868'), null);
      });
    });
  });
}
