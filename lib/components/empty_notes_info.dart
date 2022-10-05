import 'package:flutter/material.dart';

class EmptyNotesInfo extends StatelessWidget {
  const EmptyNotesInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.note, color: Colors.grey[500], size: 60),
          const SizedBox(height: 10),
          Text("There aren't any notes yet",
              style: TextStyle(color: Colors.grey[500], fontSize: 15))
        ],
      ),
    );
  }
}
