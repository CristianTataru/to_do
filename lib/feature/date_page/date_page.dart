import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/feature/home/home_page.dart';
import 'package:to_do_list/model/entry.dart';

class DatePage extends StatefulWidget {
  final void Function() homeCallback;
  final DateTime? entryKey;
  const DatePage(this.homeCallback, this.entryKey, {super.key});

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    final todayEntries = database.getEntryList(widget.entryKey);
    final pageTitle = widget.entryKey == null ? "Others" : dateFormatter.format(widget.entryKey!);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 1,
                      color: Colors.orange[100],
                    ),
                    ...todayEntries.map(
                      (e) => ShowEntry(() {
                        widget.homeCallback();
                        setState(() {});
                      }, e),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowEntry extends StatefulWidget {
  final void Function() callback;
  final Entry entry;
  const ShowEntry(this.callback, this.entry, {super.key});

  @override
  State<ShowEntry> createState() => _ShowEntryState();
}

class _ShowEntryState extends State<ShowEntry> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');
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
              PopupMenuButton(
                onSelected: (value) {
                  if (value == "Done") {
                    setState(() {
                      widget.entry.isDone = true;
                      widget.callback();
                    });
                  } else if (value == "Undone") {
                    setState(() {
                      widget.entry.isDone = false;
                      widget.callback();
                    });
                  } else if (value == "Delete") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete entry"),
                            content: const Text(
                              "Are you sure you want to delete this entry?",
                              style: TextStyle(fontSize: 25),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (widget.entry.date == null) {
                                    if (database.toDos[null]!.length == 1) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const HomePage();
                                          },
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        database.toDos[null]!.remove(widget.entry);
                                        widget.callback();
                                      });
                                    }
                                  }
                                  if (widget.entry.date != null) {
                                    if (database
                                            .toDos[DateTime(
                                          widget.entry.date!.year,
                                          widget.entry.date!.month,
                                          widget.entry.date!.day,
                                        )]!
                                            .length ==
                                        1) {
                                      Navigator.of(context).pop();
                                      database.toDos[DateTime(
                                        widget.entry.date!.year,
                                        widget.entry.date!.month,
                                        widget.entry.date!.day,
                                      )]!
                                          .remove(widget.entry);
                                      widget.callback();
                                    } else {
                                      setState(() {
                                        database.toDos[DateTime(
                                          widget.entry.date!.year,
                                          widget.entry.date!.month,
                                          widget.entry.date!.day,
                                        )]!
                                            .remove(widget.entry);
                                        widget.callback();
                                      });
                                    }
                                  }
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
                        });
                  }
                },
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
