part of '../aveoauth.dart';

typedef PhoneCodeSent = void Function(
  String verificationId,
  int? forceResendingToken,
);
mixin PhoneLogin {
  verifyPhoneNumber(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String phoneNumber,
      required PhoneCodeSent codeSent}) async {
    try {
      await firebaseInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential userCredential) async {
          await firebaseInstance
              .signInWithCredential(userCredential)
              .then((value) => {onSuccess('Opt sent successfully')});
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(e.message ?? 'Phone number verification failed');
          if (e.code == 'invalid-phone-number') {
            logger.e("Phone Login Error",'The provided phone number is not valid.');
          }
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } catch (error) {
      onError(e.toString());
      logger.e("Phone Login Error",error.toString());
    }
  }

  signInWithPhone(
      {required FirebaseAuth firebaseInstance,
      required SussessCallback onSuccess,
      required ErrorCallback onError,
      required String smsCode,
      required String phoneNumber,
      required String verificationId}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    // Trigger the authentication flow
    try {
      await firebaseInstance.signInWithCredential(credential).then((value) => {
            onSuccess('$phoneNumber Logged in successfully'),
            Mode().changeLoginMode = LoginMode.phone,
          });
    } catch (e) {
      onError(e.toString());
      logger.e("Phone Login Error",e.toString());
    }
  }

  signOutFromPhone({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
