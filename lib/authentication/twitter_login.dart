part of '../aveoauth.dart';

mixin TwitterSocialLogin {
  signInWithTwitter(BuildContext context,
      {bool enableLoader = true,
      required FirebaseAuth firebaseInstance,
      required String apiKey,
      required String apiSecretKey,
      required String redirectURI,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      if (enableLoader) {
        showLoader(context);
      }
      // Create a TwitterSignIn instance
      final TwitterLogin twitterLogin = TwitterLogin(
        apiKey: apiKey,
        apiSecretKey: apiSecretKey,
        redirectURI: redirectURI,
      );

      // Trigger the sign-in flow
      final AuthResult result = await twitterLogin.loginV2();
      if (result.status == TwitterLoginStatus.loggedIn) {
        // Create a credential from the access token
        final twitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: result.authToken!,
          secret: result.authTokenSecret!,
        );

        try {
          UserCredential userCredential = await firebaseInstance
              .signInWithCredential(twitterAuthCredential);
          Mode().changeLoginMode = LoginMode.twitter;
          if (enableLoader) {
            hideLoader(context);
          }
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMessage = ExceptionHandlingHelper.handleException(e.code);
          if (enableLoader) {
            hideLoader(context);
          }
          onError(errorMessage);
        }
      } else if (result.status == TwitterLoginStatus.cancelledByUser) {
        logger.e("Twitter Login Error", result.errorMessage);
        if (enableLoader) {
          hideLoader(context);
        }
        onError('Twitter Signup/Login cancelled');
      } else {
        logger.e("Twitter Login Error", result.errorMessage);
        if (enableLoader) {
          hideLoader(context);
        }
        onError('Something went wrong');
      }
    } catch (error) {
      logger.e("Twitter Error", error.toString());
    }
  }

  signOutFromTwitter({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
