import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/feature/single_checklist_page/single_checklist_page.dart';
import 'package:to_do_list/model/checklist.dart';

class ChecklistsPage extends StatefulWidget {
  const ChecklistsPage({super.key});

  @override
  State<ChecklistsPage> createState() => _ChecklistsPageState();
}

class _ChecklistsPageState extends State<ChecklistsPage> {
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
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "My Checklists",
              style: TextStyle(
                color: Colors.orange[100]!,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ...database.checklists.map(
                      (e) => ChecklistWidget(() {
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
                await showDialog(
                  context: context,
                  builder: (context) {
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
                            Navigator.of(context).pop();
                            database.addChecklist(Checklist(textController.text, []));
                            textController = TextEditingController();
                            setState(() {});
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
                  },
                );
              },
              child: const Text(
                "New Checklist",
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

class ChecklistWidget extends StatefulWidget {
  final void Function() homeCallback;
  final Checklist checklist;
  const ChecklistWidget(this.homeCallback, this.checklist, {super.key});

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.orange[100],
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SingleChecklistPage(widget.homeCallback, widget.checklist);
            },
          ),
        );
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.orange[100]!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  widget.checklist.title,
                  style: TextStyle(
                    color: Colors.orange[100]!,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 35,
                  child: IconButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
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
                                    database.checklists.remove(widget.checklist);
                                    widget.homeCallback();
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
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.orange,
                      size: 35,
                    ),
                  ),
                )
              ],
            ),
            Text(
              widget.checklist.content.isNotEmpty ? database.getChecklistData(widget.checklist).first.name : "No item",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
