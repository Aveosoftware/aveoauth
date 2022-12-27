part of '../aveoauth.dart';

mixin GithubLogin {
  signInWithGithub(
      {required Function showLoader,
      required Function hideLoader,
      required FirebaseAuth firebaseInstance,
      required BuildContext context,
      required String clientId,
      required String clientSecret,
      required String redirectUrl,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      // Create a GitHubSignIn instance
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: clientId,
          clientSecret: clientSecret,
          redirectUrl: redirectUrl);

      // Trigger the sign-in flow
      final GitHubSignInResult result = await gitHubSignIn.signIn(context);
      if (result.status == GitHubSignInResultStatus.ok) {
        // Create a credential from the access token
        final githubAuthCredential =
            GithubAuthProvider.credential(result.token!);
        try {
          showLoader();
          UserCredential userCredential =
              await firebaseInstance.signInWithCredential(githubAuthCredential);
          Mode().changeLoginMode = LoginMode.github;
          hideLoader();
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMessage = ExceptionHandlingHelper.handleException(e.code);
          logger.e("Github Error", errorMessage);
          hideLoader();
          onError(errorMessage);
        }
      } else if (result.status == GitHubSignInResultStatus.cancelled) {
        logger.e("Github Login Error", result.errorMessage);
        hideLoader();
        onError('Github Signup/Login cancelled');
      } else {
        logger.e("Github Login Error", result.errorMessage);
        hideLoader();
        onError('Something went wrong');
      }
    } on PlatformException catch (e) {
      logger.e("Github Platform Exception", e.toString());
      hideLoader();
      onError('Something went wrong');
    } catch (error) {
      logger.e("Github Error", error.toString());
      hideLoader();
      onError('Something went wrong');
    }
  }

  signOutFromGithub({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
