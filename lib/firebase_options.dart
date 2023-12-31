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
    apiKey: 'AIzaSyARxF12b2hCtFG-1FqTv9C-PwFx-TnsKqY',
    appId: '1:702106737313:web:b0b8287db9b1359914aee0',
    messagingSenderId: '702106737313',
    projectId: 'countries-searcher',
    authDomain: 'countries-searcher.firebaseapp.com',
    storageBucket: 'countries-searcher.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqSfR8xsPSu-w6wrVgZft9sgKQCS_-XqU',
    appId: '1:702106737313:android:c514d6975b8a29d914aee0',
    messagingSenderId: '702106737313',
    projectId: 'countries-searcher',
    storageBucket: 'countries-searcher.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjD1pB2HMTP5PRjNYrj9vw2y8inVeJNvM',
    appId: '1:702106737313:ios:81ef410b7ca5d1e414aee0',
    messagingSenderId: '702106737313',
    projectId: 'countries-searcher',
    storageBucket: 'countries-searcher.appspot.com',
    iosBundleId: 'com.example.flutterBootstrap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjD1pB2HMTP5PRjNYrj9vw2y8inVeJNvM',
    appId: '1:702106737313:ios:81ef410b7ca5d1e414aee0',
    messagingSenderId: '702106737313',
    projectId: 'countries-searcher',
    storageBucket: 'countries-searcher.appspot.com',
    iosBundleId: 'com.example.flutterBootstrap',
  );
}
