import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:provider/provider.dart';

class AuthenticateTopPage extends StatelessWidget {
  const AuthenticateTopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      AutoRouter.of(context).root.replace(HomeTopRoute());
    }

    return AutoRouter();
  }
}
