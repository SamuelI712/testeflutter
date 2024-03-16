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
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not supported for this platform.');
    }
  }


  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR API KEY',
    appId: 'YOUR APP ID',
    messagingSenderId: '',
    projectId: '',
    authDomain: '',
    storageBucket: '',
    measurementId: 'MEASUREMENT ID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR API KEY',
    appId: 'YOUR APP ID',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
  );


}
