import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/route/app_router.gr.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String error = '';

  bool loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: <Widget>[
                    const SizedBox(height: 120.0),
                    Text('Register',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 20),
                    Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  controller: _emailController,
                                  validator: (value) =>
                                      (value != null && value.isEmpty)
                                          ? 'Enter an email'
                                          : null,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Email',
                                  )),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: _passwordController,
                                  validator: (value) =>
                                      (value != null && value.length < 6)
                                          ? 'Enter at least 6 characters'
                                          : null,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Password',
                                  )),
                              const SizedBox(height: 20),
                              Text(error,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: Theme.of(context).errorColor)),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      try {
                                        var result = await AuthService
                                            .registerWithEmailAndPassword(
                                                _emailController.text,
                                                _passwordController.text);
                                      } catch (e) {
                                        setState(() {
                                          error = e.toString();
                                        });
                                      }
                                    }
                                  },
                                  child: const Text('Register'))
                            ])),
                  ]),
            ));
  }
}
