import 'package:flutter/material.dart';
import 'package:to_do_list/feature/notes/bloc/notes_bloc.dart';
import 'package:to_do_list/feature/notes/notes/notes_page.dart';
import 'package:to_do_list/model/note.dart';

class DeleteNoteDialog extends StatelessWidget {
  final Note note;
  const DeleteNoteDialog(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete note"),
      content: const Text(
        "Are you sure you want to delete this note?",
        style: TextStyle(fontSize: 25),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            bloc.add(NotesEventOnNoteDeleted(note: note));
          },
          child: const Text(
            "Confirm",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        )
      ],
      backgroundColor: Colors.orange[100],
    );
  }
}
