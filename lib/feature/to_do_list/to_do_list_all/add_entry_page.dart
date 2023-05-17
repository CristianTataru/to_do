import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/feature/to_do_list/bloc/to_do_list_all_page_bloc.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_all/to_do_list_all_page.dart';

import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/priority.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  static final DateFormat dateFormatter = DateFormat('dd.MM.yyyy');
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  DateTime? chosenDate;
  TimeOfDay? chosenTime;
  String formatted = "";
  String formatted2 = '';
  TextEditingController textController = TextEditingController();
  EntryPriority priority = EntryPriority.low;
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

  void selectHourAndMinutes() async {
    chosenTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
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
    setState(
      () {
        if (chosenTime == null) {
          return;
        }
        chosenDate = DateTime(
          chosenDate!.year,
          chosenDate!.month,
          chosenDate!.day,
          chosenTime!.hour,
          chosenTime!.minute,
        );
      },
    );
  }

  Color getTextColor() {
    Color color = Colors.white;
    if (priority == EntryPriority.low) {
      color = Colors.green;
    } else if (priority == EntryPriority.medium) {
      color = Colors.yellow;
    } else if (priority == EntryPriority.high) {
      color = Colors.red;
    }
    return color;
  }

  void selectDate() async {
    chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      bloc: bloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text("Add entry"),
              backgroundColor: Colors.orange,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "Select Date:",
                          style: TextStyle(
                            color: Colors.orange[100],
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.white,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: selectDate,
                          label: Text(
                            chosenDate == null ? "Select Date" : dateFormatter.format(chosenDate!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: chosenDate == null ? true : false,
                      child: const Text(
                        'If no date is selected the entry will automatically go in "Others".',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          "Day:",
                          style: TextStyle(
                            color: Colors.orange[100],
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Text(
                          chosenDate == null ? "" : DateFormat('EEEE').format(chosenDate!),
                          style: const TextStyle(color: Colors.orange, fontSize: 30),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Select Hour:",
                          style: TextStyle(
                            color: Colors.orange[100],
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.white,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: chosenDate == null ? Colors.grey : Colors.orange,
                          ),
                          onPressed: chosenDate == null ? null : selectHourAndMinutes,
                          label: Text(
                            chosenTime == null ? "Select Time" : timeFormatter.format(chosenDate!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Priority:",
                          style: TextStyle(
                            color: Colors.orange[100],
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Checkbox(
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.red;
                            },
                          ),
                          value: priority == EntryPriority.high,
                          onChanged: priority == EntryPriority.high
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      priority = EntryPriority.high;
                                    },
                                  );
                                },
                        ),
                        Checkbox(
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.yellow;
                            },
                          ),
                          value: priority == EntryPriority.medium,
                          onChanged: priority == EntryPriority.medium
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      priority = EntryPriority.medium;
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
                          value: priority == EntryPriority.low,
                          onChanged: priority == EntryPriority.low
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      priority = EntryPriority.low;
                                    },
                                  );
                                },
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          priority.toString(),
                          style: TextStyle(color: getTextColor(), fontSize: 25),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: textController,
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: const Text(
                          "Text",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[100]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[100]!),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 235,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        disabledBackgroundColor: Colors.grey,
                        fixedSize: const Size(100, 50),
                      ),
                      onPressed: textController.text.isEmpty
                          ? null
                          : () {
                              bloc.add(ToDoListEventItemAdded(
                                  entry: Entry(textController.text, chosenDate, chosenTime != null, false, priority)));
                              Navigator.of(context).pop();
                            },
                      child: const Text(
                        "Done",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
