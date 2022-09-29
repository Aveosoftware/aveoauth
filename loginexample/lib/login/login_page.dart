import 'package:flutter/material.dart';

import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_social_login_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with
        AppleLogin,
        FacebookLogin,
        GithubLogin,
        TwitterSocialLogin,
        CurrentLoginMode {
  snackBar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomButton(
                      isLabelVisible: false,
                      logoUrl:
                          "https://www.facebook.com/images/fb_icon_325x325.png",
                      text: 'Facebook Login',
                      onPressed: () => signInWithFacebook(
                          firebaseInstance: FirebaseAuth.instance,
                          onSuccess: (message,cred) {
                            snackBar(message);
                          },
                          onError: (error) {
                            snackBar(error);
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
                        onSuccess: (message,cred) {
                          snackBar(message);
                        },
                        onError: (error) {
                          snackBar(error);
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
                        onSuccess: (message,cred) {
                          snackBar(message);
                        },
                        onError: (error) {
                          snackBar(error);
                        }),
                  ),
                ]),
            CustomButton(
                logoUrl:
                    "https://img.icons8.com/ios/344/logout-rounded-left.png",
                text: 'Logout',
                onPressed: () {
                  LogoutHelper helper = LogoutHelper();
                  helper.logout(
                      firebaseInstance: FirebaseAuth.instance,
                      onError: (error) {
                        snackBar(error);
                      },
                      onSuccess: (message) {
                        snackBar(message);
                      });
                }),
          ],
        ),
      ),
    );
  }
}
