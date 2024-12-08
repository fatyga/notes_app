import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/service_locator.dart';
import 'firebase_options.dart';

import 'package:notes_app/notes_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();

  runApp( NotesApp());
  // runApp(MultiProvider(providers: [
  //   StreamProvider<User?>.value(
  //       value: AuthenticationService.user, initialData: null),
  // ], child: MyApp()));
}
