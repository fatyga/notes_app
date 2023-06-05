import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/account/account.dart';

import '../../route/app_router.gr.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/toasts.dart';
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
              return LayoutBuilder(
                builder: (context, constraints) => ListView(children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(24),
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sign in',
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 20),
                            Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        enabled: model.status == ViewState.idle,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Enter an email';
                                          } else if (value.isEmpty) {
                                            return 'Enter an email';
                                          } else if (!value.contains('@')) {
                                            return 'Enter email in a proper format';
                                          }

                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          filled: true,
                                          labelText: 'Email',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                          controller: _passwordController,
                                          enabled:
                                              model.status == ViewState.idle,
                                          validator: (value) => (value !=
                                                      null &&
                                                  value.length < 6)
                                              ? 'Enter at least 6 characters'
                                              : null,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            filled: true,
                                            labelText: 'Password',
                                          )),
                                      const SizedBox(height: 20),
                                      AccountButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await model
                                                .signInUser(
                                                    _emailController.text,
                                                    _passwordController.text)
                                                .then((_) {
                                              context
                                                  .showToast('User logged in!');
                                            }).catchError((error, stackTrace) {
                                              context.showToast(
                                                  (error as Exception)
                                                      .toString());
                                            });
                                          }
                                        },
                                        name: const Text('Sign in'),
                                        inProgress:
                                            model.status == ViewState.busy,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            context.router
                                                .push(const RegisterRoute());
                                          },
                                          child:
                                              const Text('Create an account'))
                                    ]))
                          ])),
                ]),
              );
            }));
  }
}
