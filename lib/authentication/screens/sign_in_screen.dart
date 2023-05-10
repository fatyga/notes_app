import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../route/app_router.gr.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/notification.dart';
import '../authentication.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInViewModel model = serviceLocator<SignInViewModel>();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation: model,
            builder: (context, _) {
              return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: <Widget>[
                    const SizedBox(height: 120.0),
                    Text('Sign in',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 20),
                    Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                enabled: model.status == ViewState.idle,
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
                                  enabled: model.status == ViewState.idle,
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
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await model.signInUser(
                                          _emailController.text,
                                          _passwordController.text);

                                      if (mounted) {
                                        showNotificationToUser(
                                            context, model, false);
                                      }
                                    }
                                  },
                                  child: model.status == ViewState.busy
                                      ? const CircularProgressIndicator()
                                      : const Text('Sign in')),
                              TextButton(
                                  onPressed: () {
                                    context.router.push(const RegisterRoute());
                                  },
                                  child: const Text('Create an account'))
                            ])),
                  ]);
            }));
  }
}
