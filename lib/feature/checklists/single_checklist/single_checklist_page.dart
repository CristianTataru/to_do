import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/feature/checklists/bloc/checklists_bloc.dart';
import 'package:to_do_list/feature/checklists/checklists/checklists_page.dart';
import 'package:to_do_list/feature/checklists/single_checklist/add_item_dialog.dart';
import 'package:to_do_list/feature/checklists/single_checklist/delete_item_dialog.dart';
import 'package:to_do_list/model/checklist.dart';

class SingleChecklistPage extends StatefulWidget {
  final Checklist checklist;
  final int index;
  const SingleChecklistPage(this.checklist, this.index, {super.key});

  @override
  State<SingleChecklistPage> createState() => _SingleChecklistPageState();
}

class _SingleChecklistPageState extends State<SingleChecklistPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsBloc, ChecklistsState>(
      bloc: bloc,
      builder: (context, singleChecklistPageState) {
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
                        ...getChecklistData(singleChecklistPageState.checklists[widget.index]).map(
                          (e) => ShowTask(e, widget.index),
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
                          return AddItemDialog(widget.index);
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
      },
    );
  }
}

class ShowTask extends StatefulWidget {
  final ChecklistEntry entry;
  final int index;
  const ShowTask(this.entry, this.index, {super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  void deleteItem() async {
    await showDialog(
      context: context,
      builder: (context) {
        return DeleteItemDialog(widget.index, widget.entry);
      },
    );
  }

  void checklistItemDoneUndone(int index, ChecklistEntry entry) {
    bloc.add(ChecklistsEventOnChecklistItemDoneUndone(index: index, entry: entry));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            checklistItemDoneUndone(widget.index, widget.entry);
          },
          child: Row(
            children: [
              Checkbox(
                shape: const StadiumBorder(),
                value: widget.entry.checked,
                onChanged: (bool? checkBoxValue) {
                  checklistItemDoneUndone(widget.index, widget.entry);
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
              Expanded(
                child: Text(
                  widget.entry.name,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
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

List<ChecklistEntry> getChecklistData(Checklist a) {
  List<ChecklistEntry> myList = a.content;
  myList.sort((a, b) {
    if (a.checked == b.checked) {
      return a.name.compareTo(b.name);
    }
    return b.checked ? -1 : 1;
  });
  return myList;
}
