part of '../aveoauth.dart';

mixin FacebookLogin {
  signInWithFacebook(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      try {
        UserCredential userCredential =
            await firebaseInstance.signInWithCredential(facebookAuthCredential);
        Mode().changeLoginMode = LoginMode.facebook;
        onSuccess(
            '${userCredential.user?.displayName ?? ''} Logged in successfully');
      } on FirebaseAuthException catch (e) {
        String errorMessage = ExceptionHandlingHelper.handleException(e.code);
        onError(errorMessage);
        debugPrint(errorMessage);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint(loginResult.status.toString());
      debugPrint(loginResult.message);
    }
  }

  signOutFromFacebook({required FirebaseAuth firebaseInstance}) async {
    FacebookAuth.instance.logOut();
    firebaseInstance.signOut();
  }
}
