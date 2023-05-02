import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/shared/view_model.dart';

void showNotificationToUser(
    BuildContext context, ViewModel model, bool popRouteAfterNotification) {
  if (model.isNotificationShouldMeShown) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: model.userNotification.isError
            ? Theme.of(context).colorScheme.error
            : null,
        content: Text(model.userNotification.content),
        duration: const Duration(seconds: 1),
      ),
    );
    if (popRouteAfterNotification && model.userNotification.isError == false) {
      context.router.pop();
    }
  }
}
