import 'package:flutter/material.dart';
import 'package:notes_app/notes.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.noteInstance});

  final Note noteInstance;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              final provider = Provider.of<Notes>(context, listen: false);
              Navigator.pushNamed(context, '/notePreview',
                  arguments: provider.notes.indexOf(noteInstance));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: noteInstance.backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(noteInstance.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 15),
                    Text(noteInstance.createdAt,
                        style: Theme.of(context).textTheme.subtitle2),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
