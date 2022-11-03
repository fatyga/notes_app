import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/avatar.dart';
import 'package:notes_app/components/edit_account.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:provider/provider.dart';

class UserAccountInfoPage extends StatelessWidget {
  const UserAccountInfoPage({super.key});

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return EditAccount();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(leading: AutoLeadingButton(), title: Text('Your Account')),
        body: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Consumer<UserAccount?>(
                  builder: (context, value, child) {
                    if (value != null) {
                      return UserAvatar(
                        radius: 60,
                        avatarUrl: value.avatarUrl,
                      );
                    } else {
                      return UserAvatar(
                        radius: 60,
                      );
                    }
                  },
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text('First name:'),
                    Consumer<UserAccount?>(
                        builder: ((context, value, child) => Text(
                            value?.firstName ?? 'unset',
                            style: Theme.of(context).textTheme.headlineSmall))),
                    const SizedBox(height: 20),
                    const Text('Last name:'),
                    Consumer<UserAccount?>(
                        builder: ((context, value, child) => Text(
                            value?.lastName ?? 'unset',
                            style: Theme.of(context).textTheme.headlineSmall))),
                    const SizedBox(height: 10),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      _showEditBottomSheet(context);
                    },
                    child: const Text('Edit account')),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var result = await AuthService().signOut();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Logout'))
              ],
            )
          ],
        ));
  }
}
