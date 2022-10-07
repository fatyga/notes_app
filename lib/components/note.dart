import 'package:flutter/material.dart';
import 'package:notes_app/notes.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.noteInstance});

  final Note noteInstance;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Text(
                    noteInstance.createdAt,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ]),
          ),
        ),
        const SizedBox(height: 15)
      ],
    );
  }
}
