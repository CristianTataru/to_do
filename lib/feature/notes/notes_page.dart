import 'package:flutter/material.dart';
import 'package:to_do_list/feature/create_note/create_note_page.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/single_note_page/single_note_page.dart';

import '../../model/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "My Notes",
              style: TextStyle(
                color: Colors.orange[100]!,
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
                  children: [
                    ...databaseRepository.getNotes().map(
                          (e) => NoteWidget(() {
                            setState(() {});
                          }, e),
                        ),
                    Container(
                      height: 1,
                      color: Colors.orange[100],
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                fixedSize: const Size(150, 50),
              ),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const CreateNotePage();
                    },
                  ),
                );
                setState(() {});
              },
              child: const Text(
                "Create Note",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class NoteWidget extends StatefulWidget {
  final void Function() homeCallback;
  final Note note;
  const NoteWidget(this.homeCallback, this.note, {super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.orange[100],
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SingleNotePage(widget.homeCallback, widget.note);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.orange[100]!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                color: Colors.orange[100]!,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.note.content.length < 30 ? widget.note.content : "${widget.note.content.substring(0, 30)}...",
              style: const TextStyle(color: Colors.white, fontSize: 25),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
