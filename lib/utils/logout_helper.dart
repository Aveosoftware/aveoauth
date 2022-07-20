part of '../aveoauth.dart';

class LogoutHelper
    with
        GoogleLogin,
        FacebookLogin,
        TwitterSocialLogin,
        GithubLogin,
        AppleLogin,
        PhoneLogin,
        BiometricLogin,
        FirebaseEmailLogin {
  Future<void> logout(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    try {
      switch (Mode().showAppLoginMode) {
        case LoginMode.google:
          signOutFromGoogle(firebaseInstance: firebaseInstance);
          break;
        case LoginMode.facebook:
          signOutFromFacebook(firebaseInstance: firebaseInstance);
          break;
        case LoginMode.firebaseEmail:
          signOutFromFirebaseEmail(firebaseInstance: firebaseInstance);
          break;
        case LoginMode.apiEmail:
          break;
        case LoginMode.twitter:
          signOutFromTwitter(firebaseInstance: firebaseInstance);
          break;
        case LoginMode.github:
          signOutFromGithub(firebaseInstance: firebaseInstance);
          break;
        case LoginMode.apple:
          break;
        case LoginMode.intagram:
          break;
        case LoginMode.phone:
          break;
        case LoginMode.biometric:
          break;
        case LoginMode.none:
          break;
      }
      onSuccess('Logged out successfully');
      Mode().changeLoginMode = LoginMode.none;
    } catch (error) {
      onError(error.toString());
    }
  }
}
