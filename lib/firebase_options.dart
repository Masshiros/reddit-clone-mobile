// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD0zRNExMy9RUUCy9aqdgvV5na0c0ySgEg',
    appId: '1:744785576982:web:7b365203d5a4603d102137',
    messagingSenderId: '744785576982',
    projectId: 'reddit-clone-3e54e',
    authDomain: 'reddit-clone-3e54e.firebaseapp.com',
    storageBucket: 'reddit-clone-3e54e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuD_sRUIcf8nc5nLxfozQmp3bhadtkSj0',
    appId: '1:744785576982:android:4020ee54fde07526102137',
    messagingSenderId: '744785576982',
    projectId: 'reddit-clone-3e54e',
    storageBucket: 'reddit-clone-3e54e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQaTrZD_21ror-QvBVnq4ubdt0dTbjHd4',
    appId: '1:744785576982:ios:f86689d9db293fdc102137',
    messagingSenderId: '744785576982',
    projectId: 'reddit-clone-3e54e',
    storageBucket: 'reddit-clone-3e54e.appspot.com',
    iosBundleId: 'com.example.redditMobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0zRNExMy9RUUCy9aqdgvV5na0c0ySgEg',
    appId: '1:744785576982:web:afd516e9df83ceaa102137',
    messagingSenderId: '744785576982',
    projectId: 'reddit-clone-3e54e',
    authDomain: 'reddit-clone-3e54e.firebaseapp.com',
    storageBucket: 'reddit-clone-3e54e.appspot.com',
  );
}
