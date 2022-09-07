import 'package:flutter/material.dart';

import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login2_snackbar.dart';
import 'login2_social_login_button.dart';

class Login2Page extends StatefulWidget {
  Login2Page({Key? key}) : super(key: key);

  @override
  State<Login2Page> createState() => _Login2PageState();
}

class _Login2PageState extends State<Login2Page>
    with FacebookLogin, GithubLogin, BiometricLogin, CurrentLoginMode {
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
                          onSuccess: (message) {
                            snackBar(message, context);
                          },
                          onError: (error) {
                            snackBar(error, context);
                          })),
                  CustomButton(
                    isLabelVisible: false,
                    logoUrl: "https://img.icons8.com/glyph-neue/344/github.png",
                    text: 'Github Login',
                    onPressed: () => signInWithGithub(
                        context: context,
                        clientId: 'adsfg',
                        clientSecret: 'dxfgb',
                        redirectUrl: 'sdfgh',
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
