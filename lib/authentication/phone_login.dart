part of '../aveoauth.dart';

mixin PhoneLogin {
  signInWithPhone(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String phoneNumber,
      required String smsCode}) async {
    // Trigger the authentication flow
    try {
      firebaseInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential userCredential) async {
          await firebaseInstance.signInWithCredential(userCredential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          PhoneAuthCredential userCredential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          await firebaseInstance.signInWithCredential(userCredential);
          try {
            Mode().changeLoginMode = LoginMode.phone;
            onSuccess('$phoneNumber Logged in successfully');
          } on FirebaseAuthException catch (e) {
            String errorMessage = ExceptionHandlingHelper.handleException(e.code);
            onError(errorMessage);
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  signOutFromPhone({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
