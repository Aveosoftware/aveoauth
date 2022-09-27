import 'package:aveoauth/aveoauth.dart';
import 'package:example/log/log_text_field.dart';
import 'package:example/log/log_verify_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSignUpMode = false;
  bool isForgetPasswordMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 20.0, right: 20.0, bottom: 10.0),
                        child: Text(
                            isForgetPasswordMode
                                ? 'Reset Password'
                                : isSignUpMode
                                    ? 'Create Account'
                                    : 'Welcome',
                            style: const TextStyle(fontSize: 25.0)),
                      ),
                      if (!isForgetPasswordMode)
                        Row(
                          children: [
                            CustomButton(
                              logoUrl:
                                  "https://img.icons8.com/external-modern-lines-kalash/344/external-fingerprint-smart-technologies-modern-lines-kalash.png",
                              text: 'Biometric Login',
                              isLabelVisible: false,
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
                                    "https://img.icons8.com/fluency-systems-filled/48/000000/phone.png",
                                text: 'Phone Login',
                                isLabelVisible: false,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyPhone()));
                                }),
                          ],
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, bottom: 20.0),
                        child: Text(
                          isForgetPasswordMode
                              ? 'Enter email address to reset password'
                              : isSignUpMode
                                  ? 'Enter your email address to signin'
                                  : 'Enter your email and password for signup',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      if (!isForgetPasswordMode)
                        if (isSignUpMode)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isSignUpMode = false;
                              });
                            },
                            child: Text(
                              'Already have account?',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          )
                    ],
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    fieldController: emailController,
                    onFiledSubmitted: (m) {},
                    focusNode: emailFocusNode,
                    labelText: 'Email',
                    hintText: 'Enter Email address',
                    validator: (value) => Validator.emailValidator(value),
                  ),
                  if (!isForgetPasswordMode)
                    CustomTextField(
                      fieldController: passwordController,
                      obscureText: true,
                      onFiledSubmitted: (m) {},
                      focusNode: passwordFocusNode,
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      validator: (value) => isSignUpMode
                          ? Validator.passwordValidator(
                              isNewPassword: true, value: value)
                          : Validator.passwordValidator(
                              isGeneralPassword: true, value: value),
                    ),
                  if (!isForgetPasswordMode)
                    Visibility(
                      visible: isSignUpMode,
                      child: CustomTextField(
                        fieldController: confirmPasswordController,
                        obscureText: true,
                        onFiledSubmitted: (m) {},
                        focusNode: confirmPasswordFocusNode,
                        labelText: 'Confirm Password',
                        hintText: 'Enter Confirm Password',
                        validator: (value) => Validator.passwordValidator(
                            isConfirmPassword: true,
                            value: value,
                            confirmPasswdText: passwordController.text),
                      ),
                    ),
                  if (!isForgetPasswordMode)
                    Visibility(
                      visible: !isSignUpMode,
                      replacement: const SizedBox(height: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isForgetPasswordMode = true;
                              });
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          )
                        ],
                      ),
                    ),
                  CustomButton(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    buttonHeight: 40,
                    buttonWidth: (MediaQuery.of(context).size.width) - 20.0,
                    logoUrl:
                        "https://img.icons8.com/ios/344/login-rounded-right--v1.png",
                    text: isForgetPasswordMode
                        ? 'RESET'
                        : isSignUpMode
                            ? 'SIGN UP'
                            : 'SIGN IN',
                    isImageVisible: false,
                    onPressed: () => isForgetPasswordMode
                        ? {
                            if (formKey.currentState!.validate())
                              {
                                resetPasswordWithFirebaseEmail(
                                  firebaseInstance: FirebaseAuth.instance,
                                  onSuccess: (message) {
                                    snackBar(message, context);
                                  },
                                  onError: (error) {
                                    snackBar(error, context);
                                  },
                                  email: emailController.text,
                                )
                              }
                          }
                        : isSignUpMode
                            ? {
                                if (formKey.currentState!.validate())
                                  {
                                    signUpWithFirebaseEmail(
                                        firebaseInstance: FirebaseAuth.instance,
                                        onSuccess: (message) {
                                          snackBar(message, context);
                                        },
                                        onError: (error) {
                                          snackBar(error, context);
                                        },
                                        email: emailController.text,
                                        password: passwordController.text)
                                  }
                              }
                            : {
                                if (formKey.currentState!.validate())
                                  {
                                    signInWithFirebaseEmail(
                                        firebaseInstance: FirebaseAuth.instance,
                                        onSuccess: (message) {
                                          snackBar(message, context);
                                        },
                                        onError: (error) {
                                          snackBar(error, context);
                                        },
                                        email: emailController.text,
                                        password: passwordController.text)
                                  }
                              },
                  ),
                  if (isForgetPasswordMode)
                    TextButton(
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      onPressed: () => setState(() {
                        isForgetPasswordMode = false;
                      }),
                    ),
                  if (!isForgetPasswordMode)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: isSignUpMode ? 15.0 : 0.0,
                                vertical: isSignUpMode ? 15.0 : 0.0),
                            child: Text(
                              isSignUpMode
                                  ? "By Signing up you agree to our Terms & Conditions and Privacy Policy."
                                  : "Don't have account?",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        if (!isSignUpMode)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isSignUpMode = true;
                                });
                              },
                              child: Text(
                                'Create new account.',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          )
                      ],
                    ),
                  if (!isForgetPasswordMode) const Text('Or'),
                  if (!isForgetPasswordMode)
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
                            logoUrl:
                                "https://img.icons8.com/glyph-neue/344/github.png",
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
                            logoUrl:
                                "https://img.icons8.com/color/344/twitter--v1.png",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
