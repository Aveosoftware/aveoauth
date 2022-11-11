import 'dart:io';

import 'package:aveoauth/command/command.dart';
import 'package:aveoauth/command/create/log_utils.dart';
import 'package:aveoauth/command/create/menu.dart';
import 'package:aveoauth/core/structure.dart';
import 'package:aveoauth/functions/create/create_single_file.dart';
import 'package:aveoauth/samples/otp_page.dart';
import 'package:aveoauth/samples/page.dart';
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
    echo("Enter number");
    int? n1 = int.parse(stdin.readLineSync()!);
    // Select the type of Authentication style
    Menu authenticationStyle = Menu([
      'Login Lite (Email Login + Google and Facebook Login)',
      'Login Plus(Email Login + All Social Login + Phone and Biometric Login)',
      'Selective Login (Customizable)',
    ], title: 'Select which type of Authentication you want to create ?');
    final Answer authenticationStyleResult = authenticationStyle.choose();

    if (authenticationStyleResult.index == 0) {
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
    } else if (authenticationStyleResult.index == 1) {
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

      appleClientId =
          ask('Enter Apple clientId', defaultValue: '', required: true);
      appleRedirectUri =
          ask('Enter Apple Redirect URL', defaultValue: '', required: true);
      githubClientId =
          ask('Enter Github clientId', defaultValue: '', required: true);
      githubClientSecret =
          ask('Enter Github clientSecret', defaultValue: '', required: true);
      githubRedirectUrl =
          ask('Enter Github redirectUrl', defaultValue: '', required: true);
      twitterApiKey =
          ask('Enter Twitter apiKey', defaultValue: '', required: true);
      twitterApiSecretKey =
          ask('Enter Twitter apiSecretKey', defaultValue: '', required: true);
      twitterRedirectURI =
          ask('Enter Twitter redirectURI', defaultValue: '', required: true);
    } else {
      LogService.info('Custom Login Selected');
      // Selective Login
      LogService.divider();

      // Enable Apple Login
      Menu appleLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Apple Login ?');
      final appleLoginResult = appleLogin.choose();

      if (appleLoginResult.index == 0) {
        isAppleLogin = true;
        appleClientId =
            ask('Enter Apple clientId', defaultValue: '', required: true);
        appleRedirectUri =
            ask('Enter Apple Redirect URL', defaultValue: '', required: true);
        LogService.success('Apple Login is enabled\n\n');
      } else {
        isAppleLogin = false;
        LogService.error('Apple Login is enabled\n\n');
      }
      LogService.divider();

      // Enable Biometric Login
      Menu biometricLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Biometric Login ?');
      final biometricLoginResult = biometricLogin.choose();

      if (biometricLoginResult.index == 0) {
        isBiometricLogin = true;
        LogService.success('Biometric Login is enabled\n\n');
      } else {
        isBiometricLogin = false;
        LogService.error('Biometric Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Facebook Login
      Menu facebookLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Facebook Login ?');
      final facebookLoginResult = facebookLogin.choose();

      if (facebookLoginResult.index == 0) {
        isFacebookLogin = true;
        LogService.success('Facebook Login is enabled\n\n');
      } else {
        isFacebookLogin = false;
        LogService.error('Facebook Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Firebase Email Login
      Menu firebaseEmailLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Firebase Email Login ?');
      final firebaseEmailLoginResult = firebaseEmailLogin.choose();

      if (firebaseEmailLoginResult.index == 0) {
        isFirebaseEmailLogin = true;
        LogService.success('Firebase Email Login is enabled\n\n');
      } else {
        isFirebaseEmailLogin = false;
        LogService.error('Firebase Email Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Github Login
      Menu githubLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Github Login ?');
      final githubLoginResult = githubLogin.choose();

      if (githubLoginResult.index == 0) {
        isGithubLogin = true;
        githubClientId =
            ask('Enter Github clientId', defaultValue: '', required: true);
        githubClientSecret =
            ask('Enter Github clientSecret', defaultValue: '', required: true);
        githubRedirectUrl =
            ask('Enter Github redirectUrl', defaultValue: '', required: true);
        LogService.success('Github Login is enabled\n\n');
      } else {
        isGithubLogin = false;
        LogService.error('Github Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Google Login
      Menu googleLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Google Login ?');
      final googleLoginResult = googleLogin.choose();

      if (googleLoginResult.index == 0) {
        isGoogleLogin = true;
        LogService.success('Google Login is enabled\n\n');
      } else {
        isGoogleLogin = false;
        LogService.error('Google Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Phone Login
      Menu phoneLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Phone Login ?');
      final phoneLoginResult = phoneLogin.choose();

      if (phoneLoginResult.index == 0) {
        isPhoneLogin = true;
        LogService.success('Phone Login is enabled\n\n');
      } else {
        isPhoneLogin = false;
        LogService.error('Phone Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Twitter Login
      Menu twitterLogin = Menu([
        'Yes',
        'No',
      ], title: 'Need Twitter Login ?');
      final twitterLoginResult = twitterLogin.choose();

      if (twitterLoginResult.index == 0) {
        isTwitterLogin = true;
        twitterApiKey =
            ask('Enter Twitter apiKey', defaultValue: '', required: true);
        twitterApiSecretKey =
            ask('Enter Twitter apiSecretKey', defaultValue: '', required: true);
        twitterRedirectURI =
            ask('Enter Twitter redirectURI', defaultValue: '', required: true);
        LogService.success('Twitter Login is enabled\n\n');
      } else {
        isTwitterLogin = false;
        LogService.error('Twitter Login is disabled\n\n');
      }
      LogService.divider();

      // Enable Label for social login button
      Menu socialLoginButtonLableEnabled = Menu([
        'Yes',
        'No',
      ], title: 'Need label enabled Social Login Buttons ?');
      final socialLoginButtonLableEnabledResult =
          socialLoginButtonLableEnabled.choose();

      if (socialLoginButtonLableEnabledResult.index == 0) {
        isSocialLoginButtonLableEnabled = true;
        LogService.success('Social Login Buttons label enabled\n\n');
      } else {
        isSocialLoginButtonLableEnabled = false;
        LogService.error('Social Login Buttons label disabled\n\n');
      }
      LogService.divider();
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
