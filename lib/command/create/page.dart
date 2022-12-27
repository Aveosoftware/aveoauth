import 'dart:io';

import 'package:aveoauth/command/command.dart';
import 'package:aveoauth/command/create/log_utils.dart';
import 'package:aveoauth/core/structure.dart';
import 'package:aveoauth/functions/create/create_single_file.dart';
import 'package:aveoauth/samples/otp_page.dart';
import 'package:aveoauth/samples/page.dart';
import 'package:aveoauth/samples/widget/loader.dart';
import 'package:aveoauth/samples/widget/snackbar.dart';
import 'package:aveoauth/samples/widget/social_login_button.dart';
import 'package:aveoauth/samples/widget/text_field.dart';
import 'package:aveoauth/samples/widget/verify_phone.dart';
import 'package:dcli/dcli.dart';
import 'package:recase/recase.dart';

class CreatePageCommand extends Command {
  @override
  String get commandName => 'page';

  @override
  List<String> get alias => ['-p'];

  @override
  Future<void> execute() async {
    String githubClientId = '';
    String githubClientSecret = '';
    String githubRedirectUrl = '';
    String twitterApiKey = '';
    String twitterApiSecretKey = '';
    String twitterRedirectURI = '';
    String appleClientId = '';
    String appleRedirectUri = '';

    bool isSocialLoginButtonLableEnabled = false;
    bool isAppleLogin = false;
    bool isBiometricLogin = false;
    bool isFacebookLogin = false;
    bool isFirebaseEmailLogin = true;
    bool isGithubLogin = false;
    bool isGoogleLogin = false;
    bool isPhoneLogin = false;
    bool isTwitterLogin = false;

    bool stringToBool(String value) {
      bool newValue = value == 'Y' || value == 'y' ? true : false;
      return newValue;
    }

    LogService.divider();
    echo('\n');
    // Select the type of Authentication style
    LogService.info('Select which type of Authentication you want to create ?');
    echo('1. Login Lite (Email Login + Google and Facebook Login)\n');
    echo(
        '2. Login Plus(Email Login + All Social Login + Phone and Biometric Login)\n');
    echo('3. Selective Login (Customizable)\n');
    int authenticationStyleResult = int.parse(stdin.readLineSync()!);

    if (authenticationStyleResult == 1) {
      LogService.info('Login Lite Selected');
      // Login Lite
      isAppleLogin = false;
      isBiometricLogin = false;
      isFacebookLogin = true;
      isFirebaseEmailLogin = true;
      isGithubLogin = false;
      isGoogleLogin = true;
      isPhoneLogin = false;
      isTwitterLogin = false;
      isSocialLoginButtonLableEnabled = false;
    } else if (authenticationStyleResult == 2) {
      LogService.info('Login Plus Selected');
      // Login Plus
      isAppleLogin = true;
      isBiometricLogin = true;
      isFacebookLogin = true;
      isFirebaseEmailLogin = true;
      isGithubLogin = true;
      isGoogleLogin = true;
      isPhoneLogin = true;
      isTwitterLogin = true;
      isSocialLoginButtonLableEnabled = false;

      LogService.info('Enter Apple clientId');
      appleClientId = stdin.readLineSync()!.toString();
      LogService.info('Enter Apple Redirect URL');
      appleRedirectUri = stdin.readLineSync()!.toString();
      LogService.info('Enter Github clientId');
      githubClientId = stdin.readLineSync()!.toString();
      LogService.info('Enter Github clientSecret');
      githubClientSecret = stdin.readLineSync()!.toString();
      LogService.info('Enter Github redirectUrl');
      githubRedirectUrl = stdin.readLineSync()!.toString();
      LogService.info('Enter Twitter apiKey');
      twitterApiKey = stdin.readLineSync()!.toString();
      LogService.info('Enter Twitter apiSecretKey');
      twitterApiSecretKey = stdin.readLineSync()!.toString();
      LogService.info('Enter Twitter redirectURI');
      twitterRedirectURI = stdin.readLineSync()!.toString();
    } else if (authenticationStyleResult == 3) {
      LogService.info('Custom Login Selected');

      // Selective Login
      LogService.divider();

      // Enable Apple Login
      LogService.info('Need Apple Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int appleLoginResult = int.parse(stdin.readLineSync()!);
      if (appleLoginResult == 1) {
        isAppleLogin = true;
        LogService.info('Enter Apple clientId');
        appleClientId = stdin.readLineSync()!.toString();
        LogService.info('Enter Apple Redirect URL');
        appleRedirectUri = stdin.readLineSync()!.toString();
        LogService.success('Apple Login is enabled');
      } else if (appleLoginResult == 2) {
        isAppleLogin = false;
        LogService.error('Apple Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Biometric Login
      LogService.info('Need Biometric Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int biometricLoginResult = int.parse(stdin.readLineSync()!);
      if (biometricLoginResult == 1) {
        isBiometricLogin = true;
        LogService.success('Biometric Login is enabled');
      } else if (biometricLoginResult == 2) {
        isBiometricLogin = false;
        LogService.error('Biometric Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Facebook Login
      LogService.info('Need Facebook Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int facebookLoginResult = int.parse(stdin.readLineSync()!);
      if (facebookLoginResult == 1) {
        isFacebookLogin = true;
        LogService.success('Facebook Login is enabled');
      } else if (facebookLoginResult == 2) {
        isFacebookLogin = false;
        LogService.error('Facebook Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Firebase Email Login
      LogService.info('Need Firebase Email Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int firebaseEmailLoginResult = int.parse(stdin.readLineSync()!);
      if (firebaseEmailLoginResult == 1) {
        isFirebaseEmailLogin = true;
        LogService.success('Firebase Email Login is enabled');
      } else if (firebaseEmailLoginResult == 2) {
        isFirebaseEmailLogin = false;
        LogService.error('Firebase Email Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Github Login
      LogService.info('Need Github Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int githubLoginResult = int.parse(stdin.readLineSync()!);
      if (githubLoginResult == 1) {
        isGithubLogin = true;
        LogService.info('Enter Github clientId');
        githubClientId = stdin.readLineSync()!.toString();
        LogService.info('Enter Github clientSecret');
        githubClientSecret = stdin.readLineSync()!.toString();
        LogService.info('Enter Github redirectUrl');
        githubRedirectUrl = stdin.readLineSync()!.toString();
        LogService.success('Github Login is enabled');
      } else if (githubLoginResult == 2) {
        isGithubLogin = false;
        LogService.error('Github Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Google Login
      LogService.info('Need Google Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int googleLoginResult = int.parse(stdin.readLineSync()!);
      if (googleLoginResult == 1) {
        isGoogleLogin = true;
        LogService.success('Google Login is enabled');
      } else if (googleLoginResult == 2) {
        isGoogleLogin = false;
        LogService.error('Google Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Phone Login
      LogService.info('Need Phone Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int phoneLoginResult = int.parse(stdin.readLineSync()!);
      if (phoneLoginResult == 1) {
        isPhoneLogin = true;
        LogService.success('Phone Login is enabled');
      } else if (phoneLoginResult == 2) {
        isPhoneLogin = false;
        LogService.error('Phone Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Twitter Login
      LogService.info('Need Twitter Login ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int twitterLoginResult = int.parse(stdin.readLineSync()!);
      if (twitterLoginResult == 1) {
        isTwitterLogin = true;
        LogService.info('Enter Twitter apiKey');
        twitterApiKey = stdin.readLineSync()!.toString();
        LogService.info('Enter Twitter apiSecretKey');
        twitterApiSecretKey = stdin.readLineSync()!.toString();
        LogService.info('Enter Twitter redirectURI');
        twitterRedirectURI = stdin.readLineSync()!.toString();
        LogService.success('Twitter Login is enabled');
      } else if (twitterLoginResult == 2) {
        isTwitterLogin = false;
        LogService.error('Twitter Login is disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();

      // Enable Label for social login button
      LogService.info('Need label enabled Social Login Buttons ?');
      echo('1. Yes\n');
      echo('2. No\n');
      int socialLoginButtonLableEnabledResult =
          int.parse(stdin.readLineSync()!);
      if (socialLoginButtonLableEnabledResult == 1) {
        isSocialLoginButtonLableEnabled = true;
        LogService.success('Social Login Buttons label enabled');
      } else if (socialLoginButtonLableEnabledResult == 2) {
        isSocialLoginButtonLableEnabled = false;
        LogService.error('Social Login Buttons label disabled');
      } else {
        LogService.error('Invalid selection');
      }
      LogService.divider();
    } else {
      LogService.error('Invalid selection\n');
    }

    var fileModel =
        Structure.model(name, 'page', true, on: onCommand, folderName: name);
    var pathSplit = Structure.safeSplitPath(fileModel.path!);
    pathSplit.removeLast();
    var path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    Directory(path).createSync(recursive: true);
    final socialLoginButtonDir = path;
    Directory(socialLoginButtonDir).createSync(recursive: true);
    final textFieldDir = path;
    Directory(textFieldDir).createSync(recursive: true);
    final verifyPhoneDir = path;
    Directory(verifyPhoneDir).createSync(recursive: true);
    final otpPageDir = path;
    Directory(otpPageDir).createSync(recursive: true);
    final snackbarDir = path;
    Directory(snackbarDir).createSync(recursive: true);
    var extraFolder = true;

    handleFileCreate(
      name,
      'page',
      path,
      extraFolder,
      PageSample(
        '',
        name,
        appleClientId: appleClientId,
        appleRedirectUri: appleRedirectUri,
        isAppleLogin: isAppleLogin,
        isBiometricLogin: isBiometricLogin,
        isFacebookLogin: isFacebookLogin,
        isFirebaseEmailLogin: isFirebaseEmailLogin,
        isGithubLogin: isGithubLogin,
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubRedirectUrl: githubRedirectUrl,
        isGoogleLogin: isGoogleLogin,
        isPhoneLogin: isPhoneLogin,
        isTwitterLogin: isTwitterLogin,
        twitterApiKey: twitterApiKey,
        twitterApiSecretKey: twitterApiSecretKey,
        twitterRedirectURI: twitterRedirectURI,
        isSocialLoginButtonLableEnabled: isSocialLoginButtonLableEnabled,
      ),
      null,
    );

    handleFileCreate(
      name,
      'social_login_button',
      socialLoginButtonDir,
      extraFolder,
      CustomLoginButtonSample(
        '',
      ),
      null,
    );

    handleFileCreate(
      name,
      'snackbar',
      snackbarDir,
      extraFolder,
      CustomSnackBarSample(
        '',
      ),
      null,
    );

    handleFileCreate(
      name,
      'loader',
      snackbarDir,
      extraFolder,
      CustomLoaderSample(
        '',
      ),
      null,
    );

    handleFileCreate(
      name,
      'text_field',
      textFieldDir,
      extraFolder,
      CustomTextField(
        '',
      ),
      null,
    );

    if (isPhoneLogin) {
      handleFileCreate(
        name,
        'verify_phone',
        verifyPhoneDir,
        extraFolder,
        VerifyPhone(
          '',
          name,
        ),
        null,
      );

      handleFileCreate(
        name,
        'otp_page',
        otpPageDir,
        extraFolder,
        CustomOtpPageSample(
          '',
          name,
        ),
        null,
      );
    }
    echo('\n');
    LogService.success('${name.pascalCase} created successfully\n');
    LogService.divider();
  }
}
