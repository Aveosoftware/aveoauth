import 'package:aveoauth/aveoauth.dart';
import 'package:example/login/login_otp.dart';
import 'package:example/login/login_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with PhoneLogin, CurrentLoginMode {
  TextEditingController phoneNumberController = TextEditingController();
  String verificationID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Phone Number'),
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[]),
            CustomButton(
              logoUrl:
                  "https://img.icons8.com/ios-filled/50/000000/approval.png",
              text: 'Verify phone',
              onPressed: () => verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  firebaseInstance: FirebaseAuth.instance,
                  onSuccess: (message) {
                    snackBar(message, context);
                  },
                  onError: (error) {
                    snackBar(error, context);
                  },
                  codeSent: ((verificationId, resendingToken) => {
                        setState(() {
                          verificationID = verificationId;
                        }),
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OtpLoginPage(
                                    verificationID: verificationID,
                                    phoneNumber: phoneNumberController.text,
                                  )),
                        )
                      })),
            ),
            CustomButton(
                logoUrl:
                    "https://img.icons8.com/ios/344/logout-rounded-left.png",
                text: 'Logout',
                onPressed: () {
                  LogoutHelper helper = LogoutHelper();
                  helper.logout(
                      firebaseInstance: FirebaseAuth.instance,
                      onError: (error) {
                        snackBar(error, context);
                      },
                      onSuccess: (message) {
                        snackBar(message, context);
                      });
                }),
          ],
        ),
      ),
    );
  }
}
