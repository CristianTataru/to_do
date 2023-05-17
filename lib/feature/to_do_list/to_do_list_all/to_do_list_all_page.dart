import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_all/add_entry_page.dart';
import 'package:to_do_list/feature/to_do_list/bloc/to_do_list_all_page_bloc.dart';
import 'package:to_do_list/feature/to_do_list/to_do_list_by_date/to_do_list_by_date_page.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/priority.dart';
import 'package:collection/collection.dart';

final bloc = ToDoListBloc();

class ToDoListAllPage extends StatefulWidget {
  const ToDoListAllPage({super.key});

  @override
  State<ToDoListAllPage> createState() => _ToDoListAllPageState();
}

class _ToDoListAllPageState extends State<ToDoListAllPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      bloc: bloc,
      builder: (context, toDoListPageState) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                height: 50,
                child: Row(
                  children: [
                    Container(
                      color: Colors.orange[100],
                      height: 45,
                      alignment: Alignment.center,
                      child: const Text(
                        "Filter by priority:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Checkbox(
                              value: toDoListPageState.priority == null,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.black;
                                },
                              ),
                              onChanged: toDoListPageState.priority == null
                                  ? null
                                  : (value) {
                                      bloc.add(ToDoListEventOnPriorityAll());
                                    },
                            ),
                            const Text(
                              "All",
                              style: TextStyle(fontSize: 20),
                            ),
                            Checkbox(
                              value: toDoListPageState.priority == EntryPriority.low,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.green;
                                },
                              ),
                              onChanged: toDoListPageState.priority == EntryPriority.low
                                  ? null
                                  : (value) {
                                      bloc.add(const ToDoListEventOnPriorityChanged(priority: EntryPriority.low));
                                    },
                            ),
                            const Text(
                              "Low",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                            Checkbox(
                              value: toDoListPageState.priority == EntryPriority.medium,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.yellow[600]!;
                                },
                              ),
                              onChanged: toDoListPageState.priority == EntryPriority.medium
                                  ? null
                                  : (value) {
                                      bloc.add(const ToDoListEventOnPriorityChanged(priority: EntryPriority.medium));
                                    },
                            ),
                            Text(
                              "Medium",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.yellow[600],
                              ),
                            ),
                            Checkbox(
                              value: toDoListPageState.priority == EntryPriority.high,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.red;
                                },
                              ),
                              onChanged: toDoListPageState.priority == EntryPriority.high
                                  ? null
                                  : (value) {
                                      bloc.add(const ToDoListEventOnPriorityChanged(priority: EntryPriority.high));
                                    },
                            ),
                            const Text(
                              "High",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "To Do List",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[100],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...toDoListPageState.dataList
                          .mapIndexed(
                            (index, e) => EntryWidget(index, e),
                          )
                          .toList(),
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
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const AddEntryPage();
                      },
                    ),
                  );
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: const Size(150, 50),
                ),
                child: const Text(
                  "Add Entry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}

class EntryWidget extends StatefulWidget {
  final int index;
  final List<Entry> entryList;
  const EntryWidget(this.index, this.entryList, {super.key});

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');

  bool hasPriority(EntryPriority priority) {
    bool x = false;
    for (int i = 0; i < widget.entryList.length; i++) {
      if (widget.entryList[i].priority == priority) {
        x = true;
        break;
      }
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.orange[100],
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ToDoListByDatePage(widget.entryList.first.date, widget.index);
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
                Text(
                  widget.entryList[0].date == null
                      ? "Others"
                      : dateFormatter.format(
                          widget.entryList[0].date!,
                        ),
                  style: TextStyle(
                    color: Colors.orange[100],
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.entryList[0].date == null ? "" : DateFormat('EEEE').format(widget.entryList[0].date!),
                  style: const TextStyle(color: Colors.orange, fontSize: 25),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  widget.entryList[0].hasTime == false
                      ? ""
                      : timeFormatter.format(
                          widget.entryList[0].date!,
                        ),
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
                const Text(
                  " - ",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  widget.entryList[0].name.length < 20
                      ? widget.entryList[0].name
                      : "${widget.entryList[0].name.substring(0, 20)}...",
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  maxLines: 1,
                ),
                const Spacer(),
                Visibility(
                  visible: hasPriority(EntryPriority.low),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 7,
                  ),
                ),
                SizedBox(
                  width: hasPriority(EntryPriority.low) == true ? 20 : 40,
                ),
                Visibility(
                  visible: hasPriority(EntryPriority.medium),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 7,
                  ),
                ),
                SizedBox(
                  width: hasPriority(EntryPriority.medium) == true ? 20 : 35,
                ),
                Visibility(
                  visible: hasPriority(EntryPriority.high),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 7,
                  ),
                ),
                SizedBox(
                  width: hasPriority(EntryPriority.high) == true ? 0 : 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
