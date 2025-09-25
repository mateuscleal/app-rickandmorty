import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5EbKnzRhIlppyiZcoF-YG0mb0Cbp-5uE',
    appId: '1:577331681980:android:cee7870f852dc6a76f8eb9',
    messagingSenderId: '577331681980',
    projectId: 'app-rickandmorty-918be',
    storageBucket: 'app-rickandmorty-918be.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBs-wQc-9Omo6WoSSfkL8Obx7WWjm1O9Qo',
    appId: '1:577331681980:ios:276b77f200fb62fb6f8eb9',
    messagingSenderId: '577331681980',
    projectId: 'app-rickandmorty-918be',
    storageBucket: 'app-rickandmorty-918be.firebasestorage.app',
    iosBundleId: 'br.app.rickandmorty.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBOFPSM1nUeb1SxAuLFBmRY4J0juSvA1c0',
    appId: '1:577331681980:web:6ce26877df61df7e6f8eb9',
    messagingSenderId: '577331681980',
    projectId: 'app-rickandmorty-918be',
    authDomain: 'app-rickandmorty-918be.firebaseapp.com',
    storageBucket: 'app-rickandmorty-918be.firebasestorage.app',
    measurementId: 'G-ZQVZDNWYJT',
  );

}