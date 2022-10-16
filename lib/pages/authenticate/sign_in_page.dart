import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:notes_app/pages/home/home_top_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                    Text('Sign in',
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
                                ),
                              ),
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
                                        final credential = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text);

                                        AutoRouter.of(context)
                                            .root
                                            .replace(HomeTopRoute());
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          loading = false;
                                        });
                                        if (e.code == 'user-not-found') {
                                          setState(() {
                                            error =
                                                'No user found for that email.';
                                          });
                                        } else if (e.code == 'wrong-password') {
                                          setState(() {
                                            error =
                                                'Wrong password provided for that user.';
                                          });
                                        }
                                      }
                                    }
                                  },
                                  child: const Text('Sign in')),
                              TextButton(
                                  onPressed: () {
                                    context.router.push(RegisterRoute());
                                  },
                                  child: const Text('Create an account'))
                            ])),
                  ]),
            ));
  }
}
