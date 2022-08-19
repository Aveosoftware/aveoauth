import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'log_otp_page.dart';
import 'log_snackbar.dart';
import 'log_social_login_button.dart';

class LogPage extends StatefulWidget {
  LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage>
    with
        AppleLogin,
        GoogleLogin,
        FacebookLogin,
        FirebaseEmailLogin,
        GithubLogin,
        BiometricLogin,
        PhoneLogin,
        TwitterSocialLogin,
        CurrentLoginMode {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            ),
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
            CustomButton(
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
                    )),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomButton(
                    isLabelVisible: false,
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
                  ),
                  CustomButton(
                      isLabelVisible: false,
                      logoUrl:
                          "https://www.facebook.com/images/fb_icon_325x325.png",
                      text: 'Facebook Login',
                      onPressed: () => signInWithFacebook(
                          firebaseInstance: FirebaseAuth.instance,
                          onSuccess: (message) {
                            snackBar(message, context);
                          },
                          onError: (error) {
                            snackBar(error, context);
                          })),
                  CustomButton(
                      isLabelVisible: false,
                      logoUrl:
                          "https://img.icons8.com/ios-glyphs/344/mac-os.png",
                      text: 'Apple Login',
                      onPressed: () {}),
                  CustomButton(
                    isLabelVisible: false,
                    logoUrl: "https://img.icons8.com/glyph-neue/344/github.png",
                    text: 'Github Login',
                    onPressed: () => signInWithGithub(
                        context: context,
                        clientId: '4d6a7b20b5bf1132062f',
                        clientSecret:
                            '2b3d55678794b2301696aa391ff93dd856a0ed7e',
                        redirectUrl:
                            'https://authmelosmodule.firebaseapp.com/__/auth/handler',
                        firebaseInstance: FirebaseAuth.instance,
                        onSuccess: (message) {
                          snackBar(message, context);
                        },
                        onError: (error) {
                          snackBar(error, context);
                        }),
                  ),
                  CustomButton(
                    isLabelVisible: false,
                    logoUrl: "https://img.icons8.com/color/344/twitter--v1.png",
                    text: 'Twitter Login',
                    onPressed: () => signInWithTwitter(
                        context: context,
                        apiKey: '1US6bc6IKBeATjaumK9CBdpbJ',
                        apiSecretKey:
                            'IEsxMVndnZKtYAT8Us1xs59WcfX2IayQr3IIFYXDXbzS4rMrE6',
                        redirectURI: 'example://',
                        firebaseInstance: FirebaseAuth.instance,
                        onSuccess: (message) {
                          snackBar(message, context);
                        },
                        onError: (error) {
                          snackBar(error, context);
                        }),
                  ),
                ]),
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
