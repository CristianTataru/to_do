import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/priority.dart';
import '../../model/entry.dart';
import '../add_entry/add_entry_page.dart';
import '../date_page/date_page.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  bool? isCheckedHigh = false;
  bool? isCheckedMedium = false;
  bool? isCheckedLow = false;
  bool? isCheckedAll = true;
  EntryPriority? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
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
                          value: isCheckedAll,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.black;
                            },
                          ),
                          onChanged: isCheckedAll == true
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      selectedPriority = null;
                                      isCheckedAll = value;
                                      isCheckedMedium = false;
                                      isCheckedLow = false;
                                      isCheckedHigh = false;
                                    },
                                  );
                                },
                        ),
                        const Text(
                          "All",
                          style: TextStyle(fontSize: 20),
                        ),
                        Checkbox(
                          value: isCheckedLow,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.green;
                            },
                          ),
                          onChanged: isCheckedLow == true
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      selectedPriority = EntryPriority.low;
                                      isCheckedLow = value;
                                      isCheckedMedium = false;
                                      isCheckedHigh = false;
                                      isCheckedAll = false;
                                    },
                                  );
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
                          value: isCheckedMedium,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.yellow[600]!;
                            },
                          ),
                          onChanged: isCheckedMedium == true
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      selectedPriority = EntryPriority.medium;
                                      isCheckedMedium = value;
                                      isCheckedHigh = false;
                                      isCheckedLow = false;
                                      isCheckedAll = false;
                                    },
                                  );
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
                          value: isCheckedHigh,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.red;
                            },
                          ),
                          onChanged: isCheckedHigh == true
                              ? null
                              : (value) {
                                  setState(
                                    () {
                                      selectedPriority = EntryPriority.high;
                                      isCheckedHigh = value;
                                      isCheckedMedium = false;
                                      isCheckedLow = false;
                                      isCheckedAll = false;
                                    },
                                  );
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
            "My Planner",
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
                  ...databaseRepository
                      .getFilteredEntries(selectedPriority)
                      .map(
                        (e) => EntryWidget(selectedPriority, () {
                          setState(() {});
                        }, e),
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
  }
}

class EntryWidget extends StatefulWidget {
  final EntryPriority? dayPriority;
  final void Function() homeCallback;
  final List<Entry> entryList;
  const EntryWidget(this.dayPriority, this.homeCallback, this.entryList, {super.key});

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
              return DatePage(
                widget.dayPriority,
                widget.homeCallback,
                widget.entryList.first.date == null
                    ? null
                    : DateTime(
                        widget.entryList.first.date!.year,
                        widget.entryList.first.date!.month,
                        widget.entryList.first.date!.day,
                      ),
              );
            },
          ),
        );
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
                  widget.entryList[0].name,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
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
