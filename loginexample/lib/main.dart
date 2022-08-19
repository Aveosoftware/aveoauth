import 'package:aveoauth/aveoauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginexample/login/login_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Example',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Authentication Example',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with
        FirebaseEmailLogin,
        GoogleLogin,
        GithubLogin,
        FacebookLogin,
        TwitterSocialLogin,
        PhoneLogin,
        BiometricLogin,
        AppleLogin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();
  snackBar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: LoginPage(),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 15),
      //   child: TextField(
      //     keyboardType: TextInputType.emailAddress,
      //     controller: emailController,
      //     decoration: const InputDecoration(
      //         border: OutlineInputBorder(),
      //         labelText: 'Email',
      //         hintText: 'Email'),
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //       left: 15.0, right: 15.0, top: 15, bottom: 0),
      //   child: TextField(
      //     controller: passwordController,
      //     obscureText: true,
      //     decoration: const InputDecoration(
      //         border: OutlineInputBorder(),
      //         labelText: 'Password',
      //         hintText: 'Password'),
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //       left: 15.0, right: 15.0, top: 15, bottom: 0),
      //   child: TextField(
      //     keyboardType: TextInputType.phone,
      //     controller: phoneNumberController,
      //     decoration: const InputDecoration(
      //         border: OutlineInputBorder(),
      //         labelText: 'Phone Number',
      //         hintText: 'Phone Number'),
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //       left: 15.0, right: 15.0, top: 15, bottom: 0),
      //   child: TextField(
      //     keyboardType: TextInputType.number,
      //     controller: otpCodeController,
      //     decoration: const InputDecoration(
      //         border: OutlineInputBorder(),
      //         labelText: 'OTP',
      //         hintText: 'OTP'),
      //   ),
      // ),
      // TextButton(
      //     child: const Text('Get Current Login'),
      //     onPressed: () =>
      //         debugPrint(Mode().showAppLoginMode.toString())),
      // CustomButton(
      //     logoUrl:
      //         "https://img.icons8.com/ios/344/login-rounded-right--v1.png",
      //     text: 'Email Login',
      //     onPressed: () => signInWithFirebaseEmail(
      //         firebaseInstance: FirebaseAuth.instance,
      //         onSuccess: (message) {
      //           snackBar(message);
      //         },
      //         onError: (error) {
      //           snackBar(error);
      //         },
      //         email: emailController.text,
      //         password: passwordController.text)),
      // CustomButton(
      //     logoUrl: "https://img.icons8.com/ios/344/logout-rounded-up.png",
      //     text: 'Email Signup',
      //     onPressed: () => signUpWithFirebaseEmail(
      //         firebaseInstance: FirebaseAuth.instance,
      //         onSuccess: (message) {
      //           snackBar(message);
      //         },
      //         onError: (error) {
      //           snackBar(error);
      //         },
      //         email: emailController.text,
      //         password: passwordController.text)),
      // CustomButton(
      //     logoUrl: "https://img.icons8.com/ios/344/password-window.png",
      //     text: 'Forget Password',
      //     onPressed: () {}),
      // CustomButton(
      //   logoUrl:
      //       "https://img.icons8.com/fluency/344/google-plus-squared.png",
      //   text: 'Google Login',
      //   onPressed: () => signInWithGoogle(
      //       firebaseInstance: FirebaseAuth.instance,
      //       onSuccess: (message) {
      //         snackBar(message);
      //       },
      //       onError: (error) {
      //         snackBar(error);
      //       }),
      // ),
      // CustomButton(
      //     logoUrl: "https://www.facebook.com/images/fb_icon_325x325.png",
      //     text: 'Facebook Login',
      //     onPressed: () => signInWithFacebook(
      //         firebaseInstance: FirebaseAuth.instance,
      //         onSuccess: (message) {
      //           snackBar(message);
      //         },
      //         onError: (error) {
      //           snackBar(error);
      //         })),
      // CustomButton(
      //     logoUrl: "https://img.icons8.com/ios-glyphs/344/mac-os.png",
      //     text: 'Apple Login',
      //     isLabelVisble: false,
      //     onPressed: () => signInWithApple(
      //         context: context,
      //         firebaseInstance: FirebaseAuth.instance,
      //         onSuccess: (message) {
      //           snackBar(message);
      //         },
      //         onError: (error) {
      //           snackBar(error);
      //         })),
      // CustomButton(
      //   logoUrl: "https://img.icons8.com/glyph-neue/344/github.png",
      //   text: 'Github Login',
      //   onPressed: () => signInWithGithub(
      //       context: context,
      //       clientId: '4d6a7b20b5bf1132062f',
      //       clientSecret: '2b3d55678794b2301696aa391ff93dd856a0ed7e',
      //       redirectUrl:
      //           'https://authmelosmodule.firebaseapp.com/__/auth/handler',
      //       firebaseInstance: FirebaseAuth.instance,
      //       onSuccess: (message) {
      //         snackBar(message);
      //       },
      //       onError: (error) {
      //         snackBar(error);
      //       }),
      // ),
      // CustomButton(
      //   logoUrl: "https://img.icons8.com/color/344/twitter--v1.png",
      //   text: 'Twitter Login',
      //   onPressed: () => signInWithTwitter(
      //       context: context,
      //       apiKey: '1US6bc6IKBeATjaumK9CBdpbJ',
      //       apiSecretKey:
      //           'IEsxMVndnZKtYAT8Us1xs59WcfX2IayQr3IIFYXDXbzS4rMrE6',
      //       redirectURI: 'example://',
      //       firebaseInstance: FirebaseAuth.instance,
      //       onSuccess: (message) {
      //         snackBar(message);
      //       },
      //       onError: (error) {
      //         log("Login Error: $error");
      //         snackBar(error);
      //       }),
      // ),
      // CustomButton(
      //   logoUrl: "https://img.icons8.com/ios/344/phone.png",
      //   text: 'Phone Login',
      //   onPressed: () => signInWithPhone(
      //       phoneNumber: phoneNumberController.text,
      //       smsCode: otpCodeController.text,
      //       firebaseInstance: FirebaseAuth.instance,
      //       onSuccess: (message) {
      //         snackBar(message);
      //       },
      //       onError: (error) {
      //         snackBar(error);
      //       }),
      // ),
      // TextButton(
      //     child: const Text('Get Avialabe Biometric Option'),
      //     onPressed: () => getBiometrics()),
      // CustomButton(
      //   logoUrl:
      //       "https://img.icons8.com/external-modern-lines-kalash/344/external-fingerprint-smart-technologies-modern-lines-kalash.png",
      //   text: 'Biometric Login',
      //   onPressed: () => signInWithBiometric(
      //       onSuccess: (message) {
      //         snackBar(message);
      //       },
      //       onError: (error) {
      //         snackBar(error);
      //       },
      //       isBiometricAvailable: (status) {}),
      // ),
      // CustomButton(
      //     logoUrl:
      //         "https://img.icons8.com/ios/344/logout-rounded-left.png",
      //     text: 'Logout',
      //     onPressed: () {
      //       LogoutHelper helper = LogoutHelper();
      //       helper.logout(
      //           firebaseInstance: FirebaseAuth.instance,
      //           onError: (error) {
      //             snackBar(error);
      //           },
      //           onSuccess: (message) {
      //             snackBar(message);
      //           });
      //     }),
      //     LoginPage()
      //   ],
      // ),
      // ),
    );
  }
}
