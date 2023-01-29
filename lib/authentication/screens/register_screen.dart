import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/account/domain/new_account_view_model.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/avatar.dart';
import 'package:notes_app/shared/enums/view_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  NewAccountViewModel model = serviceLocator<NewAccountViewModel>();
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      model.selectedAvatar = file;
    }
  }

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
                    const SizedBox(height: 28),
                    UserAvatar(
                        selectedAvatar: model.selectedAvatar,
                        radius: 72,
                        onPressed: (model.status == ViewState.busy)
                            ? null
                            : pickImage),
                    const SizedBox(height: 28),
                    Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  controller: _firstNameController,
                                  enabled: model.status == ViewState.idle,
                                  validator: (value) =>
                                      (value != null && value.isEmpty)
                                          ? 'Enter a first name'
                                          : null,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'First Name',
                                  )),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: _lastNameController,
                                  enabled: model.status == ViewState.idle,
                                  validator: (value) =>
                                      (value != null && value.isEmpty)
                                          ? 'Enter a last name'
                                          : null,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Last Name',
                                  )),
                              const SizedBox(height: 20),
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
                                      await model.createAccount(
                                        _emailController.text,
                                        _passwordController.text,
                                        _firstNameController.text,
                                        _lastNameController.text,
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
