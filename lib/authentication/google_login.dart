part of '../aveoauth.dart';

mixin GoogleLogin {
  signInWithGoogle(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      try {
        UserCredential userCredential =
            await firebaseInstance.signInWithCredential(credential);
        Mode().changeLoginMode = LoginMode.google;
        onSuccess(
            '${userCredential.user?.displayName ?? ''} Logged in successfully',
            userCredential);
      } on FirebaseAuthException catch (e) {
        String errorMeessage = ExceptionHandlingHelper.handleException(e.code);
        onError(errorMeessage);
      }
    } on PlatformException catch (e) {
      logger.e("Google Platform Exception", e.toString());
      return false;
    } catch (error) {
      logger.e("Google Error", error.toString());
    }
  }

  signOutFromGoogle({required FirebaseAuth firebaseInstance}) async {
    await GoogleSignIn().disconnect();
    firebaseInstance.signOut();
  }
}
