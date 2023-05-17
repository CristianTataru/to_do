import 'package:flutter/material.dart';
import 'package:to_do_list/feature/checklists/bloc/checklists_bloc.dart';
import 'package:to_do_list/feature/checklists/checklists/checklists_page.dart';
import 'package:to_do_list/model/checklist.dart';

class AddItemDialog extends StatefulWidget {
  final int index;
  const AddItemDialog(this.index, {super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AlertDialog(
        backgroundColor: Colors.orange[100],
        title: const Text(
          "Add Item",
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
                  "Item",
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
              bloc.add(ChecklistsEventOnChecklistItemAdded(
                  index: widget.index, entry: ChecklistEntry(textController.text, false)));
              textController.clear();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Add",
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
      ),
    );
  }
}
