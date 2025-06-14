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
    apiKey: 'AIzaSyAloQ7EfFJ13fpUbtDlAIhtg7VKUryiKpc',
    appId: '1:603299099338:web:4d4e559ed940f4706efa33',
    messagingSenderId: '603299099338',
    projectId: 'visualitzacio-dades-plc---tfg',
    authDomain: 'visualitzacio-dades-plc---tfg.firebaseapp.com',
    storageBucket: 'visualitzacio-dades-plc---tfg.firebasestorage.app',
    measurementId: 'G-QXGRCLVLN0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCda2e8OzWy08tyESycG7jPcPICeustvk8',
    appId: '1:603299099338:android:7495fe4fe9b9082c6efa33',
    messagingSenderId: '603299099338',
    projectId: 'visualitzacio-dades-plc---tfg',
    storageBucket: 'visualitzacio-dades-plc---tfg.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdooFuBcHy0df1RIjIsa6BrMxT7G9VI-E',
    appId: '1:603299099338:ios:bf3d1a4c5df140636efa33',
    messagingSenderId: '603299099338',
    projectId: 'visualitzacio-dades-plc---tfg',
    storageBucket: 'visualitzacio-dades-plc---tfg.firebasestorage.app',
    iosBundleId: 'com.example.appVisualitzacioTiaportal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdooFuBcHy0df1RIjIsa6BrMxT7G9VI-E',
    appId: '1:603299099338:ios:bf3d1a4c5df140636efa33',
    messagingSenderId: '603299099338',
    projectId: 'visualitzacio-dades-plc---tfg',
    storageBucket: 'visualitzacio-dades-plc---tfg.firebasestorage.app',
    iosBundleId: 'com.example.appVisualitzacioTiaportal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAloQ7EfFJ13fpUbtDlAIhtg7VKUryiKpc',
    appId: '1:603299099338:web:dbfe8b64664944af6efa33',
    messagingSenderId: '603299099338',
    projectId: 'visualitzacio-dades-plc---tfg',
    authDomain: 'visualitzacio-dades-plc---tfg.firebaseapp.com',
    storageBucket: 'visualitzacio-dades-plc---tfg.firebasestorage.app',
    measurementId: 'G-R2F4RJ4GPG',
  );
}
