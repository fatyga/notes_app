import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../authentication/authentication.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/toasts.dart';
import '../../shared/widgets/avatar.dart';
import '../account.dart';

@RoutePage()
class UserAccountUpdatePage extends StatefulWidget {
  const UserAccountUpdatePage({super.key});

  @override
  State<UserAccountUpdatePage> createState() => _UserAccountUpdatePageState();
}

class _UserAccountUpdatePageState extends State<UserAccountUpdatePage> {
  final model = serviceLocator<UserAccountUpdateViewModel>();
  final AuthenticationService authenticationService =
      serviceLocator<AuthenticationService>();

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      model.selectedAvatar = file;
    }
  }

  void chooseAvatarSource() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Choose avatar source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    SizedBox(width: 8),
                    Text('gallery'),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 8),
                    Text('camera'),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    model.startAccountChangesSubscription();
    model.loadUserAccount().then((value) {
      _firstNameController.text = value.firstName;
      _lastNameController.text = value.lastName;
    });
    super.initState();
  }

  @override
  void dispose() {
    model.stopAccountChangesSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: model,
      builder: (context, _) => Scaffold(
          appBar: AppBar(
            title: const Text('Update your account'),
            leading: const AutoLeadingButton(),
            actions: [
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      model
                          .updateUserAccount(
                        model.account.copyWith(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text),
                      )
                          .then((_) {
                        if (mounted) {
                          context.showToast('Account updated successfully.');
                          context.router.maybePop();
                        }
                      });
                    }
                  },
                  icon: const Icon(Icons.save))
            ],
          ),
          body: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: AnimatedBuilder(
                animation: model,
                builder: (context, _) => model.status == ViewState.busy
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: [
                          Center(
                            child: UserAvatar(
                                selectedAvatar: model.selectedAvatar,
                                radius: 72,
                                avatarUrl: model.account.avatarUrl.isEmpty
                                    ? null
                                    : model.account.avatarUrl,
                                onPressed: (model.status == ViewState.busy)
                                    ? null
                                    : chooseAvatarSource),
                          ),
                          const SizedBox(height: 36),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                            controller: _firstNameController,
                                            enabled:
                                                model.status == ViewState.idle,
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
                                            enabled:
                                                model.status == ViewState.idle,
                                            validator: (value) =>
                                                (value != null && value.isEmpty)
                                                    ? 'Enter a last name'
                                                    : null,
                                            decoration: const InputDecoration(
                                              filled: true,
                                              labelText: 'Last Name',
                                            )),
                                        const SizedBox(height: 20),
                                      ])),
                            ],
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
              ))),
    );
  }
}
