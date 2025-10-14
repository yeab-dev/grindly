import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grindly/app.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const App());
}
