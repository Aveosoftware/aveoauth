import 'dart:io';

import 'package:aveoauth/command/command.dart';
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
    bool stringToBool(String value) {
      bool newValue = value == 'Y' || value == 'y' ? true : false;
      return newValue;
    }

    String isAppleLogin =
        ask('Apple Login (Y/N)', defaultValue: 'N', required: true);
    if (isAppleLogin.toUpperCase() == 'Y') {
      echo('Apple Login is enabled\n\n');
    } else if (isAppleLogin.toUpperCase() == 'N') {
      echo('Apple Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }

    String isBiometricLogin =
        ask('Biometric Login (Y/N)', defaultValue: 'N', required: true);
    if (isBiometricLogin.toUpperCase() == 'Y') {
      echo('Biometric Login is enabled\n\n');
    } else if (isBiometricLogin.toUpperCase() == 'N') {
      echo('Biometric Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }

    String isFacebookLogin =
        ask('Facebook Login (Y/N)', defaultValue: 'N', required: true);
    if (isFacebookLogin.toUpperCase() == 'Y') {
      echo('Facebook Login is enabled\n\n');
    } else if (isFacebookLogin.toUpperCase() == 'N') {
      echo('Facebook Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }

    String isFirebaseEmailLogin =
        ask('Firebase Email Login (Y/N)', defaultValue: 'Y', required: true);
    if (isFirebaseEmailLogin.toUpperCase() == 'Y') {
      echo('Firebase Email Login is enabled\n\n');
    } else if (isFirebaseEmailLogin.toUpperCase() == 'N') {
      echo('Firebase Email Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }
    String githubClientId = '';
    String githubClientSecret = '';
    String githubRedirectUrl = '';
    String isGithubLogin =
        ask('Github Login (Y/N)', defaultValue: 'N', required: true);
    if (isGithubLogin.toUpperCase() == 'Y') {
      githubClientId = ask('Enter clientId', defaultValue: '', required: true);
      githubClientSecret =
          ask('Enter clientSecret', defaultValue: '', required: true);
      githubRedirectUrl =
          ask('Enter redirectUrl', defaultValue: '', required: true);
      echo('Github Login is enabled\n\n');
    } else if (isGithubLogin.toUpperCase() == 'N') {
      echo('Github Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }

    String isGoogleLogin =
        ask('Google Login (Y/N)', defaultValue: 'N', required: true);
    if (isGoogleLogin.toUpperCase() == 'Y') {
      echo('Google Login is enabled\n\n');
    } else if (isGoogleLogin.toUpperCase() == 'N') {
      echo('Google Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }

    String isPhoneLogin =
        ask('Phone Login (Y/N)', defaultValue: 'N', required: true);
    if (isPhoneLogin.toUpperCase() == 'Y') {
      echo('Phone Login is enabled\n\n');
    } else if (isPhoneLogin.toUpperCase() == 'N') {
      echo('Phone Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }
    String twitterApiKey = '';
    String twitterApiSecretKey = '';
    String twitterRedirectURI = '';
    String isTwitterLogin =
        ask('Twitter Login (Y/N)', defaultValue: 'N', required: true);
    if (isTwitterLogin.toUpperCase() == 'Y') {
      twitterApiKey = ask('Enter apiKey', defaultValue: '', required: true);
      twitterApiSecretKey =
          ask('Enter apiSecretKey', defaultValue: '', required: true);
      twitterRedirectURI =
          ask('Enter redirectURI', defaultValue: '', required: true);
      echo('Twitter Login is enabled\n\n');
    } else if (isTwitterLogin.toUpperCase() == 'N') {
      echo('Twitter Login is disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
    }

    String isSocialLoginButtonLableEnabled = ask(
        'Label enables Social Login Buttons (Y/N)',
        defaultValue: 'N',
        required: true);
    if (isSocialLoginButtonLableEnabled.toUpperCase() == 'Y') {
      echo('Social Login Buttons label enabled\n\n');
    } else if (isSocialLoginButtonLableEnabled.toUpperCase() == 'N') {
      echo('Social Login Buttons label disabled\n\n');
    } else {
      echo('Invalid entry\n\n');
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
        isAppleLogin: stringToBool(isAppleLogin),
        isBiometricLogin: stringToBool(isBiometricLogin),
        isFacebookLogin: stringToBool(isFacebookLogin),
        isFirebaseEmailLogin: stringToBool(isFirebaseEmailLogin),
        isGithubLogin: stringToBool(isGithubLogin),
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubRedirectUrl: githubRedirectUrl,
        isGoogleLogin: stringToBool(isGoogleLogin),
        isPhoneLogin: stringToBool(isPhoneLogin),
        isTwitterLogin: stringToBool(isTwitterLogin),
        twitterApiKey: twitterApiKey,
        twitterApiSecretKey: twitterApiSecretKey,
        twitterRedirectURI: twitterRedirectURI,
        isSocialLoginButtonLableEnabled:
            stringToBool(isSocialLoginButtonLableEnabled),
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

    if (stringToBool(isPhoneLogin)) {
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

    echo('${name.pascalCase} page created successfully\n\n');
  }
}
