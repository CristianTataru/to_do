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
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.orange,
                  width: 3,
                ),
              ),
              height: 50,
              child: TextField(
                style: const TextStyle(
                  fontSize: 30,
                ),
                cursorColor: Colors.black,
                controller: textController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: textController.clear,
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                  border: InputBorder.none,
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                    ...databaseRepository.getFilteredNotes(textController.text).map(
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
        height: 91,
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
