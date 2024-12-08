import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

extension Dialogs on BuildContext {
  Future<void> deleteDialog(Function deleteFn) async {
    final confirmed = await showDialog(
        context: this,
        builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('The data will be permanently lost!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.router.maybePop(false);
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        context.router.maybePop(true);
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error),
                      child: const Text('Yes'))
                ]));
    if (confirmed != null && confirmed) {
      deleteFn();
    }
  }
}
