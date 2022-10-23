import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NotesWrapperPage extends StatefulWidget {
  const NotesWrapperPage({super.key});

  @override
  State<NotesWrapperPage> createState() => _NotesWrapperPageState();
}

class _NotesWrapperPageState extends State<NotesWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
