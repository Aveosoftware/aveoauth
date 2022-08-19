import 'package:aveoauth/common/pubspec/pubspec_utils.dart';
import 'package:aveoauth/samples/sample.dart';
import 'package:recase/recase.dart';

class PageSample extends Sample {
  final String _viewName;
  final bool isAppleLogin;
  final bool isGoogleLogin;
  final bool isFacebookLogin;
  final bool isFirebaseEmailLogin;
  final bool isGithubLogin;
  final bool isBiometricLogin;
  final bool isPhoneLogin;
  final bool isTwitterLogin;
  final String githubClientId;
  final String githubClientSecret;
  final String githubRedirectUrl;
  final String twitterApiKey;
  final String twitterApiSecretKey;
  final String twitterRedirectURI;
  final bool isSocialLoginButtonLableEnabled;

  PageSample(
    String path,
    this._viewName, {
    required this.githubClientId,
    required this.githubClientSecret,
    required this.githubRedirectUrl,
    required this.twitterApiKey,
    required this.twitterApiSecretKey,
    required this.twitterRedirectURI,
    required this.isAppleLogin,
    required this.isGoogleLogin,
    required this.isFacebookLogin,
    required this.isFirebaseEmailLogin,
    required this.isGithubLogin,
    required this.isBiometricLogin,
    required this.isPhoneLogin,
    required this.isTwitterLogin,
    required this.isSocialLoginButtonLableEnabled,
  }) : super(path);

  String get import => '''
import 'package:flutter/material.dart';
import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_social_login_button.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_snackbar.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_otp_page.dart';
''';

