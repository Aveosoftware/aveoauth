part of '../aveoauth.dart';

mixin FirebaseEmailLogin {
  signInWithFirebaseEmail(BuildContext context,
      {bool enableLoader = true,
      required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String email,
      required String password}) async {
    try {
      if (enableLoader) {
        showLoader(context);
      }
      UserCredential userCredential = await firebaseInstance
          .signInWithEmailAndPassword(email: email, password: password);
      Mode().changeLoginMode = LoginMode.firebaseEmail;
      if (enableLoader) {
        hideLoader(context);
      }
      onSuccess(
          '${userCredential.user?.displayName ?? ''} Logged in successfully',
          userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      if (enableLoader) {
        hideLoader(context);
      }
      onError(errorMessage);
      (errorMessage);
    } catch (e) {
      (e.toString());
    }
  }

  signUpWithFirebaseEmail(BuildContext context,
      {bool enableLoader = true,
      required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String email,
      required String password}) async {
    try {
      if (enableLoader) {
        showLoader(context);
      }
      UserCredential userCredential = await firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      Mode().changeLoginMode = LoginMode.firebaseEmail;
      if (enableLoader) {
        hideLoader(context);
      }
      onSuccess('${userCredential.user?.displayName ?? ''} SignUp successfully',
          userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      if (enableLoader) {
        hideLoader(context);
      }
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error", e.toString());
    }
  }

  resetPasswordWithFirebaseEmail(
    BuildContext context, {
    bool enableLoader = true,
    required FirebaseAuth firebaseInstance,
    required GeneralSussessCallback onSuccess,
    required ErrorCallback onError,
    required String email,
  }) async {
    try {
      if (enableLoader) {
        showLoader(context);
      }
      await firebaseInstance.sendPasswordResetEmail(email: email);
      if (enableLoader) {
        hideLoader(context);
      }
      onSuccess('Email sent successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      if (enableLoader) {
        hideLoader(context);
      }
      onError(errorMessage);
    } catch (e) {
      logger.e("Email Error", e.toString());
    }
  }

  updatePasswordWithFirebaseEmail(
    BuildContext context, {
    bool enableLoader = true,
    required FirebaseAuth firebaseInstance,
    required GeneralSussessCallback onSuccess,
    required ErrorCallback onError,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      if (enableLoader) {
        showLoader(context);
      }
      User currentUser = FirebaseAuth.instance.currentUser!;
      String? userEmail = currentUser.email;
      AuthCredential authCredential = EmailAuthProvider.credential(
          email: userEmail!, password: oldPassword);
      UserCredential authResult =
          await currentUser.reauthenticateWithCredential(authCredential);
      if (authResult.user != null) {
        await currentUser.updatePassword(newPassword);
        if (enableLoader) {
          hideLoader(context);
        }
        onSuccess('Password updated successfully');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = ExceptionHandlingHelper.handleException(e.code);
      if (enableLoader) {
        hideLoader(context);
      }
      onError(errorMessage);
    } catch (e) {
      logger.e("Password updating Error", e.toString());
    }
  }

  signOutFromFirebaseEmail({required FirebaseAuth firebaseInstance}) {
    firebaseInstance.signOut();
  }
}
