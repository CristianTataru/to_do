import 'package:flutter/material.dart';
import 'package:to_do_list/feature/to_do_list/bloc/to_do_list_all_page_bloc.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_all/to_do_list_all_page.dart';
import 'package:to_do_list/model/entry.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final Entry entry;
  const DeleteConfirmDialog(this.entry, {super.key});

  void onEntryDeleteConfirmed(BuildContext context) {
    Navigator.of(context).pop();
    bloc.add(ToDoListEventItemDeleted(entry: entry));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete entry"),
      content: const Text(
        "Are you sure you want to delete this entry?",
        style: TextStyle(fontSize: 25),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onEntryDeleteConfirmed(context);
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
