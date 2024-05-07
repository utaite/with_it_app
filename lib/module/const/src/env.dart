import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final class Env {
  static const bool isDebug = true;

  static const Map<TargetPlatform, FirebaseOptions> options = {
    TargetPlatform.android: FirebaseOptions(
      apiKey: 'AIzaSyCOP3HFtT1iR73QZiuqdS-5cH0VQqOmHns',
      appId: '1:675546363663:android:08233ab08f589ecb1fb07a',
      messagingSenderId: '675546363663',
      projectId: 'with-oit',
      storageBucket: 'with-oit.appspot.com',
    ),
    TargetPlatform.iOS: FirebaseOptions(
      apiKey: 'AIzaSyCW8aKQLOQCsOVEO6HxF-YhKDVXZJ07MUc',
      appId: '1:675546363663:ios:ac8e6a59a9d83fe41fb07a',
      messagingSenderId: '675546363663',
      projectId: 'with-oit',
      storageBucket: 'with-oit.appspot.com',
      iosClientId: '675546363663-n2raqnaeul2r81g78hupe0qelf7336oj.apps.googleusercontent.com',
      iosBundleId: 'com.withit.app',
    ),
  };
}
