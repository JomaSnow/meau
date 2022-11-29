import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app/app.dart';
import 'package:app/util/local_storage.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalStorage.init();

  runApp(const MyApp());
}
