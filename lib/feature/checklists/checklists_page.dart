import 'package:flutter/material.dart';
import 'package:to_do_list/feature/single_checklist_page/single_checklist_page.dart';
import 'package:to_do_list/main.dart';
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

  bool isAllSelected = true;
  bool isProgressSelected = false;
  bool isDoneSelected = false;
  String userSelection = "All";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: isAllSelected
                      ? null
                      : () {
                          setState(() {
                            isAllSelected = true;
                            isProgressSelected = false;
                            isDoneSelected = false;
                            userSelection = "All";
                          });
                        },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isAllSelected ? Colors.orange[100] : Colors.white,
                      border: Border.all(
                        width: 3,
                        color: Colors.orange,
                      ),
                    ),
                    height: 50,
                    width: 128,
                    child: Text(
                      isAllSelected ? "• All" : "All",
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: isProgressSelected
                      ? null
                      : () {
                          setState(() {
                            isAllSelected = false;
                            isProgressSelected = true;
                            isDoneSelected = false;
                            userSelection = "Progress";
                          });
                        },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isProgressSelected ? Colors.orange[100] : Colors.white,
                      border: Border.all(
                        width: 3,
                        color: Colors.orange,
                      ),
                    ),
                    height: 50,
                    width: 128,
                    child: Text(
                      isProgressSelected ? "• In progress" : "In progress",
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: isDoneSelected
                      ? null
                      : () {
                          setState(() {
                            isAllSelected = false;
                            isProgressSelected = false;
                            isDoneSelected = true;
                            userSelection = 'Done';
                          });
                        },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDoneSelected ? Colors.orange[100] : Colors.white,
                      border: Border.all(
                        width: 3,
                        color: Colors.orange,
                      ),
                    ),
                    height: 50,
                    width: 128,
                    child: Text(
                      isDoneSelected ? "• Done" : "Done",
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                    ...databaseRepository.getFilteredChecklists(userSelection).map(
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
                            databaseRepository.addChecklist(Checklist(textController.text, []));
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
  String getText() {
    List<ChecklistEntry> list = databaseRepository.getChecklistData(widget.checklist);
    int doneItems = 0;
    int notDoneItems = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].checked == true) {
        doneItems = doneItems + 1;
      } else {
        notDoneItems = notDoneItems + 1;
      }
    }
    String subtext = '';
    if (doneItems == list.length) {
      subtext = "          All items done";
    } else {
      subtext = "Done: $doneItems    Pending: $notDoneItems";
    }
    String text = "Items: ${list.length}         $subtext";
    return text;
  }

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
                                    databaseRepository.deleteChecklist(widget.checklist);
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
              widget.checklist.content.isNotEmpty ? getText() : "No item",
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
