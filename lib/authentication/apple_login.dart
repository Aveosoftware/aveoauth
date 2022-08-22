part of '../aveoauth.dart';

mixin AppleLogin {
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  signInWithApple(
      {required FirebaseAuth firebaseInstance,
      required BuildContext context,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
        webAuthenticationOptions: WebAuthenticationOptions(
        clientId: "com.aveosoftware.exampleservice",
        redirectUri: Uri.parse(
            "https://authmelosmodule2.firebaseapp.com/__/auth/handler"),),
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      try {
        UserCredential userCredential =
            await firebaseInstance.signInWithCredential(credential);
        Mode().changeLoginMode = LoginMode.apple;
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

  signOutFromApple({required FirebaseAuth firebaseInstance}) async {
    await GoogleSignIn().disconnect();
    firebaseInstance.signOut();
  }
}
