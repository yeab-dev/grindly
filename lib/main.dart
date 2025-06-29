import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grindly/app.dart';
import 'package:grindly/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const App());
}
