part of '../aveoauth.dart';

mixin GoogleLogin {
  signInWithGoogle(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        try {
          UserCredential userCredential =
              await firebaseInstance.signInWithCredential(credential);
          Mode().changeLoginMode = LoginMode.google;
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMeessage =
              ExceptionHandlingHelper.handleException(e.code);
          logger.e("Google Error", errorMeessage);
          onError(errorMeessage);
        }
      } else {
        onError('Google Signup/Login cancelled');
      }
    } on PlatformException catch (e) {
      logger.e("Google Platform Exception", e.toString());
      onError('Something went wrong');
    } catch (error) {
      logger.e("Google Error", error.toString());
      onError('Something went wrong');
    }
  }

  signOutFromGoogle({required FirebaseAuth firebaseInstance}) async {
    await GoogleSignIn().disconnect();
    firebaseInstance.signOut();
  }
}
