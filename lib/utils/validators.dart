part of '../aveoauth.dart';

class Validator {
  static const _urlPattern =
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9])[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$";

  static const _phoneNumberPattern = r'^([0-9\s\-\+\(\)]*)$';

  static const _alphanumericPattern = r'^[a-zA-Z0-9 &\-]+$';

  static const _alphabetPattern = '[a-zA-Z]';

  static const _capitalAlphabetPattern = '[A-Z]';

  static const _smallAlphabetPattern = '[a-z]';

  static const _postalCodePatter = '[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]';

  // static const _specialCharater = '[#@!%&*?]';

  static const _numericPattern = '[0-9]';

  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static String? emailValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    return _emailFormatValidator(value);
  }

  static String? emailOptionalValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return _emailFormatValidator(value);
  }

  static String? _emailFormatValidator(String value) {
    value = value.trim();
    if (!isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? postCodeValidator(String value) {
    if (value.isEmpty) {
      return null;
    }
    value = value.trim();
    if (!isEmail(value)) {
      return 'Please input right post code format';
    }
    return null;
  }

  static String? passwordValidator(
      {bool isConfirmPassword = false,
      bool isNewPassword = false,
      bool isOldPassword = false,
      bool isGeneralPassword = false,
      String? value,
      String? confirmPasswdText}) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      if (isOldPassword) {
        return 'Please enter your old password';
      } else if (isNewPassword) {
        return 'Please enter your new password';
      } else if (isConfirmPassword) {
        return 'Please enter your confirm password';
      } else if (isGeneralPassword) {
        return 'Please enter password';
      }
    }
    if (isConfirmPassword) {
      if (confirmPasswdText != value) {
        return 'Password does not match';
      }
    }

    final hasDigits = value!.contains(RegExp(_numericPattern));
    final hasCharacters = value.contains(RegExp(_alphabetPattern));
    final hasCapitalLetters = value.contains(RegExp(_capitalAlphabetPattern));
    final hasSmallLetters = value.contains(RegExp(_smallAlphabetPattern));
    final hasMinLength = value.length >= 6;
    if (isNewPassword || isConfirmPassword) {
      if (!hasMinLength) {
        return 'Password must be at least 6 characters';
      }
      if (!hasDigits) {
        return 'Password must contain at least one number';
      }
      if (!hasCharacters) {
        return 'Password must contain at least one letter';
      }
      if (!hasCapitalLetters) {
        return 'Password must contain at least one uppercase letter';
      }
      if (!hasSmallLetters) {
        return 'Password must contain at least one lowercase letter';
      }
    }
    return null;
  }

  static String? notEmptyValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? otpValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? nameValidator(
      {String? value, bool isFirstName = false, bool isLastName = false}) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      if (isFirstName) {
        return 'First name is required';
      }
      if (isLastName) {
        return 'Last name is required';
      }
      return 'Name is required';
    }
    return null;
  }

  static bool hasMatch(String value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static String? alphanumericNotEmptyValidator(String? value) {
    value = value?.trim();
    final trimmedValue = (value ?? '').trimLeft().trimRight();
    if (trimmedValue.isEmpty) {
      return 'Field cannot be empty';
    }
    if (!hasMatch(trimmedValue, _alphanumericPattern)) {
      return 'Please enter valid value';
    }
    return null;
  }

  static bool isNumericOnly(String s) => hasMatch(s, r'^\d+$');
  static String? amountValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter amount';
    }
    if (!isNumericOnly(value.replaceAll('.', ''))) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  static String? urlValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    if (!hasMatch(value, _urlPattern)) {
      return 'Please enter a valid url';
    }
    return null;
  }

  static String? phoneNumberFormatValidator(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please input phone number';
    }
    if (value.length < 9 || value.length > 15) {
      return 'Mobile number must be between 9 and 15 digits';
    }
    if (!hasMatch(value, _phoneNumberPattern)) {
      return 'Please input the right phone number format';
    }
    return null;
  }

  static String? customNotEmptyValidator(String? value, String? message) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}
