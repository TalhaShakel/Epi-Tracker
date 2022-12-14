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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBER7UM59cK14SYWbXHSIskPz3E590xQYk',
    appId: '1:154820593504:android:99b0599a6d15807dea0005',
    messagingSenderId: '154820593504',
    projectId: 'worth-of-water-d4120',
    storageBucket: 'worth-of-water-d4120.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCH8IK6PfIZ3ZPzoxaIl_CfWc7cPAp-EI4',
    appId: '1:154820593504:ios:1999b5bb441bcdb9ea0005',
    messagingSenderId: '154820593504',
    projectId: 'worth-of-water-d4120',
    storageBucket: 'worth-of-water-d4120.appspot.com',
    androidClientId: '154820593504-5mqdk2ld0g7vjm7hedhogbrndt2ghhov.apps.googleusercontent.com',
    iosClientId: '154820593504-ma90ijbsi782t6n0j76fqfem1p8eo368.apps.googleusercontent.com',
    iosBundleId: 'com.example.epiTracker',
  );
}
