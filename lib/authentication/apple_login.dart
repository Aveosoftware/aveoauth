part of '../aveoauth.dart';

mixin AppleLogin {
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final Random random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  signInWithApple(
      {required FirebaseAuth firebaseInstance,
      required String clientId,
      required String redirectUri,
      required SussessCallback onSuccess,
      required ErrorCallback onError}) async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final String rawNonce = generateNonce();
    final String nonce = sha256ofString(rawNonce);
    try {
      // Request credential for the currently signed in Apple account.
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
        webAuthenticationOptions: WebAuthenticationOptions(
          // clientId: "com.aveosoftware.applelogintestservice",
          clientId: clientId,
          // redirectUri: Uri.parse(
          //     "https://navy-hospitable-beast.glitch.me/callbacks/sign_in_with_apple"),
          redirectUri: Uri.parse(
              redirectUri),
        ),
      );
      logger.i("Apple Identifier Token: ${appleCredential.identityToken}");
      // Create an `OAuthCredential` from the credential returned by Apple.
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      logger.i("Apple User Credential: $credential");
      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      try {
        UserCredential userCredential =
            await firebaseInstance.signInWithCredential(credential);
        logger.i("Apple Firebase User Credential: $userCredential");
        Mode().changeLoginMode = LoginMode.apple;
        onSuccess(
            '${userCredential.user?.displayName ?? ''} Logged in successfully',userCredential);
      } on FirebaseAuthException catch (e) {
        String errorMessage = ExceptionHandlingHelper.handleException(e.code);
        logger.e("Apple Error", errorMessage);
        onError(errorMessage);
      }
    } catch (error) {
      logger.e("Apple Error", error.toString());
      onError('Something went wrong');
    }
  }

  signOutFromApple({required FirebaseAuth firebaseInstance}) async {
    await GoogleSignIn().disconnect();
    firebaseInstance.signOut();
  }
}
