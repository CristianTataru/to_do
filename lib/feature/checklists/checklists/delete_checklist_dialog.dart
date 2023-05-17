import 'package:flutter/material.dart';
import 'package:to_do_list/feature/checklists/bloc/checklists_bloc.dart';
import 'package:to_do_list/feature/checklists/checklists/checklists_page.dart';
import 'package:to_do_list/model/checklist.dart';

class DeleteChecklistDialog extends StatelessWidget {
  final Checklist checklist;
  const DeleteChecklistDialog(this.checklist, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete checklist"),
      content: const Text(
        "Are you sure you want to delete this checklist?",
        style: TextStyle(fontSize: 25),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            bloc.add(ChecklistsEventOnChecklistDeleted(checklist: checklist));
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
