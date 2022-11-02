part of '../aveoauth.dart';

mixin GithubLogin {
  signInWithGithub(
      {required FirebaseAuth firebaseInstance,
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
          UserCredential userCredential =
              await firebaseInstance.signInWithCredential(githubAuthCredential);
          Mode().changeLoginMode = LoginMode.github;
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMessage = ExceptionHandlingHelper.handleException(e.code);
          logger.e("Github Error", errorMessage);
          onError(errorMessage);
        }
      } else if(result.status == GitHubSignInResultStatus.cancelled) {
        logger.e("Github Login Error", result.errorMessage);
        onError('Github Signup/Login cancelled');
      } else{
        logger.e("Github Login Error", result.errorMessage);
        onError('Something went wrong');
      }
    } on PlatformException catch (e) {
      logger.e("Github Platform Exception", e.toString());
      onError('Something went wrong');
    } catch (error) {
      logger.e("Github Error", error.toString());
      onError('Something went wrong');
    }
  }

  signOutFromGithub({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
