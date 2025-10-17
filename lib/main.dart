import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grindly/app.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:grindly/shared/data/repository/local/secure_storage_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await dotenv.load(fileName: ".env");
  setupLocator();
  // final secureStorage = SecureStorageRepositoryImpl(
  //   secureStorage: getIt<FlutterSecureStorage>(),
  // );
  // await secureStorage.deleteAll();
  runApp(const App());
}
