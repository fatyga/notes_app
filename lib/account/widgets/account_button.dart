import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  const AccountButton(
      {super.key,
      required this.onPressed,
      required this.inProgress,
      required this.name});
  final VoidCallback onPressed;
  final bool inProgress;
  final Widget name;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: inProgress ? null : onPressed,
        child: inProgress
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2))
            : name);
  }
}
