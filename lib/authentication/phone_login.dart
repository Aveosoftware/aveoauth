part of '../aveoauth.dart';

typedef PhoneCodeSent = void Function(
  String verificationId,
  int? forceResendingToken,
);
mixin PhoneLogin {
  verifyPhoneNumber(
      {required Function showLoader,
      required Function hideLoader,
      required FirebaseAuth firebaseInstance,
      required PhoneSussessCallback onSuccess,
      required ErrorCallback onError,
      required String phoneNumber,
      required PhoneCodeSent codeSent}) async {
    try {
      showLoader();
      await firebaseInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential userCredential) async {
          await firebaseInstance.signInWithCredential(userCredential).then(
              (value) => {
                    hideLoader(),
                    onSuccess('Opt sent successfully', userCredential)
                  });
        },
        verificationFailed: (FirebaseAuthException e) {
          hideLoader();
          onError(e.message ?? 'Phone number verification failed');
          if (e.code == 'invalid-phone-number') {
            logger.e(
                "Phone Login Error", 'The provided phone number is not valid.');
          }
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } catch (error) {
      hideLoader();
      onError(e.toString());
      logger.e("Phone Login Error", error.toString());
    }
  }

  signInWithPhone(
      {required Function showLoader,
      required Function hideLoader,
      required FirebaseAuth firebaseInstance,
      required PhoneSussessCallback onSuccess,
      required ErrorCallback onError,
      required String smsCode,
      required String phoneNumber,
      required String verificationId}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    // Trigger the authentication flow
    try {
      showLoader();
      await firebaseInstance.signInWithCredential(credential).then((value) => {
            hideLoader(),
            onSuccess('$phoneNumber Logged in successfully', credential),
            Mode().changeLoginMode = LoginMode.phone,
          });
    } catch (e) {
      hideLoader();
      onError(e.toString());
      logger.e("Phone Login Error", e.toString());
    }
  }

  signOutFromPhone({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
