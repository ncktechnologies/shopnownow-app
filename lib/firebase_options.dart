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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBWJj6Xp0-AmeD_PyvTEpE1VmdUxTEoFYU',
    appId: '1:1012562916122:web:b8adaa8b909f494acbf2a3',
    messagingSenderId: '1012562916122',
    projectId: 'shopnownow-68c3b',
    authDomain: 'shopnownow-68c3b.firebaseapp.com',
    storageBucket: 'shopnownow-68c3b.appspot.com',
    measurementId: 'G-7RCQVZ8CKV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1bEBfqSsOXnXgrE6oCaPCp0QiefoMSAM',
    appId: '1:1012562916122:android:9c2185bb6c07f096cbf2a3',
    messagingSenderId: '1012562916122',
    projectId: 'shopnownow-68c3b',
    storageBucket: 'shopnownow-68c3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAeQXZPTTD-I17i9kz_pxu-oMmnOKO4K8',
    appId: '1:1012562916122:ios:72cf3ee785667a62cbf2a3',
    messagingSenderId: '1012562916122',
    projectId: 'shopnownow-68c3b',
    storageBucket: 'shopnownow-68c3b.appspot.com',
    iosBundleId: 'com.example.shopnownow',
  );
}