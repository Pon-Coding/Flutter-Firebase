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
    apiKey: 'AIzaSyBR3LjO6Si-Tmhm7EX7FEHCbMS8Xo4BasE',
    appId: '1:139514856852:web:228f2dfc5517dda204bb81',
    messagingSenderId: '139514856852',
    projectId: 'push-notification-1-dbad1',
    authDomain: 'push-notification-1-dbad1.firebaseapp.com',
    storageBucket: 'push-notification-1-dbad1.appspot.com',
    measurementId: 'G-LPF0MEC3BV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDM0TT4W7HRk8ychfD1k-5WkJKBiRos2jo',
    appId: '1:139514856852:android:ebfd2d0af616dc0a04bb81',
    messagingSenderId: '139514856852',
    projectId: 'push-notification-1-dbad1',
    storageBucket: 'push-notification-1-dbad1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiU2UqBwrXU6vNvRpikfbfMWO7PO1jk50',
    appId: '1:139514856852:ios:042140993292c79004bb81',
    messagingSenderId: '139514856852',
    projectId: 'push-notification-1-dbad1',
    storageBucket: 'push-notification-1-dbad1.appspot.com',
    iosClientId: '139514856852-3um3sjbj8rg7co4n3nsaftef667sccbg.apps.googleusercontent.com',
    iosBundleId: 'com.example.pushNotification',
  );
}