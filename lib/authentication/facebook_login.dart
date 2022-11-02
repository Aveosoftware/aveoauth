part of '../aveoauth.dart';

mixin FacebookLogin {
  signInWithFacebook(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        try {
          UserCredential userCredential = await firebaseInstance
              .signInWithCredential(facebookAuthCredential);
          Mode().changeLoginMode = LoginMode.facebook;
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMessage = ExceptionHandlingHelper.handleException(e.code);
          logger.e("Facebook Error", errorMessage);
          onError(errorMessage);
        } catch (e) {
          logger.e("Facebook Error", e.toString());
          onError('Something went wrong');
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        onError('Facebook Signup/Login cancelled');
      } else if (loginResult.status == LoginStatus.operationInProgress) {
      } else {
        logger.e("Facebook Login Message", loginResult.message);
        onError('Something went wrong');
      }
    } on PlatformException catch (e) {
      logger.e("Facebook Platform Exception", e.toString());
      onError('Something went wrong');
    } catch (e) {
      logger.e("Facebook Error", e.toString());
      onError('Something went wrong');
    }
  }

  signOutFromFacebook({required FirebaseAuth firebaseInstance}) async {
    FacebookAuth.instance.logOut();
    firebaseInstance.signOut();
  }
}
