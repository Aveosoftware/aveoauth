part of '../aveoauth.dart';

mixin TwitterSocialLogin {
  signInWithTwitter(
      {required FirebaseAuth firebaseInstance,
      required BuildContext context,
      required String apiKey,
      required String apiSecretKey,
      required String redirectURI,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      // Create a TwitterSignIn instance
      final TwitterLogin twitterLogin = TwitterLogin(
        apiKey: apiKey,
        apiSecretKey: apiSecretKey,
        redirectURI: redirectURI,
      );

      // Trigger the sign-in flow
      final result = await twitterLogin.loginV2();

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: result.authToken!,
        secret: result.authTokenSecret!,
      );
      debugPrint(result.authToken);
      try {
        UserCredential userCredential =
            await firebaseInstance.signInWithCredential(twitterAuthCredential);
        Mode().changeLoginMode = LoginMode.twitter;
        onSuccess(
            '${userCredential.user?.displayName ?? ''} Logged in successfully');
      } on FirebaseAuthException catch (e) {
        debugPrint(e.message);
        String errorMessage = ExceptionHandlingHelper.handleException(e.code);
        onError(errorMessage);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  signOutFromTwitter({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
