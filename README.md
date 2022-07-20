# Authentication

Apple login is been implemented but not ready for use.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |

| :----: | :-----: | :-: | :---: | :-: | :---: | :-----: |

| Login from | &check; | &cross; | &cross; | &cross; | &cross; | &cross; |

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

## Configuration for Google Login

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

# Facebook Login

## Configuration for Github Login

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

- Open your `/app/res/values/strings.xml` file.
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
- Key Hash in console by running the following in the terminal.

```bash
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64
```

- Add `Package Names` and `Class Name` from app -> src -> main -> AndroidManifest.xml
- Add `App ID` and `App secret` into provider (`Facebok`) from Facebook developer console.

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

## Configuration for Phone Login

- Add **Firebase** to your **Flutter Application**
  [Adding Firebase](https://firebase.google.com/docs/flutter/)
- Add provider (`Phone`) on Firebase Console

## Usage

```dart
class  _MyWidget  extends StatelessWidget with  PhoneLogin {
@override
Widget  build(BuildContext  context) {
	return Column(
              children: [
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
                    child: const Text(
                      'Phone Login',
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

# Biometric Login

## Configuration for Biometric Login

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

## Usage

```dart
class  _MyWidget  extends StatelessWidget with  FingerprintLogin {
@override
Widget  build(BuildContext  context) {
	return TextButton(
		onPressed: () => signInWithFirebaseEmail(
                    firebaseInstance: FirebaseAuth.instance,
                    email: [YOUR_EMAIL],
                    password: [YOUR_PASSWORD],
                    onSuccess: (message) {
                      snackBar(message);
                    },
                    onError: (error) {
                      snackBar(error);
                    },)
		child: Text('Firebase-Email Login',style: const  TextStyle(color: Colors.black54),
	);
}
```
