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
          '${userCredential.user?.displayName ?? ''} Logged in successfully',
          userCredential);
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
      onSuccess('${userCredential.user?.displayName ?? ''} SignUp successfully',
          userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error", e.toString());
    }
  }

  resetPasswordWithFirebaseEmail({
    required FirebaseAuth firebaseInstance,
    required GeneralSussessCallback onSuccess,
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
      logger.e("Email Error", e.toString());
    }
  }

  updatePasswordWithFirebaseEmail({
    required FirebaseAuth firebaseInstance,
    required GeneralSussessCallback onSuccess,
    required ErrorCallback onError,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      User currentUser = FirebaseAuth.instance.currentUser!;
      String? userEmail = currentUser.email;
      AuthCredential authCredential = EmailAuthProvider.credential(
          email: userEmail!, password: oldPassword);
      UserCredential authResult =
          await currentUser.reauthenticateWithCredential(authCredential);
      if(authResult.user!=null){
      await currentUser.updatePassword(newPassword);
      onSuccess('Password updated successfully');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      onError(errorMessage);
    } catch (e) {
      logger.e("Password updating Error", e.toString());
    }
  }

  signOutFromFirebaseEmail({required FirebaseAuth firebaseInstance}) {
    firebaseInstance.signOut();
  }
}
