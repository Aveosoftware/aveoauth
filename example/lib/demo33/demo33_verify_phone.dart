import 'package:flutter/material.dart';

import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'demo33_otp_page.dart';
import 'demo33_snackbar.dart';
import 'demo33_social_login_button.dart';
import 'demo33_text_field.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone>
    with PhoneLogin, CurrentLoginMode {
  TextEditingController phoneNumberController = TextEditingController();

  FocusNode phoneNumberFocusNode = FocusNode();

  String verificationID = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.0, left: 20.0, right: 20.0, bottom: 10.0),
                        child: Text('Mobile Number',
                            style: TextStyle(fontSize: 25.0)),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'We need to send OTP to authenticate your number',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                      keyboardType: TextInputType.phone,
                      fieldController: phoneNumberController,
                      onFiledSubmitted: (m) {},
                      validator: (value) =>
                          Validator.phoneNumberFormatValidator(value),
                      focusNode: phoneNumberFocusNode,
                      labelText: 'Phone Number',
                      hintText: 'Enter number with country code eg +91'),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonHeight: 40,
                      buttonWidth: (MediaQuery.of(context).size.width) - 20.0,
                      logoUrl:
                          "https://img.icons8.com/ios/344/login-rounded-right--v1.png",
                      text: 'NEXT',
                      isImageVisible: false,
                      onPressed: () => {
                            if (formKey.currentState!.validate())
                              {
                                verifyPhoneNumber(
                                    phoneNumber: phoneNumberController.text,
                                    firebaseInstance: FirebaseAuth.instance,
                                    onSuccess: (message,cred) {
                                      snackBar(message, context);
                                    },
                                    onError: (error) {
                                      snackBar(error, context);
                                    },
                                    codeSent:
                                        ((verificationId, resendingToken) => {
                                              setState(() {
                                                verificationID = verificationId;
                                              }),
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtpLoginPage(
                                                          verificationID:
                                                              verificationID,
                                                          phoneNumber:
                                                              phoneNumberController
                                                                  .text,
                                                        )),
                                              ),
                                            }))
                              }
                          }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
