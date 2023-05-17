import 'package:flutter/material.dart';
import 'package:to_do_list/feature/checklists/bloc/checklists_bloc.dart';
import 'package:to_do_list/feature/checklists/checklists/checklists_page.dart';
import 'package:to_do_list/model/checklist.dart';

class NewChecklistDialog extends StatefulWidget {
  const NewChecklistDialog({super.key});

  @override
  State<NewChecklistDialog> createState() => _NewChecklistDialogState();
}

class _NewChecklistDialogState extends State<NewChecklistDialog> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[100],
      title: const Text(
        "New Checklist",
        style: TextStyle(fontSize: 25),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: textController,
            minLines: 1,
            maxLines: 1,
            decoration: const InputDecoration(
              label: Text(
                "Title",
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            bloc.add(
                ChecklistsEventOnChecklistAdded(checklist: Checklist(textController.text, List.empty(growable: true))));
            textController.clear();
            Navigator.of(context).pop();
          },
          child: const Text(
            "Create",
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
        ),
      ],
    );
  }
}
