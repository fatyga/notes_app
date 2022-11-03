import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/database/firestore_service.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/database/storage_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    return MultiProvider(providers: [
      Provider<FirestoreService>(
          create: (context) => FirestoreService(
              firestore: FirebaseFirestore.instance, userUid: user!.uid)),
      Provider<StorageService>(
        create: ((context) => StorageService(
            storage: FirebaseStorage.instance, userUid: user!.uid)),
      )
    ], child: AutoRouter());
  }
}
