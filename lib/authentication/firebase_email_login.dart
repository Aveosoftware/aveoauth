part of '../aveoauth.dart';

mixin FirebaseEmailLogin {
  signInWithFirebaseEmail(
      {required Function showLoader,
      required Function hideLoader,
      required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String email,
      required String password}) async {
    try {
      showLoader();
      UserCredential userCredential = await firebaseInstance
          .signInWithEmailAndPassword(email: email, password: password);
      Mode().changeLoginMode = LoginMode.firebaseEmail;
      hideLoader();
      onSuccess(
          '${userCredential.user?.displayName ?? ''} Logged in successfully',
          userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      hideLoader();
      onError(errorMessage);
      (errorMessage);
    } catch (e) {
      (e.toString());
    }
  }

  signUpWithFirebaseEmail(
      {required Function showLoader,
      required Function hideLoader,
      required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String email,
      required String password}) async {
    try {
      showLoader();
      UserCredential userCredential = await firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      Mode().changeLoginMode = LoginMode.firebaseEmail;
      hideLoader();
      onSuccess('${userCredential.user?.displayName ?? ''} SignUp successfully',
          userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      hideLoader();
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error", e.toString());
    }
  }

  resetPasswordWithFirebaseEmail({
    required Function showLoader,
    required Function hideLoader,
    required FirebaseAuth firebaseInstance,
    required GeneralSussessCallback onSuccess,
    required ErrorCallback onError,
    required String email,
  }) async {
    try {
      showLoader();
      await firebaseInstance.sendPasswordResetEmail(email: email);
      hideLoader();
      onSuccess('Email sent successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      hideLoader();
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error", e.toString());
    }
  }

  updatePasswordWithFirebaseEmail({
    required Function showLoader,
    required Function hideLoader,
    required FirebaseAuth firebaseInstance,
    required GeneralSussessCallback onSuccess,
    required ErrorCallback onError,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      showLoader();
      User currentUser = FirebaseAuth.instance.currentUser!;
      String? userEmail = currentUser.email;
      AuthCredential authCredential = EmailAuthProvider.credential(
          email: userEmail!, password: oldPassword);
      UserCredential authResult =
          await currentUser.reauthenticateWithCredential(authCredential);
      if (authResult.user != null) {
        await currentUser.updatePassword(newPassword);
        hideLoader();
        onSuccess('Password updated successfully');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      hideLoader();
      onError(errorMessage);
    } catch (e) {
      logger.e("Password updating Error", e.toString());
    }
  }

  signOutFromFirebaseEmail({required FirebaseAuth firebaseInstance}) {
    firebaseInstance.signOut();
  }
}
