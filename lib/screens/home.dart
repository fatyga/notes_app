import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Notes>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title: Text('Notes',
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: ListView.builder(
            itemCount: model.notesCount,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      model.currentNote = index;
                      Navigator.pushNamed(context, '/noteView');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      //margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: model.notes[index].backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(model.notes[index].title,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 15),
                            Text(
                              model.notes[index].formattedTime,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 15)
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        elevation: 12,
        onPressed: () {
          Navigator.pushNamed(context, '/newNote');
        },
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}
