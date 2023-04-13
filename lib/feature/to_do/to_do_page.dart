import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../database/database.dart';
import '../../model/entry.dart';
import '../add_entry/add_entry_page.dart';
import '../date_page/date_page.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
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
              child: Column(
                children: [
                  ...database
                      .getEntries()
                      .map(
                        (e) => EntryWidget(() {
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
              style: TextStyle(color: Colors.white, fontSize: 25),
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
  final void Function() homeCallback;
  final List<Entry> entryList;
  const EntryWidget(this.homeCallback, this.entryList, {super.key});

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.orange[100],
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DatePage(
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
