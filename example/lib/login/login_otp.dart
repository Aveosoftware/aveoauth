import 'package:aveoauth/aveoauth.dart';
import 'package:example/login/login_snackbar.dart';
import 'package:example/login/login_social_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpLoginPage extends StatelessWidget with PhoneLogin {
  final String phoneNumber;
  final String verificationID;
  OtpLoginPage(
      {Key? key, required this.phoneNumber, required this.verificationID})
      : super(key: key);
  TextEditingController otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: otpCodeController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'OTP',
                  hintText: 'OTP'),
            ),
          ),
          CustomButton(
            logoUrl: "https://img.icons8.com/ios/344/phone.png",
            text: 'Phone Login',
            onPressed: () => signInWithPhone(
                phoneNumber: phoneNumber,
                smsCode: otpCodeController.text,
                firebaseInstance: FirebaseAuth.instance,
                onSuccess: (message) {
                  snackBar(message, context);
                },
                onError: (error) {
                  snackBar(error, context);
                },
                verificationId: verificationID),
          ),
        ],
      ),
    );
  }
}
