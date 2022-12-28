import 'package:aveoauth/common/pubspec/pubspec_utils.dart';
import 'package:aveoauth/samples/sample.dart';
import 'package:recase/recase.dart';

class CustomOtpPageSample extends Sample {
  final String _viewName;
  CustomOtpPageSample(
    String path,
    this._viewName,
  ) : super(path);

  String get import => '''
import 'package:aveoauth/aveoauth.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_snackbar.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_social_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// TODO: Add imports
''';

  @override
  String get content => '''$import

class OtpLoginPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationID;

  const OtpLoginPage(
      {Key? key, required this.phoneNumber, required this.verificationID})
      : super(key: key);

  @override
  State<OtpLoginPage> createState() => _OtpLoginPageState();
}

class _OtpLoginPageState extends State<OtpLoginPage> with PhoneLogin {
  TextEditingController otpCodeController = TextEditingController();
  String verificationID = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    verificationID = widget.verificationID;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Text('OTP', style: TextStyle(fontSize: 25.0)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        otpCodeController.clear();
                      });
                    },
                    child: Text(
                      'Clear',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: CustomPinField(textEditingController: otpCodeController, context:context, onChanged: (v){},),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Didn't receive OTP?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {
                  verifyPhoneNumber(
                      context,
                      phoneNumber: widget.phoneNumber,
                      firebaseInstance: FirebaseAuth.instance,
                      onSuccess: (message,cred) {
                        snackBar(message, context);
                      },
                      onError: (error) {
                        snackBar(error, context);
                      },
                      codeSent: (vId, resendingToken) {
                        setState(() {
                          verificationID = vId;
                        });
                      });
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              CustomButton(
                textColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                buttonHeight: 40,
                buttonWidth: (MediaQuery.of(context).size.width) - 20.0,
                logoUrl:
                    "https://img.icons8.com/ios/344/login-rounded-right--v1.png",
                text: 'SIGN IN',
                isImageVisible: false,
                onPressed: () => signInWithPhone(
                    context,
                    phoneNumber: widget.phoneNumber,
                    smsCode: otpCodeController.text,
                    firebaseInstance: FirebaseAuth.instance,
                    onSuccess: (message,cred) {
                      // TODO: Add success logic here
                      snackBar(message, context);
                    },
                    onError: (error) {
                      snackBar(error, context);
                    },
                    verificationId: verificationID),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
''';
}
