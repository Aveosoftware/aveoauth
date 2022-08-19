part of '../aveoauth.dart';

enum LoginMode {
  facebook,
  google,
  firebaseEmail,
  twitter,
  github,
  apple,
  intagram,
  apiEmail,
  phone,
  biometric,
  none
}

final getPreference = GetStorage();
LoginMode? _appLoginMode = getPreference.read('LoginMode') == null
    ? LoginMode.none
    : EnumToString.fromString(
        LoginMode.values, getPreference.read('LoginMode'));
  mixin CurrentLoginMode {
    get currentLoginMode => _appLoginMode;
  }
class Mode {
  get showAppLoginMode => _appLoginMode;
  set changeLoginMode(LoginMode value) {
    _appLoginMode = value;
    getPreference.write(
        'LoginMode', EnumToString.convertToString(_appLoginMode));
  }
}
