import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/feature/to_do_list/bloc/to_do_list_all_page_bloc.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_all/to_do_list_all_page.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_by_date/delete_confirm_dialog.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_by_date/edit_entry_dialog.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/priority.dart';

class ToDoListByDatePage extends StatefulWidget {
  final DateTime? date;
  final int index;
  const ToDoListByDatePage(this.date, this.index, {super.key});

  @override
  State<ToDoListByDatePage> createState() => _ToDoListByDatePageState();
}

class _ToDoListByDatePageState extends State<ToDoListByDatePage> {
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      bloc: bloc,
      builder: (context, toDoListByDatePageState) {
        List<Entry> dataList = toDoListByDatePageState.dataList.isEmpty
            ? []
            : widget.index > toDoListByDatePageState.dataList.length - 1
                ? []
                : toDoListByDatePageState.dataList[widget.index];
        if ((dataList.isNotEmpty &&
            ((widget.date == null && dataList.first.date != null) ||
                (widget.date != null && dataList.first.date == null) ||
                (widget.date != null &&
                    dataList.first.date != null &&
                    (widget.date!.year != dataList.first.date!.year ||
                        widget.date!.month != dataList.first.date!.month ||
                        widget.date!.day != dataList.first.date!.day))))) {
          dataList = [];
        }
        if (dataList.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
        }
        final pageTitle = dataList.isEmpty
            ? ""
            : dataList.first.date == null
                ? "Others"
                : dateFormatter.format(dataList.first.date!);
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(pageTitle),
            backgroundColor: Colors.orange,
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  pageTitle,
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
                        Container(
                          height: 1,
                          color: Colors.orange[100],
                        ),
                        ...dataList.map((e) => ShowEntry(dataList, e))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShowEntry extends StatefulWidget {
  final List<Entry> datalist;
  final Entry entry;
  const ShowEntry(this.datalist, this.entry, {super.key});

  @override
  State<ShowEntry> createState() => _ShowEntryState();
}

class _ShowEntryState extends State<ShowEntry> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');

  void onPopupButtonPressed(String value) {
    if (value == "Done") {
      onEntryDone();
    } else if (value == "Undone") {
      onEntryUndone();
    } else if (value == "Delete") {
      onEntryDelete();
    } else if (value == "Edit") {
      onEntryEdit();
    }
  }

  void onEntryDone() {
    bloc.add(ToDoListEventItemDone(entry: widget.entry));
  }

  void onEntryUndone() {
    bloc.add(ToDoListEventItemUnDone(entry: widget.entry));
  }

  void onEntryDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmDialog(widget.entry);
      },
    );
  }

  void onEntryEdit() async {
    await showDialog(
      context: context,
      builder: (context) {
        return EditEntryDialog(widget.entry);
      },
    );
  }

  Color getTextColor() {
    Color color = Colors.white;
    if (widget.entry.priority == EntryPriority.low) {
      color = Colors.green;
    } else if (widget.entry.priority == EntryPriority.medium) {
      color = Colors.yellow;
    } else if (widget.entry.priority == EntryPriority.high) {
      color = Colors.red;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.orange[100]!),
            ),
          ),
          child: Row(
            children: [
              Visibility(
                visible: widget.entry.isDone,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                height: 50,
                width: 10,
              ),
              Text(
                widget.entry.hasTime
                    ? "${timeFormatter.format(widget.entry.date!)} - ${widget.entry.name}"
                    : widget.entry.name,
                style: const TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              Text(
                widget.entry.priority.toString(),
                style: TextStyle(
                  color: getTextColor(),
                  fontSize: 20,
                ),
              ),
              PopupMenuButton(
                onSelected: onPopupButtonPressed,
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "Edit",
                      child: Text(
                        "Edit",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    PopupMenuItem(
                      value: widget.entry.isDone ? "Undone" : "Done",
                      child: Text(
                        widget.entry.isDone ? "Undone" : "Done",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    const PopupMenuItem(
                      value: "Delete",
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ];
                },
                color: Colors.orange[100],
                icon: const Icon(Icons.menu),
              )
            ],
          ),
        ),
      ],
    );
  }
}
