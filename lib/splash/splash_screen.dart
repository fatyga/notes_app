import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Notes App', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        const CircularProgressIndicator()
      ]),
    ));
  }
}
