import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/service_locator.dart';
import 'firebase_options.dart';

import 'package:notes_app/notes_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();

  runApp(MultiProvider(providers: [
    StreamProvider<User?>.value(value: AuthService.user, initialData: null),
  ], child: MyApp()));
}
