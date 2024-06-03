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
    apiKey: 'AIzaSyD07BhJCAO7nMIBHXhYqBac3lJgBkXuiY0',
    appId: '1:958289027251:web:c9a5cacf599029182d90c6',
    messagingSenderId: '958289027251',
    projectId: 'guide-806c5',
    authDomain: 'guide-806c5.firebaseapp.com',
    storageBucket: 'guide-806c5.appspot.com',
    measurementId: 'G-54YT0EEKJB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2p3RfQ6vf9cYJZLewcbHlhKpp3M89mV4',
    appId: '1:958289027251:android:85ab4d4a254937d42d90c6',
    messagingSenderId: '958289027251',
    projectId: 'guide-806c5',
    storageBucket: 'guide-806c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4usp3j5WCC0qo7oF5ktYDuEjZr5LVp8c',
    appId: '1:958289027251:ios:b35d1417646ff8122d90c6',
    messagingSenderId: '958289027251',
    projectId: 'guide-806c5',
    storageBucket: 'guide-806c5.appspot.com',
    iosBundleId: 'com.example.guide',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD07BhJCAO7nMIBHXhYqBac3lJgBkXuiY0',
    appId: '1:958289027251:web:4428a4344667d7422d90c6',
    messagingSenderId: '958289027251',
    projectId: 'guide-806c5',
    authDomain: 'guide-806c5.firebaseapp.com',
    storageBucket: 'guide-806c5.appspot.com',
    measurementId: 'G-JEG09S404Y',
  );

}