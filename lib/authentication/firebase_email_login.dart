part of '../aveoauth.dart';

mixin FirebaseEmailLogin {
  signInWithFirebaseEmail(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await firebaseInstance
          .signInWithEmailAndPassword(email: email, password: password);
      Mode().changeLoginMode = LoginMode.firebaseEmail;
      onSuccess(
          '${userCredential.user?.displayName ?? ''} Logged in successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      onError(errorMessage);
      (errorMessage);
    } catch (e) {
      (e.toString());
    }
  }

  signUpWithFirebaseEmail(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      Mode().changeLoginMode = LoginMode.firebaseEmail;
      onSuccess(
          '${userCredential.user?.displayName ?? ''} SignUp in successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error",e.toString());
    }
  }

  resetPasswordWithFirebaseEmail({
    required FirebaseAuth firebaseInstance,
    required SussessCallback onSuccess,
    required ErrorCallback onError,
    required String email,
  }) async {
    try {
      await firebaseInstance.sendPasswordResetEmail(email: email);
      onSuccess('Email sent successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error",e.toString());
    }
  }

  signOutFromFirebaseEmail({required FirebaseAuth firebaseInstance}) {
    firebaseInstance.signOut();
  }
}
