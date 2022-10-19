import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'firebase_options.dart';

import 'package:notes_app/notes_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(providers: [
    StreamProvider<User?>.value(value: AuthService.user, initialData: null),
  ], child: MyApp()));
}
