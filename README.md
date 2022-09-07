# Authentication

Apple login is been implemented but not ready for use.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |

| :----: | :-----: | :-: | :---: | :-: | :---: | :-----: |

| Login from | &check; | &check; | &cross; | &cross; | &cross; | &cross; |

## Configration

Generate and Add SHA key to Firebase

For Debug mode:

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

For Release mode:

```bash
keytool -list -v -keystore {keystore_name} -alias {alias_name}
```

## Usage

To use this plugin, add `auth` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

Import package in your flutter application

```dart
import 'package:aveoauth/aveoauth.dart';
```

### General utility

- You can use below method to get the authentication type

```dart
TextButton(
  child: const Text('Get Current Login'),
  onPressed: () => debugPrint(Mode().showAppLoginMode.toString())),
```

# Google Login

## Configuration for Google Login for Android

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- Add dependency in **android/app/src/build.grid**

```dart
dependencies {
	implementation 'com.android.support:multidex:1.0.3'
	}
defaultConfig {
	multiDexEnabled true
	}
```
## Configuration for Google Login for IOS
- Make sure the file you downloaded file is named `GoogleService-Info.plist`.
- Move or copy `GoogleService-Info.plist` into the [my_project]/ios/Runner directory.
- Open `Xcode`, then right-click on Runner directory and select Add Files to `"Runner"`.
- Select `GoogleService-Info.plist` from the file manager.
- A dialog will show up and ask you to select the targets, select the Runner target.
- In `ios/Runner/Base.Iproj/Info.plist` add below
```plist
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
		</array>
	</dict>
</array>
```
## Usage

```dart
class  _MyWidget  extends StatelessWidget with  GoogleLogin {
@override
Widget  build(BuildContext  context) {
	return  Column(children: [
              TextButton(
                onPressed: () => signInWithGoogle(
                    firebaseInstance: FirebaseAuth.instance,
                    onSuccess: (message) {},
                    onError: (error) {}),
                child: const Text(
                  'Google Login',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextButton(
                onPressed: () =>
                    signOutFromGoogle(firebaseInstance: FirebaseAuth.instance),
                child: const Text(
                  'Google Logout',
                  style: TextStyle(color: Colors.black54),
                ),
              )
            ]);
    }
```

# Github Login

