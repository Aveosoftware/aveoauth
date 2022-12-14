// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAVNNeN3PIa22AVDx5uMeanz7LDbKd7Fnw',
    appId: '1:885755172961:web:24c368ba14617c2b74f220',
    messagingSenderId: '885755172961',
    projectId: 'authmelosmodule2',
    authDomain: 'authmelosmodule2.firebaseapp.com',
    storageBucket: 'authmelosmodule2.appspot.com',
    measurementId: 'G-JBHE83X86P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcMxYrkLrxkThVZrf4O-o4sMtyc24HmnY',
    appId: '1:885755172961:android:78e908d36ff31da674f220',
    messagingSenderId: '885755172961',
    projectId: 'authmelosmodule2',
    storageBucket: 'authmelosmodule2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyUOBrOqkPLj_1uOwujWUUu7ykUbdpWIY',
    appId: '1:885755172961:ios:8a46c63e1815af5874f220',
    messagingSenderId: '885755172961',
    projectId: 'authmelosmodule2',
    storageBucket: 'authmelosmodule2.appspot.com',
    iosClientId:
        '885755172961-401b98nqf76ocqluufdmq5s0k8mtll7t.apps.googleusercontent.com',
    iosBundleId: 'com.aveosoftware.example',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyUOBrOqkPLj_1uOwujWUUu7ykUbdpWIY',
    appId: '1:885755172961:ios:ef8f4973518f761e74f220',
    messagingSenderId: '885755172961',
    projectId: 'authmelosmodule2',
    storageBucket: 'authmelosmodule2.appspot.com',
    iosClientId:
        '885755172961-401b98nqf76ocqluufdmq5s0k8mtll7t.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginexample',
  );
}
