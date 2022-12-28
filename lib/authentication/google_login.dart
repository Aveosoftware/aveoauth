part of '../aveoauth.dart';

mixin GoogleLogin {
  signInWithGoogle(BuildContext context,
      {bool enableLoader = true,
      required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      if (enableLoader) {
        showLoader(context);
      }
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
          if (enableLoader) {
            hideLoader(context);
          }
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMeessage =
              ExceptionHandlingHelper.handleException(e.code);
          logger.e("Google Error", errorMeessage);
          if (enableLoader) {
            hideLoader(context);
          }
          onError(errorMeessage);
        }
      } else {
        if (enableLoader) {
          hideLoader(context);
        }
        onError('Google Signup/Login cancelled');
      }
    } on PlatformException catch (e) {
      logger.e("Google Platform Exception", e.toString());
      if (enableLoader) {
        hideLoader(context);
      }
      onError('Something went wrong');
    } catch (error) {
      logger.e("Google Error", error.toString());
      if (enableLoader) {
        hideLoader(context);
      }
      onError('Something went wrong');
    }
  }

  signOutFromGoogle({required FirebaseAuth firebaseInstance}) async {
    await GoogleSignIn().disconnect();
    firebaseInstance.signOut();
  }
}
