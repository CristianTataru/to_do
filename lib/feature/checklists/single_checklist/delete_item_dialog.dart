import 'package:flutter/material.dart';
import 'package:to_do_list/feature/checklists/bloc/checklists_bloc.dart';
import 'package:to_do_list/feature/checklists/checklists/checklists_page.dart';
import 'package:to_do_list/model/checklist.dart';

class DeleteItemDialog extends StatelessWidget {
  final int index;
  final ChecklistEntry entry;
  const DeleteItemDialog(this.index, this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete item"),
      content: const Text(
        "Are you sure you want to delete this item?",
        style: TextStyle(fontSize: 25),
      ),
      actions: [
        TextButton(
          onPressed: () {
            bloc.add(ChecklistsEventOnChecklistItemDeleted(index: index, entry: entry));
            Navigator.of(context).pop();
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
