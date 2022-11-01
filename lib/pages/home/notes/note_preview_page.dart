import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/firestore_service.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:provider/provider.dart';

class NotePreviewPage extends StatefulWidget {
  NotePreviewPage({super.key, required this.selectedNoteId});

  final String selectedNoteId;

  @override
  State<NotePreviewPage> createState() => _NotePreviewPageState();
}

class _NotePreviewPageState extends State<NotePreviewPage> {
  final db = FirestoreService();

  bool onDeleting = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: !onDeleting,
        actions: onDeleting
            ? []
            : [
                IconButton(
                    onPressed: () async {
                      setState(() {
                        onDeleting = true;
                      });
                      await db.deleteNote(user!, widget.selectedNoteId);
                      context.router.pop();
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      context.router.push(UpdateNoteRoute(
                          selectedNoteId: widget.selectedNoteId));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      final selectedNote = Provider.of<List<Note>>(context,
                              listen: false)
                          .firstWhere(
                              (element) => element.id == widget.selectedNoteId);

                      await db.updateNote(user!, selectedNote,
                          {'pinned': !selectedNote.pinned});
                    },
                    icon: (Provider.of<List<Note>>(context, listen: false)
                            .firstWhere((element) =>
                                element.id == widget.selectedNoteId)
                            .pinned)
                        ? const Icon(Icons.push_pin_rounded)
                        : const Icon(
                            Icons.push_pin_outlined,
                          )),
              ],
      ),
      body: (onDeleting)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Consumer<List<Note>>(
                builder: (context, value, child) {
                  final selectedNote = value.firstWhere(
                      (element) => element.id == widget.selectedNoteId);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(selectedNote.title,
                          style: Theme.of(context).textTheme.headline5),
                      const SizedBox(height: 20),
                      Text(selectedNote.formattedTime,
                          style: Theme.of(context).textTheme.subtitle2),
                      const SizedBox(height: 20),
                      Text(selectedNote.content,
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  );
                },
              ),
            ),
    );
  }
}
