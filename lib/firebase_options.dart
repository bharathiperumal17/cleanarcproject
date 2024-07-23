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
        return macos;
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
    apiKey: 'AIzaSyAE7KHzCP8jsOpBiwnkIwrKp_AFyOnmEEw',
    appId: '1:692866400661:web:1c8ccadb56a6b89278769c',
    messagingSenderId: '692866400661',
    projectId: 'cleanarcproject',
    authDomain: 'cleanarcproject.firebaseapp.com',
    storageBucket: 'cleanarcproject.appspot.com',
    measurementId: 'G-PPSNBFGXFK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNif77W5W1nUV-1c2E06u67OAJTYSXsEY',
    appId: '1:692866400661:android:76027705de06dd2e78769c',
    messagingSenderId: '692866400661',
    projectId: 'cleanarcproject',
    storageBucket: 'cleanarcproject.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRj0tpOG1g9MmIpqlzbF0z66kbZOZsA_s',
    appId: '1:692866400661:ios:60794491cb15aab778769c',
    messagingSenderId: '692866400661',
    projectId: 'cleanarcproject',
    storageBucket: 'cleanarcproject.appspot.com',
    iosBundleId: 'com.example.cleanarcproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRj0tpOG1g9MmIpqlzbF0z66kbZOZsA_s',
    appId: '1:692866400661:ios:60794491cb15aab778769c',
    messagingSenderId: '692866400661',
    projectId: 'cleanarcproject',
    storageBucket: 'cleanarcproject.appspot.com',
    iosBundleId: 'com.example.cleanarcproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAE7KHzCP8jsOpBiwnkIwrKp_AFyOnmEEw',
    appId: '1:692866400661:web:b3c75daa9bd45d1478769c',
    messagingSenderId: '692866400661',
    projectId: 'cleanarcproject',
    authDomain: 'cleanarcproject.firebaseapp.com',
    storageBucket: 'cleanarcproject.appspot.com',
    measurementId: 'G-FYY0YW0XJN',
  );
}