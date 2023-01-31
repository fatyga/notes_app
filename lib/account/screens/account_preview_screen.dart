import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/account/domain/user_account_preview_view_model.dart';
import 'package:notes_app/account/domain/user_account_view_model.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/avatar.dart';
import 'package:notes_app/shared/enums/view_state.dart';

class UserAccountPreviewPage extends StatefulWidget {
  const UserAccountPreviewPage({super.key});

  @override
  State<UserAccountPreviewPage> createState() => _UserAccountPreviewPageState();
}

class _UserAccountPreviewPageState extends State<UserAccountPreviewPage> {
  final model = serviceLocator<UserAccountPreviewViewModel>();
  final AuthenticationService authenticationService =
      serviceLocator<AuthenticationService>();

  @override
  void initState() {
    model.startAccountChangesSubscription();
    super.initState();
  }

  @override
  void dispose() {
    model.stopAccountChangesSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your account'),
          leading: const AutoLeadingButton(),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: AnimatedBuilder(
              animation: model,
              builder: (context, _) => model.status == ViewState.busy
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        UserAvatar(
                            radius: 72, avatarUrl: model.account.avatarUrl),
                        ElevatedButton(
                            onPressed: () async {
                              await authenticationService.signOutUser();
                            },
                            child: const Text('Logout'))
                      ],
                    ),
            )));
  }
}
