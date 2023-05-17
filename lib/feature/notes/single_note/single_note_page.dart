import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/feature/notes/bloc/notes_bloc.dart';
import 'package:to_do_list/feature/notes/single_note/edit_note_page.dart';
import 'package:to_do_list/feature/notes/notes/notes_page.dart';
import 'package:to_do_list/model/note.dart';
import 'package:to_do_list/feature/notes/single_note/delete_note_dialog.dart';

class SingleNotePage extends StatefulWidget {
  final int index;
  const SingleNotePage(this.index, {super.key});

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  void onDeletePressed(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteNoteDialog(note);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      bloc: bloc,
      builder: (context, state) {
        final note = widget.index > state.notes.length - 1 ? const Note('', '') : state.notes[widget.index];
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(note.title),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  note.title,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            note.content,
                            style: const TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.start,
                          ),
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
                      onPressed: () => onDeletePressed(note),
                      icon: const Icon(Icons.delete),
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.orange,
                      iconSize: 40,
                      tooltip: "Edit Note",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EditNotePage(
                                note,
                                widget.index,
                              );
                            },
                          ),
                        );
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
      },
    );
  }
}
