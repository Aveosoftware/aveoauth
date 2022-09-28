part of '../aveoauth.dart';

mixin BiometricLogin {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      logger.e("Biometric Platform Exception", e.toString());
      return false;
    } catch (e) {
      logger.e("Biometric Error", e.toString());
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      List<BiometricType> temp = await _auth.getAvailableBiometrics();
      for (int i = 0; i < temp.length; i++) {
        logger.i('Available Biometrics: ${temp[i]}');
      }
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      logger.e("Biometric Platform Exception", e.toString());
      return <BiometricType>[];
    } catch (e) {
      logger.e("Biometric Error", e.toString());
      return <BiometricType>[];
    }
  }

  signInWithBiometric(
      {required GeneralSussessCallback onSuccess,
      required ErrorCallback onError,
      required AuthCallback isBiometricAvailable}) async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      isBiometricAvailable(false);
    } else {
      isBiometricAvailable(true);
    }

    try {
      await _auth.authenticate(
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
        localizedReason: 'Scan Fingerprint to Authenticate',
      );
      Mode().changeLoginMode = LoginMode.biometric;
      onSuccess('Logged in successfully');
    } on PlatformException catch (e) {
      onError(e.message ?? 'Error while logging in');
      logger.e("Biometric Platform Exception", e.toString());
    } catch (e) {
      logger.e("Biometric Error", e.toString());
    }
  }
}
