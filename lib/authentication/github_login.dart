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
      final result = await gitHubSignIn.signIn(context);

      // Create a credential from the access token
      final githubAuthCredential = GithubAuthProvider.credential(result.token!);
      try {
        UserCredential userCredential =
            await firebaseInstance.signInWithCredential(githubAuthCredential);
        Mode().changeLoginMode = LoginMode.github;
        onSuccess(
            '${userCredential.user?.displayName ?? ''} Logged in successfully');
      } on FirebaseAuthException catch (e) {
        String errorMessage = ExceptionHandlingHelper.handleException(e.code);
        onError(errorMessage);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  signOutFromGithub({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
