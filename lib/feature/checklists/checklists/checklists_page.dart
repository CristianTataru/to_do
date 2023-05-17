import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/feature/checklists/bloc/checklists_bloc.dart';
import 'package:to_do_list/feature/checklists/checklists/delete_checklist_dialog.dart';
import 'package:to_do_list/feature/checklists/checklists/new_checklist_dialog.dart';
import 'package:to_do_list/feature/checklists/single_checklist/single_checklist_page.dart';
import 'package:to_do_list/model/checklist.dart';

final bloc = ChecklistsBloc();

class ChecklistsPage extends StatefulWidget {
  const ChecklistsPage({super.key});

  @override
  State<ChecklistsPage> createState() => _ChecklistsPageState();
}

class _ChecklistsPageState extends State<ChecklistsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsBloc, ChecklistsState>(
      bloc: bloc,
      builder: (context, checklistsPageState) {
        return SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: checklistsPageState.filter == "All"
                          ? null
                          : () {
                              bloc.add(const ChecklistsEventOnFilterChanged(filter: "All"));
                            },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: checklistsPageState.filter == "All" ? Colors.orange[100] : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.orange,
                          ),
                        ),
                        height: 50,
                        width: 128,
                        child: Text(
                          checklistsPageState.filter == "All" ? "• All" : "All",
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: checklistsPageState.filter == "Progress"
                          ? null
                          : () {
                              bloc.add(const ChecklistsEventOnFilterChanged(filter: "Progress"));
                            },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: checklistsPageState.filter == "Progress" ? Colors.orange[100] : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.orange,
                          ),
                        ),
                        height: 50,
                        width: 128,
                        child: Text(
                          checklistsPageState.filter == "Progress" ? "• In progress" : "In progress",
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: checklistsPageState.filter == "Done"
                          ? null
                          : () {
                              bloc.add(const ChecklistsEventOnFilterChanged(filter: "Done"));
                            },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: checklistsPageState.filter == "Done" ? Colors.orange[100] : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.orange,
                          ),
                        ),
                        height: 50,
                        width: 128,
                        child: Text(
                          checklistsPageState.filter == "Done" ? "• Done" : "Done",
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
                        ...checklistsPageState.checklists.mapIndexed(
                          (index, e) => ChecklistWidget(index, e),
                        ),
                        Container(
                          height: 1,
                          color: Colors.orange[100],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                        return const NewChecklistDialog();
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
      },
    );
  }
}

class ChecklistWidget extends StatefulWidget {
  final int index;
  final Checklist checklist;
  const ChecklistWidget(this.index, this.checklist, {super.key});

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  List<String> getText(List<ChecklistEntry> list) {
    int doneItems = 0;
    int notDoneItems = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].checked == true) {
        doneItems = doneItems + 1;
      } else {
        notDoneItems = notDoneItems + 1;
      }
    }
    String subtextTwo = '';
    if (doneItems == list.length) {
      subtextTwo = "All items done";
    } else {
      subtextTwo = "Done: $doneItems / Pending: $notDoneItems";
    }
    String subtextOne = "Items: ${list.length}";
    List<String> text = [subtextOne, subtextTwo];
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
              return SingleChecklistPage(widget.checklist, widget.index);
            },
          ),
        );
      },
      child: Container(
        height: 91,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.checklist.title,
                        style: TextStyle(
                          color: Colors.orange[100]!,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (widget.checklist.content.isEmpty) ...[
                            const Text(
                              "No Item",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            )
                          ] else ...[
                            Text(
                              getText(widget.checklist.content)[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              maxLines: 1,
                            ),
                            Expanded(
                              child: Text(
                                getText(widget.checklist.content)[1],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: IconButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteChecklistDialog(widget.checklist);
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
          ],
        ),
      ),
    );
  }
}
