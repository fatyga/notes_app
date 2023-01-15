import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/services/notes_service.dart';
import 'package:notes_app/account/services/storage_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return MultiProvider(providers: [
      Provider<StorageService>(
        create: ((context) => StorageService(
            storage: FirebaseStorage.instance, userUid: user!.uid)),
      )
    ], child: const AutoRouter());
  }
}