  @override
  String get content => '''$import

class ${_viewName.pascalCase}Page extends StatefulWidget {
  ${_viewName.pascalCase}Page({Key? key}) : super(key: key);

  @override
  State<${_viewName.pascalCase}Page> createState() => _${_viewName.pascalCase}PageState();
}

class _${_viewName.pascalCase}PageState extends State<${_viewName.pascalCase}Page> with ${isAppleLogin ? ' AppleLogin,' : ''} ${isGoogleLogin ? ' GoogleLogin,' : ''} ${isFacebookLogin ? ' FacebookLogin,' : ''} ${isFirebaseEmailLogin ? ' FirebaseEmailLogin,' : ''} ${isGithubLogin ? ' GithubLogin,' : ''} ${isBiometricLogin ? ' BiometricLogin,' : ''} ${isPhoneLogin ? ' PhoneLogin,' : ''} ${isTwitterLogin ? ' TwitterSocialLogin,' : ''} CurrentLoginMode{
  ${isFirebaseEmailLogin ? '''TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();''' : ''}
  ${isPhoneLogin ? '''TextEditingController phoneNumberController = TextEditingController();
  String verificationID = '';''' : ''}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ${isFirebaseEmailLogin ? '''Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password'),
              ),
            ),''' : ''}
            ${isPhoneLogin ? '''Padding(
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
            ),''' : ''}
            ${isFirebaseEmailLogin ? '''CustomButton(
                logoUrl:
                    "https://img.icons8.com/ios/344/login-rounded-right--v1.png",
                text: 'Email Login',
                onPressed: () => signInWithFirebaseEmail(
                    firebaseInstance: FirebaseAuth.instance,
                    onSuccess: (message) {
                      snackBar(message, context);
                    },
                    onError: (error) {
                      snackBar(error, context);
                    },
                    email: emailController.text,
                    password: passwordController.text)),
            CustomButton(
                logoUrl: "https://img.icons8.com/ios/344/logout-rounded-up.png",
                text: 'Email Signup',
                onPressed: () => signUpWithFirebaseEmail(
                    firebaseInstance: FirebaseAuth.instance,
                    onSuccess: (message) {
                      snackBar(message, context);
                    },
                    onError: (error) {
                      snackBar(error, context);
                    },
                    email: emailController.text,
                    password: passwordController.text)),
            CustomButton(
                logoUrl: "https://img.icons8.com/ios/344/password-window.png",
                text: 'Forget Password',
                onPressed: () => resetPasswordWithFirebaseEmail(
                      firebaseInstance: FirebaseAuth.instance,
                      onSuccess: (message) {
                        snackBar(message, context);
                      },
                      onError: (error) {
                        snackBar(error, context);
                      },
                      email: emailController.text,
                    )),''' : ''}
            ${isSocialLoginButtonLableEnabled?'Column':'Row'}(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: ${isSocialLoginButtonLableEnabled?'MainAxisAlignment.center':'MainAxisAlignment.spaceAround'},
              children: <Widget>[
            ${isGoogleLogin ? '''CustomButton(
              isLabelVisible:$isSocialLoginButtonLableEnabled,
              logoUrl:
                  "https://img.icons8.com/fluency/344/google-plus-squared.png",
              text: 'Google Login',
              onPressed: () => signInWithGoogle(
                  firebaseInstance: FirebaseAuth.instance,
                  onSuccess: (message) {
                    snackBar(message, context);
                  },
                  onError: (error) {
                    snackBar(error, context);
                  }),
            ),''' : ''}
            ${isFacebookLogin ? '''CustomButton(
              isLabelVisible:$isSocialLoginButtonLableEnabled,
                logoUrl: "https://www.facebook.com/images/fb_icon_325x325.png",
                text: 'Facebook Login',
                onPressed: () => signInWithFacebook(
                    firebaseInstance: FirebaseAuth.instance,
                    onSuccess: (message) {
                      snackBar(message, context);
                    },
                    onError: (error) {
                      snackBar(error, context);
                    })),''' : ''}
            ${isAppleLogin ? '''CustomButton(
              isLabelVisible:$isSocialLoginButtonLableEnabled,
                logoUrl: "https://img.icons8.com/ios-glyphs/344/mac-os.png",
                text: 'Apple Login',
                onPressed: () {}),''' : ''}
            ${isGithubLogin ? '''CustomButton(
              isLabelVisible:$isSocialLoginButtonLableEnabled,
              logoUrl: "https://img.icons8.com/glyph-neue/344/github.png",
              text: 'Github Login',
              onPressed: () => signInWithGithub(
                  context: context,
                  clientId: '$githubClientId',
                  clientSecret: '$githubClientSecret',
                  redirectUrl: '$githubRedirectUrl',
                  firebaseInstance: FirebaseAuth.instance,
                  onSuccess: (message) {
                    snackBar(message, context);
                  },
                  onError: (error) {
                    snackBar(error, context);
                  }),
            ),''' : ''}
            ${isTwitterLogin ? '''CustomButton(
              isLabelVisible:$isSocialLoginButtonLableEnabled,
              logoUrl: "https://img.icons8.com/color/344/twitter--v1.png",
              text: 'Twitter Login',
              onPressed: () => signInWithTwitter(
                  context: context,
                  apiKey: '$twitterApiKey',
                  apiSecretKey: '$twitterApiSecretKey',
                  redirectURI: '$twitterRedirectURI',
                  firebaseInstance: FirebaseAuth.instance,
                  onSuccess: (message) {
                    snackBar(message, context);
                  },
                  onError: (error) {
                    snackBar(error, context);
                  }),
            ),''' : ''}]),
            ${isPhoneLogin ? '''CustomButton(
              logoUrl: "https://img.icons8.com/ios-filled/50/000000/approval.png",
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
            ),''' : ''}
            
            ${isBiometricLogin ? '''CustomButton(
              logoUrl:
                  "https://img.icons8.com/external-modern-lines-kalash/344/external-fingerprint-smart-technologies-modern-lines-kalash.png",
              text: 'Biometric Login',
              onPressed: () => signInWithBiometric(
                  onSuccess: (message) {
                    snackBar(message, context);
                  },
                  onError: (error) {
                    snackBar(error, context);
                  },
                  isBiometricAvailable: (status) {}),
            ),''' : ''}
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
''';
}
