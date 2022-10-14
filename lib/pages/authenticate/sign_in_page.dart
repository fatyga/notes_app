import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: <Widget>[
                const SizedBox(height: 120.0),
                Text('Sign in', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                              validator: (value) =>
                                  (value != null) ? 'Enter an email' : null,
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: 'Email',
                              )),
                          const SizedBox(height: 20),
                          TextFormField(
                              validator: (value) => (value != null)
                                  ? 'Enter at least 6 characters'
                                  : null,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: 'Password',
                              )),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                context.router.push(const RegisterPageRoute());
                              },
                              child: const Text('Sign in'))
                        ])),
              ]),
        ));
  }
}
