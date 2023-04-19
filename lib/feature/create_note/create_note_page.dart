import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/note.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  TextEditingController textController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {});
    });
    textController2.addListener(() {
      setState(() {});
    });
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
        title: const Text("Create Note"),
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
                "Enter title:",
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
                "Enter content:",
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
                  disabledBackgroundColor: Colors.grey,
                  fixedSize: const Size(100, 50),
                ),
                onPressed: textController.text.isEmpty
                    ? null
                    : () {
                        databaseRepository.addNote(
                          Note(textController.text, textController2.text),
                        );
                        Navigator.of(context).pop();
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