## Configuration for Github Login

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- While adding provider (`Github`) -> copy redirectUrl
- Register new [OAuth](https://github.com/settings/applications/new) application adding the `redirectUrl` and Register Application
- Copy `Client ID` and `Client Secret` into Firebase Console and Enable and Save it.
- Add dependency in **android/app/src/build.grid**

```dart
defaultConfig {
	minSdkVersion 19
	}
```

## Usage

```dart
class  _MyWidget  extends StatelessWidget with  GithubLogin {
@override
Widget  build(BuildContext  context) {
	return Column(children: [
              TextButton(
                  onPressed: () => signInWithGithub(
                      context: context,
                      clientId: [YOUR_CLIENTID],
                      clientSecret: [YOUR_CLIENTSECRET_KEY],
                      redirectUrl:
                          'https://yourproject.firebaseapp.com/__/auth/handler',
                      firebaseInstance: FirebaseAuth.instance,
                      onSuccess: (message) {},
                      onError: (error) {}),
                  child: const Text(
                    'Github Login',
                    style: TextStyle(color: Colors.black54),
                  )),
              TextButton(
                onPressed: () =>
                    signOutFromGithub(firebaseInstance: FirebaseAuth.instance),
                child: const Text(
                  'Github Logout',
                  style: TextStyle(color: Colors.black54),
                ),
              )
            ]);
}
```
# Apple Login

## Configuration for Apple Login

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- While adding provider (`Apple`) -> copy redirectUrl 
### Register an App ID

If you don't have one yet, create a [App ID](https://developer.apple.com/account/resources/identifiers/list/bundleId) following these steps:

- Click `"Register an App ID"`
- In the wizard select `"App IDs"`, click `"Continue"`
- Set the `Description` and `Bundle ID`, and select the `Sign In with Apple` capability
  - Usually the default setting of `"Enable as a primary App ID"` should suffice here. If you ship multiple apps that should all share the same `Apple ID` credentials for your users, please consult the Apple documentation on how to best set these up.
- Click `"Continue"`, and then click `"Register"` to finish the creation of the App ID

In case you already have an existing `App ID` that you want to use with Sign in with Apple:

- Open that `App ID` from the list
- Check the `"Sign in with Apple"` capability
- Click `"Save"`

If you have change your app's capabilities, you need to fetch the `updated provisioning profiles` (for example via `Xcode`) to use the `new capabilities`.
### Create a Service ID

The `Service ID` is only needed for a Web or Android integration. If you only intend to integrate iOS you can skip this step.

Go to your apple developer page then ["Identifiers"](https://developer.apple.com/account/resources/identifiers/list) and follow these steps:

Next create a [Service ID](https://developer.apple.com/account/resources/identifiers/list/serviceId) following these steps:

- Click `"Register an Services ID"`
- Select `"Services IDs"`, click `"Continue"`
- Set your `"Description"` and `"Identifier"`
  - The `"Identifier"` will later be referred to as your `clientID`
- Click `"Continue"` and then `"Register"`

Now that the service is created, we have to `enable` it to be used for `Sign in with Apple`:

- Select the `service` from the list of services
- Check the box next to `"Sign in with Apple"`, then click `"Configure"`
- In the `Domains and Subdomains` add the domains of the websites on which you want to use Sign in with Apple, e.g. `example.com`. You have to enter at least one domain here, even if you don't intend to use Sign in with Apple on any website.
- In the `Return URLs` box add the full return URL you want to use, e.g. https://example.com/callbacks/sign_in_with_apple
- Click `"Next"` and then `"Done"` to close the settings dialog
- Click `"Continue"` and then `"Save"` to update the service

In order to communicate with Apple's servers to verify the incoming authorization codes from your app clients, you need to create a [key](https://developer.apple.com/account/resources/authkeys/list):

- Click `"Create a key"`.
- Set the `"Key Name"` (E.g. "Sign in with Apple key").
- Check the box next to `"Sign in with Apple"`, then click `"Configure"` on the same row.
- Under `"Primary App ID"` select the `App ID` of the app you want to use (either the newly created one or an existing one).
- Click `"Save"` to leave the detail view.
- Click `"Continue"` and then click `"Register"`.
- Now you'll see a one-time-only screen where you must download the key by clicking the `"Download"` button.
- Also note add `"Key ID"` to configure the Firebase.
- Add [Team ID](https://developer.apple.com/account/#/membership) to Firebase.
- Add `Private key` to Firebase from the opening Downloaded `.p8` file.
## Configuration for Apple Login for Android

To use this plugin on Android, you will need to use the [Android V2 Embedding](https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects).  
You can find out if you are already using the new embedding by looking into your `AndroidManifest.xml` and look for the following element:
```xml
<meta-data
  android:name="flutterEmbedding"
  android:value="2" 
/>
```

In case you are not yet using `Android V2 Embedding`, please first upgrade your app using the following guide: https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects

- Open the `example` folder inside this package in an editor of your choice
- Run `flutter packages get`
- Open `lib/main.dart` and look at the `SignInWithAppleButton.onPressed` callback
  - Set the `scopes` parameter to your required scopes, for testing we can keep requesting a name and email
  - Update the values passed to the `WebAuthenticationOptions` constructor to match the values in the Apple Developer Portal
  - Likewise update the `signInWithAppleEndpoint` variable to point to your
- Once you have updated the code, `flutter run` the example on an Android device or emulator

- In your `android/app/src/main/AndroidManifest.xml` inside `<application>` add

```xml
<activity
    android:name="com.aboutyou.dart_packages.sign_in_with_apple.SignInWithAppleCallback"
    android:exported="true"
>
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />

        <data android:scheme="signinwithapple" />
        <data android:path="callback" />
    </intent-filter>
</activity>
```

On the Sign in with Apple callback on your sever (specified in `WebAuthenticationOptions.redirectUri`), redirect safely back to your Android app using the following URL:

```
intent://callback?${PARAMETERS FROM CALLBACK BODY}#Intent;package=YOUR.PACKAGE.IDENTIFIER;scheme=signinwithapple;end
```

The `PARAMETERS FROM CALLBACK BODY` should be filled with the urlencoded body you receive on the endpoint from Apple's server, and the `package` parameter should be changed to match your app's package identifier (as published on the Google Play Store). Leave the `callback` path and `signinwithapple` scheme untouched.

Furthermore, when handling the incoming credentials on the client, make sure to only overwrite the current (guest) session of the user once your own server have validated the incoming `code` parameter, such that your app is not susceptible to malicious incoming links (e.g. logging out the current user)
### iOS

At this point you should have added the Sign in with Apple capability to either your own app's capabilities or the test application you created to run the example.

In case you don't have `Automatically manage Signing` turned on in Xcode, you will need to recreate and download the updated Provisioning Profiles for your app, so they include the new `Sign in with Apple` capability. Then you can download the new certificates and select them in Xcode.

In case XCode manages your signing, this step will be done automatically for you. Just make sure the `Sign in with Apple` capability is actived as described in the example below.

Additionally this assumes that you have at least one iOS device registered in your developer account for local testing, so you can run the example on a device.

#### Example

- Open the `example` folder in a terminal and run `flutter packages get`
- Open `example/ios/Runner.xcworkspace` in Xcode
- Under `Runner` (file browser side bar) -> `Targets` -> `Runner` -> `Signing & Capabilities` set the "Bundle Identifier" ("App ID") you have created in the Apple Developer Portal earlier
  - Ensure that "Sign in with Apple" is listed under the capabilities (if not, add it via the `+`)
- Now open a terminal in the `example` folder and execute the follow commands
  - `cd ios`
  - `bundle install`, to install the Ruby dependencies used for Cocoapods
  - `bundle exec pod install`, to install the Cocoapods for the iOS project
- In the terminal navigate back to the root of the `example` folder and `flutter run` on your test device

#### Your App

- First and foremost make sure that your app has the "Sign in with Apple" capability (`Runner` (file browser side bar) -> `Targets` -> `Runner` -> `Signing & Capabilities`), as otherwise Sign in with Apple will fail without visual indication (the code will still receive exceptions)
- Either integrate the example server as shown above, or build your own backend
  - Ensure that the `clientID` used when validating the received `code` parameter with Apple's server is dependent on the client: Use the App ID (also called "Bundle ID" in some places) when using codes from apps running on Apple platforms, and use the service ID when using a code retrieved from a web authentication flow
## Usage

```dart
class  _MyWidget  extends StatelessWidget with  GithubLogin {
@override
Widget  build(BuildContext  context) {
	return Column(children: [
              TextButton(
                  onPressed: () => signInWithGithub(
                      context: context,
                      clientId: [YOUR_CLIENTID],
                      clientSecret: [YOUR_CLIENTSECRET_KEY],
                      redirectUrl:
                          'https://yourproject.firebaseapp.com/__/auth/handler',
                      firebaseInstance: FirebaseAuth.instance,
                      onSuccess: (message) {},
                      onError: (error) {}),
                  child: const Text(
                    'Github Login',
                    style: TextStyle(color: Colors.black54),
                  )),
              TextButton(
                onPressed: () =>
                    signOutFromGithub(firebaseInstance: FirebaseAuth.instance),
                child: const Text(
                  'Github Logout',
                  style: TextStyle(color: Colors.black54),
                ),
              )
            ]);
}
```

# Facebook Login

## Configuration for Facebook Login on Android

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- Register on [FacebookDev](https://developers.facebook.com/apps/create/)
- Add repository your_app -> gradle -> build.gradle (Project)

```dart
buildscript {
    repositories {
        mavenCentral()
    }
```

- Add repository your_app -> gradle -> build.gradle (Module)

```dart
dependencies {
	 implementation 'com.facebook.android:facebook-login:latest.release'
	}
```

- Open your `/app/src/main/res/values/strings.xml` file.
- Add string elements with the names facebook_app_id, `fb_login_protocol_scheme` and` facebook_client_token`, and set the values to your `App ID` and `Client Token`.

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">[APP-NAME]</string>
    <string name="facebook_app_id">[APP-ID]</string>
    <string name="fb_login_protocol_scheme">fb[APP-ID]</string>
    <string name="facebook_client_token">[CLIENT-TOKEN]</string>
</resources>
```

- In `app -> src -> main -> AndroidManifest.xml` add the following under `application`

```xml
<application>
    <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
    <meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
    <activity android:name="com.facebook.FacebookActivity"
        android:configChanges=
                "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
        android:label="@string/app_name" />
    <activity
        android:name="com.facebook.CustomTabActivity"
        android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="@string/fb_login_protocol_scheme" />
        </intent-filter>
    </activity>
</application>
```

- In app -> src -> main -> AndroidManifest.xml add the following under `manifest`

```xml
</manifest>
    <uses-permission android:name="android.permission.INTERNET"/>
</manifest>
```

- In Facebook Dev console Add Platform as Android under Basic Settings
- Key Hash in console by running the following in the terminal and add the password as `android`

```bash
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64
```

- Add `Package Names` and `Class Name` from app -> src -> main -> AndroidManifest.xml
- Add `App ID` and `App secret` into provider (`Facebok`) from Facebook developer console.

## Configuration for Facebook Login on IOS

```plist
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb[APP-ID]</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>[APP-ID]</string>
<key>FacebookClientToken</key>
<string>[CLIENT-TOKEN]</string>
<key>FacebookDisplayName</key>
<string>[APP-NAME]</string>
```
```plist
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-share-api</string>
</array>
```
## Usage

```dart
class  _MyWidget  extends StatelessWidget with  FacebookLogin {
@override
Widget  build(BuildContext  context) {
	return Column(
              children: [
                TextButton(
                  onPressed: () => signInWithFacebook(
                      firebaseInstance: FirebaseAuth.instance,
                      onSuccess: (message) {},
                      onError: (error) {}),
                  child:const Text(
                    'Facebook Login',
                    style:  TextStyle(color: Colors.black54),
                  ),
                ),
                TextButton(
                onPressed: () =>
                    signOutFromFacebook(firebaseInstance: FirebaseAuth.instance),
                child: const Text(
                  'Facebook Logout',
                  style: TextStyle(color: Colors.black54),
                ),
              )
              ],
            );
}
```

# Twitter Login

## Configuration for Twitter Login

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- While adding provider (`Twitter`) -> copy redirectUrl
- Register new [OAuth](https://developer.twitter.com/)
- Under `User authentication settings -> Edit` enable `OAuth 2.0` select `Type of App`
- Register a different `Callback URI / Redirect URL` on Twitter Developers replacing default Firebase Callback URI https://abcdefg.firebaseapp.com/__/auth/handler
- Add `API key` and `API secret` into Firebase Console and Enable and Save it.
- Apply for elevated access on Twitter from [portal](https://developer.twitter.com/en/portal/products/elevated)
- Add the dependency for Android in `app -> src -> main -> AndroidManifest.xml`

```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="[YOUR_CALLBACK_URI_SCHEMA]"
        android:host="[HOST_IS_OPTIONAL]" />
</intent-filter>
```

## Usage

```dart
class  _MyWidget  extends StatelessWidget with  TwitterSocialLogin {
@override
Widget  build(BuildContext  context) {
	return Column(
              children: [
                TextButton(
                    onPressed: () => signInWithTwitter(
                        context: context,
                        apiKey: [API_KEY],
                        apiSecretKey: [API_SECRET_KEY],
                        redirectURI: 'yourproject://',
                        firebaseInstance: FirebaseAuth.instance,
                        onSuccess: (message) {},
                        onError: (error) {}),
                    child: const Text(
                      'Twitter Login',
                      style: TextStyle(color: Colors.black54),
                    )),
                TextButton(
                    onPressed: () => signOutFromFacebook(
                        firebaseInstance: FirebaseAuth.instance),
                    child: const Text(
                      'Twitter Logout',
                      style: TextStyle(color: Colors.black54),
                    )),
              ],
            ),
}
```

# Phone Login

## Configuration for Phone Login Android

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- Add provider (`Phone`) on Firebase Console
## Configuration for Phone Login IOS
```plist
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>Define your schema</string>
			</array>
		</dict>
	</array>
```
## Usage

```dart
class  _MyWidget  extends StatelessWidget with  PhoneLogin {
@override
Widget  build(BuildContext  context) {
	return Column(
              children: [
                TextButton(
                    onPressed: () => verifyPhoneNumber(
                        phoneNumber: [YOUR_PHONE_NUMBER],
                        firebaseInstance: FirebaseAuth.instance,
                        onSuccess: (message) {
                          snackBar(message);
                        },
                        onError: (error) {
                          snackBar(error);
                        }),
                        codeSent: ((verificationId, resendingToken) => {},
                    child: const Text(
                      'Verify Phone',
                      style: TextStyle(color: Colors.black54),
                    )),
                TextButton(
                    onPressed: () => signInWithPhone(
                        phoneNumber: [YOUR_PHONE_NUMBER],
                        smsCode: [YOUR_SMS_CODE],
                        firebaseInstance: FirebaseAuth.instance,
                        onSuccess: (message) {
                          snackBar(message);
                        },
                        onError: (error) {
                          snackBar(error);
                        }),
                        verificationId: [YOUR_VERIFICATION_ID]
                    child: const Text(
                      'Signin with phone',
                      style: TextStyle(color: Colors.black54),
                    )),
                TextButton(
                    onPressed: () => signOutFromPhone(
                        firebaseInstance: FirebaseAuth.instance),
                    child: const Text(
                      'Phone Logout',
                      style: TextStyle(color: Colors.black54),
                    )),
              ],
            ),
}
```

# Firebase-Email Login

## Configuration for Firebase-Email Login

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)

## Usage
### Sign-up to Firebase Email Login
```dart
class  _MyWidget  extends StatelessWidget with  FirebaseEmailLogin {
@override
Widget  build(BuildContext  context) {
	return Column(
              children: [
                TextButton(
                  onPressed: () => signUpWithFirebaseEmail(
                    firebaseInstance: FirebaseAuth.instance,
                    email: [YOUR_EMAIL],
                    password: [YOUR_PASSWORD],
                    onSuccess: (message) {
                      snackBar(message);
                    },
                    onError: (error) {
                      snackBar(error);
                    },
                  ),
                  child: const Text(
                    'Firebase-Email Singup',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                TextButton(
                    onPressed: () => signOutFromFirebaseEmail(
                        firebaseInstance: FirebaseAuth.instance),
                    child: const Text(
                      'Firebase-Email Logout',
                      style: TextStyle(color: Colors.black54),
                    )),
              ],
            ),
}
```
### Sign-in to Firebase Email Login
```dart
class  _MyWidget  extends StatelessWidget with  FirebaseEmailLogin {
@override
Widget  build(BuildContext  context) {
	return Column(
              children: [
                TextButton(
                  onPressed: () => signInWithFirebaseEmail(
                    firebaseInstance: FirebaseAuth.instance,
                    email: [YOUR_EMAIL],
                    password: [YOUR_PASSWORD],
                    onSuccess: (message) {
                      snackBar(message);
                    },
                    onError: (error) {
                      snackBar(error);
                    },
                  ),
                  child: const Text(
                    'Firebase-Email Login',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                TextButton(
                    onPressed: () => signOutFromFirebaseEmail(
                        firebaseInstance: FirebaseAuth.instance),
                    child: const Text(
                      'Firebase-Email Logout',
                      style: TextStyle(color: Colors.black54),
                    )),
              ],
            ),
}
```
### Reset password for Firebase Email Login
```dart
class  _MyWidget  extends StatelessWidget with  FirebaseEmailLogin {
@override
Widget  build(BuildContext  context) {
	return TextButton(
                  onPressed: () => resetPasswordWithFirebaseEmail(
                    firebaseInstance: FirebaseAuth.instance,
                    email: [YOUR_EMAIL],
                    onSuccess: (message) {
                      snackBar(message);
                    },
                    onError: (error) {
                      snackBar(error);
                    },
                  ),
                  child: const Text(
                    'Firebase-Email Reset',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
}
```
# Biometric Login

## Configuration for Biometric Login for Android

Add the dependency for Android in `app -> src -> main -> AndroidManifest.xml` under `<manifest>`

```xml
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```

Add the dependency for Android in `app -> src -> main -> kotlin -> com -> example -> example -> MainActivity.kt` replace with below snippet excluding package declaration.

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine
import androidx.annotation.NonNull;

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
```
## Configuration for Biometric Login for IOS
In `ios/Runner/Base.Iproj/Info.plist` add below
```plist
<key>NSFaceIDUsageDescription</key>
<string>Why is my app authenticating using face id?</string>
```
## Usage

```dart
class  _MyWidget  extends StatelessWidget with  FingerprintLogin {
@override
Widget  build(BuildContext  context) {
	return TextButton(
		onPressed: () => signInWithBiometric(
                  onSuccess: (message) {
                    snackBar(message, context);
                  },
                  onError: (error) {
                    snackBar(error, context);
                  },
                  isBiometricAvailable: (status) {}),
            ),
		child: Text('Biometric Login',style: const  TextStyle(color: Colors.black54),
	);
}
```
