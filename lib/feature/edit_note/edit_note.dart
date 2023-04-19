import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';
import '../../model/note.dart';

class EditNotePage extends StatefulWidget {
  final void Function() callback;
  final Note note;
  const EditNotePage(this.callback, this.note, {super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController textController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.text = widget.note.title;
    textController2.text = widget.note.content;
  }

  @override
  void dispose() {
    textController.dispose();
    textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Edit Note"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Edit title:",
                style: TextStyle(color: Colors.orange[100], fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: textController,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  label: const Text(
                    "Title",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]!),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Edit content:",
                style: TextStyle(color: Colors.orange[100], fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: textController2,
                minLines: 10,
                maxLines: 10,
                decoration: InputDecoration(
                  label: const Text(
                    "Content",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]!),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: const Size(100, 50),
                ),
                onPressed: () {
                  setState(() {
                    widget.note.title = textController.text;
                    widget.note.content = textController2.text;
                    databaseRepository.saveAppData();
                    widget.callback();
                  });
                  Navigator.of(context).pop(widget.note);
                },
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
