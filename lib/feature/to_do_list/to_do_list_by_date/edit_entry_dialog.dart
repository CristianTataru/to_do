import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/feature/to_do_list/bloc/to_do_list_all_page_bloc.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_all/to_do_list_all_page.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/priority.dart';

class EditEntryDialog extends StatefulWidget {
  final Entry entry;
  const EditEntryDialog(this.entry, {super.key});

  @override
  State<EditEntryDialog> createState() => _EditEntryDialogState();
}

class _EditEntryDialogState extends State<EditEntryDialog> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  TextEditingController textController = TextEditingController();
  TimeOfDay? chosenTime;
  late Entry newEntry = widget.entry.copyWith();
  late EntryPriority priority = widget.entry.priority;
  late bool isLow = newEntry.priority == EntryPriority.low;
  late bool isMedium = newEntry.priority == EntryPriority.medium;
  late bool isHigh = newEntry.priority == EntryPriority.high;

  @override
  void initState() {
    textController.text = newEntry.name;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void editHourAndMinutes() async {
    chosenTime = await showTimePicker(
      context: context,
      initialTime: newEntry.hasTime
          ? TimeOfDay(hour: newEntry.date!.hour, minute: newEntry.date!.minute)
          : const TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {});
  }

  void onDonePressed() {
    bool hasTime = newEntry.hasTime;
    DateTime? aaa;
    if (chosenTime == null) {
      chosenTime = newEntry.hasTime ? TimeOfDay(hour: newEntry.date!.hour, minute: newEntry.date!.minute) : null;
      databaseRepository.saveAppData();
    } else {
      hasTime = true;
      aaa = DateTime(
        newEntry.date!.year,
        newEntry.date!.month,
        newEntry.date!.day,
        chosenTime!.hour,
        chosenTime!.minute,
      );
      databaseRepository.saveAppData();
    }
    String name = textController.text;
    Entry entryToAdd = newEntry.copyWith(name: name, date: aaa, hasTime: hasTime, priority: priority);
    bloc.add(ToDoListEventItemEdited(entryDeleted: widget.entry, entryAdded: entryToAdd));
    Navigator.of(context).pop();
  }

  Color getTextColor() {
    Color color = Colors.white;
    if (isLow) {
      color = Colors.green;
    } else if (isMedium) {
      color = Colors.yellow[700]!;
    } else if (isHigh) {
      color = Colors.red;
    }
    return color;
  }

  String getText() {
    String text = '';
    if (isLow) {
      text = "Low";
    } else if (isMedium) {
      text = 'Medium';
    } else if (isHigh) {
      text = 'High';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      bloc: bloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: AlertDialog(
            backgroundColor: Colors.orange[100],
            title: const Text("Edit"),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit hour:",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.black,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: newEntry.date == null ? Colors.grey : Colors.orange,
                    ),
                    onPressed: newEntry.date == null ? null : editHourAndMinutes,
                    label: Text(
                      chosenTime == null
                          ? (newEntry.hasTime ? timeFormatter.format(newEntry.date!) : "Select Hour")
                          : "${chosenTime!.hour}:${chosenTime!.minute}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Edit Name:",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: textController,
                    minLines: 3,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      label: Text(
                        "Text",
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Edit Priority:",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.red;
                          },
                        ),
                        value: isHigh,
                        onChanged: isHigh
                            ? null
                            : (value) {
                                setState(
                                  () {
                                    priority = EntryPriority.high;
                                    isHigh = true;
                                    isMedium = false;
                                    isLow = false;
                                    databaseRepository.saveAppData();
                                  },
                                );
                              },
                      ),
                      Checkbox(
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.yellow[700]!;
                          },
                        ),
                        value: isMedium,
                        onChanged: isMedium
                            ? null
                            : (value) {
                                setState(
                                  () {
                                    priority = EntryPriority.medium;
                                    isHigh = false;
                                    isMedium = true;
                                    isLow = false;
                                    databaseRepository.saveAppData();
                                  },
                                );
                              },
                      ),
                      Checkbox(
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.green;
                          },
                        ),
                        value: isLow,
                        onChanged: isLow
                            ? null
                            : (value) {
                                setState(
                                  () {
                                    priority = EntryPriority.low;
                                    isHigh = false;
                                    isMedium = false;
                                    isLow = true;
                                    databaseRepository.saveAppData();
                                  },
                                );
                              },
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        getText(),
                        style: TextStyle(color: getTextColor(), fontSize: 25),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: onDonePressed,
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
