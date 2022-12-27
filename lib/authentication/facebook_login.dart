part of '../aveoauth.dart';

mixin FacebookLogin {
  signInWithFacebook(
      {required Function showLoader,
      required Function hideLoader,
      required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    try {
      showLoader();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        try {
          UserCredential userCredential = await firebaseInstance
              .signInWithCredential(facebookAuthCredential);
          Mode().changeLoginMode = LoginMode.facebook;
          hideLoader();
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMessage = ExceptionHandlingHelper.handleException(e.code);
          logger.e("Facebook Error", errorMessage);
          hideLoader();
          onError(errorMessage);
        } catch (e) {
          logger.e("Facebook Error", e.toString());
          hideLoader();
          onError('Something went wrong');
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        hideLoader();
        onError('Facebook Signup/Login cancelled');
      } else if (loginResult.status == LoginStatus.operationInProgress) {
      } else {
        logger.e("Facebook Login Message", loginResult.message);
        hideLoader();
        onError('Something went wrong');
      }
    } on PlatformException catch (e) {
      logger.e("Facebook Platform Exception", e.toString());
      hideLoader();
      onError('Something went wrong');
    } catch (e) {
      logger.e("Facebook Error", e.toString());
      hideLoader();
      onError('Something went wrong');
    }
  }

  signOutFromFacebook({required FirebaseAuth firebaseInstance}) async {
    FacebookAuth.instance.logOut();
    firebaseInstance.signOut();
  }
}
