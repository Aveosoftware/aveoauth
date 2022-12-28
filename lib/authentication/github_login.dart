part of '../aveoauth.dart';

mixin GithubLogin {
  signInWithGithub(BuildContext context,
      {bool enableLoader = true,
      required FirebaseAuth firebaseInstance,
      required String clientId,
      required String clientSecret,
      required String redirectUrl,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // Trigger the authentication flow
    try {
      if (enableLoader) {
        showLoader(context);
      }
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
          if (enableLoader) {
            hideLoader(context);
          }
          onSuccess(
              '${userCredential.user?.displayName ?? ''} Logged in successfully',
              userCredential);
        } on FirebaseAuthException catch (e) {
          String errorMessage = ExceptionHandlingHelper.handleException(e.code);
          logger.e("Github Error", errorMessage);
          if (enableLoader) {
            hideLoader(context);
          }
          onError(errorMessage);
        }
      } else if (result.status == GitHubSignInResultStatus.cancelled) {
        logger.e("Github Login Error", result.errorMessage);
        if (enableLoader) {
          hideLoader(context);
        }
        onError('Github Signup/Login cancelled');
      } else {
        logger.e("Github Login Error", result.errorMessage);
        if (enableLoader) {
          hideLoader(context);
        }
        onError('Something went wrong');
      }
    } on PlatformException catch (e) {
      logger.e("Github Platform Exception", e.toString());
      if (enableLoader) {
        hideLoader(context);
      }
      onError('Something went wrong');
    } catch (error) {
      logger.e("Github Error", error.toString());
      if (enableLoader) {
        hideLoader(context);
      }
      onError('Something went wrong');
    }
  }

  signOutFromGithub({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
