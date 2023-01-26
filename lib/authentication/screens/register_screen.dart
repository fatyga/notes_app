import 'package:flutter/material.dart';
import 'package:notes_app/authentication/business_logic/register_view_model.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterViewModel model = serviceLocator<RegisterViewModel>();
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
                                  enabled: model.status == ViewState.idle,
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
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await model.registerUser(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                      if (model.error != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(model.error!),
                                          duration: const Duration(
                                              milliseconds: 2000),
                                        ));
                                      }
                                    }
                                  },
                                  child: model.status == ViewState.busy
                                      ? const CircularProgressIndicator()
                                      : const Text('Register'))
                            ])),
                  ]);
            }));
  }
}
