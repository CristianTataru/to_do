import 'package:flutter/material.dart';

import 'package:to_do_list/feature/edit_note/edit_note.dart';
import 'package:to_do_list/main.dart';

import '../model/note.dart';

class SingleNotePage extends StatefulWidget {
  final void Function() homeCallback;
  final Note note;
  const SingleNotePage(this.homeCallback, this.note, {super.key});

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  void onDeletePressed() {
    showDialog(
      context: context,
      builder: (context) {
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
                databaseRepository.deleteNote(widget.note);
                widget.homeCallback();
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.note.title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.title,
              style: TextStyle(
                color: Colors.orange[100],
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.note.content,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  color: Colors.orange,
                  iconSize: 40,
                  tooltip: "Delete Note",
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.delete),
                ),
                const Spacer(),
                IconButton(
                  color: Colors.orange,
                  iconSize: 40,
                  tooltip: "Edit Note",
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return EditNotePage(
                            widget.homeCallback,
                            widget.note,
                          );
                        },
                      ),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
