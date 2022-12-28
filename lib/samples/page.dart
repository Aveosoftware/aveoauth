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
  final String appleClientId;
  final String appleRedirectUri;
  final bool isSocialLoginButtonLableEnabled;

  PageSample(
    String path,
    this._viewName, {
    required this.appleClientId,
    required this.appleRedirectUri,
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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_social_login_button.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_snackbar.dart';
import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_text_field.dart';
${isPhoneLogin ? '''import 'package:${PubspecUtils.projectName}/$_viewName/${_viewName.snakeCase}_verify_phone.dart';''' : ''}
// TODO: Add imports
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
  TextEditingController passwordController = TextEditingController(); 
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool isSignUpMode = false;
  bool isForgetPasswordMode = false;
  ''' : ''}
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ${isFirebaseEmailLogin ? '''Row(
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
                            ${isBiometricLogin ? '''CustomButton(
                              logoUrl:
                                  "https://img.icons8.com/external-modern-lines-kalash/344/external-fingerprint-smart-technologies-modern-lines-kalash.png",
                              text: 'Biometric Login',
                              isLabelVisible: false,
                              onPressed: () => signInWithBiometric(
                                  context,
                                  onSuccess: (message) {
                                    // TODO: Add success logic here
                                    snackBar(message, context);
                                  },
                                  onError: (error) {
                                    snackBar(error, context);
                                  },
                                  isBiometricAvailable: (status) {}),
                            ),''' : ''}
                            ${isPhoneLogin ? '''CustomButton(
                                logoUrl:
                                    "https://img.icons8.com/fluency-systems-filled/48/000000/phone.png",
                                text: 'Phone Login',
                                isLabelVisible: false,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyPhone()));
                                }),''' : ''}
                          ],
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, bottom: 20.0),
                        child: Text(
                          isForgetPasswordMode
                              ? 'Enter email address to reset password'
                              : !isSignUpMode
                                  ? 'Enter your email address to signin'
                                  : 'Enter your email and password for signup',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),),
                      if (!isForgetPasswordMode)
                        if (isSignUpMode)
                          Expanded(
                          child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isSignUpMode = false;
                              });
                            },
                            child: Text(
                              'Already have account?',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),),
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
                              FocusScope.of(context).unfocus();
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
                                  context,
                                  firebaseInstance: FirebaseAuth.instance,
                                  onSuccess: (message) {
                                    snackBar(message, context);
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isForgetPasswordMode = false;
                                    });
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
                                        context,
                                        firebaseInstance: FirebaseAuth.instance,
                                        onSuccess: (message,cred) {
                                          snackBar(message, context);
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            isSignUpMode = false;
                                          });
                                          // TODO: Add success logic here
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
                                        context,
                                        firebaseInstance: FirebaseAuth.instance,
                                        onSuccess: (message, cred) {
                                          snackBar(message, context);
                                          FocusScope.of(context).unfocus();
                                          // TODO: Add success logic here
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
                        FocusScope.of(context).unfocus();
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
                                FocusScope.of(context).unfocus();
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
                  ${isGoogleLogin || isAppleLogin || isBiometricLogin || isFacebookLogin || isGithubLogin ? '''if (!isForgetPasswordMode) const Text('Or'),''' : ''}
                  if (!isForgetPasswordMode)
                    ${isSocialLoginButtonLableEnabled ? 'Column' : 'Row'}(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: ${isSocialLoginButtonLableEnabled ? 'MainAxisAlignment.center' : 'MainAxisAlignment.spaceAround'},
                      children: <Widget>[
                          ${isGoogleLogin ? '''CustomButton(
                            isLabelVisible: $isSocialLoginButtonLableEnabled,
                            logoUrl:
                                "https://img.icons8.com/color/96/000000/google-logo.png",
                            text: 'Google Login',
                            onPressed: () => signInWithGoogle(
                                context,
                                firebaseInstance: FirebaseAuth.instance,
                                onSuccess: (message, cred) {
                                  // TODO: Add success logic here
                                  snackBar(message, context);
                                },
                                onError: (error) {
                                  snackBar(error, context);
                                }),
                          ),''' : ''}
                          ${isFacebookLogin ? '''CustomButton(
                              isLabelVisible: $isSocialLoginButtonLableEnabled,
                              logoUrl:
                                  "https://www.facebook.com/images/fb_icon_325x325.png",
                              text: 'Facebook Login',
                              onPressed: () => signInWithFacebook(
                                  context,
                                  firebaseInstance: FirebaseAuth.instance,
                                  onSuccess: (message ,cred) {
                                    // TODO: Add success logic here
                                    snackBar(message, context);
                                  },
                                  onError: (error) {
                                    snackBar(error, context);
                                  })),''' : ''}
                          ${isAppleLogin ? '''
                            if (Platform.isIOS)
                            CustomButton(
                            isLabelVisible: $isSocialLoginButtonLableEnabled,
                            logoUrl:
                                "https://img.icons8.com/ios-glyphs/344/mac-os.png",
                            text: 'Apple Login',
                            onPressed: () => signInWithApple(
                                context,
                                firebaseInstance: FirebaseAuth.instance,
                                clientId:'$appleClientId',
                                redirectUri:'$appleRedirectUri',
                                onSuccess: (message, cred) {
                                  // TODO: Add success logic here
                                  snackBar(message, context);
                                },
                                onError: (error) {
                                  snackBar(error, context);
                                }),
                          ),''' : ''}
                          ${isGithubLogin ? '''CustomButton(
                            isLabelVisible: $isSocialLoginButtonLableEnabled,
                            logoUrl:
                                "https://img.icons8.com/glyph-neue/344/github.png",
                            text: 'Github Login',
                            onPressed: () => signInWithGithub(
                                context,
                                clientId: '$githubClientId',
                                clientSecret:
                                    '$githubClientSecret',
                                redirectUrl:
                                    '$githubRedirectUrl',
                                firebaseInstance: FirebaseAuth.instance,
                                onSuccess: (message,cred) {
                                  // TODO: Add success logic here
                                  snackBar(message, context);
                                },
                                onError: (error) {
                                  snackBar(error, context);
                                }),
                          ),''' : ''}
                          ${isTwitterLogin ? '''CustomButton(
                            isLabelVisible: $isSocialLoginButtonLableEnabled,
                            logoUrl:
                                "https://img.icons8.com/color/344/twitter--v1.png",
                            text: 'Twitter Login',
                            onPressed: () => signInWithTwitter(
                                context,
                                apiKey: '$twitterApiKey',
                                apiSecretKey:
                                    '$twitterApiSecretKey',
                                redirectURI: '$twitterRedirectURI',
                                firebaseInstance: FirebaseAuth.instance,
                                onSuccess: (message,cred) {
                                  // TODO: Add success logic here
                                  snackBar(message, context);
                                },
                                onError: (error) {
                                  snackBar(error, context);
                                }),
                          ),''' : ''}
                        ]),''' : ''}
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
