part of '../aveoauth.dart';

typedef PhoneCodeSent = void Function(
  String verificationId,
  int? forceResendingToken,
);
mixin PhoneLogin {
  verifyPhoneNumber(BuildContext context,
      {bool enableLoader = true,
      required FirebaseAuth firebaseInstance,
      required PhoneSussessCallback onSuccess,
      required ErrorCallback onError,
      required String phoneNumber,
      required PhoneCodeSent codeSent}) async {
    try {
      if (enableLoader) {
        showLoader(context);
      }
      await firebaseInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential userCredential) async {
          await firebaseInstance
              .signInWithCredential(userCredential)
              .then((value) => {
                    if (enableLoader)
                      {
                        hideLoader(context),
                      },
                    onSuccess('Opt sent successfully', userCredential)
                  });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (enableLoader) {
            hideLoader(context);
          }
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
      if (enableLoader) {
        hideLoader(context);
      }
      onError(e.toString());
      logger.e("Phone Login Error", error.toString());
    }
  }

  signInWithPhone(BuildContext context,
      {bool enableLoader = true,
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
      if (enableLoader) {
        showLoader(context);
      }
      await firebaseInstance.signInWithCredential(credential).then((value) => {
            if (enableLoader) {hideLoader(context)},
            onSuccess('$phoneNumber Logged in successfully', credential),
            Mode().changeLoginMode = LoginMode.phone,
          });
    } catch (e) {
      if (enableLoader) {
        hideLoader(context);
      }
      onError(e.toString());
      logger.e("Phone Login Error", e.toString());
    }
  }

  signOutFromPhone({required FirebaseAuth firebaseInstance}) async {
    firebaseInstance.signOut();
  }
}
