import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/checklist.dart';

class SingleChecklistPage extends StatefulWidget {
  final void Function() homeCallback;
  final Checklist checklist;
  const SingleChecklistPage(this.homeCallback, this.checklist, {super.key});

  @override
  State<SingleChecklistPage> createState() => _SingleChecklistPageState();
}

class _SingleChecklistPageState extends State<SingleChecklistPage> {
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
    final tasks = databaseRepository.getChecklistData(widget.checklist);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.checklist.title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.checklist.title,
              style: TextStyle(
                color: Colors.orange[100],
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...tasks.map(
                      (e) => ShowTask(e, () {
                        widget.homeCallback();
                        setState(() {});
                      }, widget.checklist),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
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
                              Navigator.of(context).pop();
                              widget.checklist.content.add(
                                ChecklistEntry(textController.text, false),
                              );
                              databaseRepository.saveAppData();
                              textController = TextEditingController();
                              setState(() {});
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
                      );
                    });
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.orange,
                size: 45,
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class ShowTask extends StatefulWidget {
  final ChecklistEntry entry;
  final void Function() callback;
  final Checklist checklist;
  const ShowTask(this.entry, this.callback, this.checklist, {super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  void changeVisibility() {
    setState(() {
      widget.entry.checked = widget.entry.checked == false ? true : false;
      widget.callback();
    });
  }

  void deleteItem() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete item"),
          content: const Text(
            "Are you sure you want to delete this item?",
            style: TextStyle(fontSize: 25),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.checklist.content.remove(widget.entry);
                widget.callback();
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
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: changeVisibility,
          child: Row(
            children: [
              Checkbox(
                shape: const StadiumBorder(),
                value: widget.entry.checked,
                onChanged: (bool? checkBoxValue) {
                  setState(() {
                    // ignore: prefer_if_null_operators
                    widget.entry.checked = checkBoxValue == null ? false : checkBoxValue;
                    databaseRepository.saveAppData();
                    widget.callback();
                  });
                },
                checkColor: Colors.black,
                fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    return Colors.orange;
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.entry.name,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const Spacer(),
              IconButton(
                  onPressed: deleteItem,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.orange,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
