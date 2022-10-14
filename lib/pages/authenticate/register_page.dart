import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                Text('Register', style: Theme.of(context).textTheme.headline4),
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
                              onPressed: () {}, child: const Text('Register'))
                        ])),
              ]),
        ));
  }
}
