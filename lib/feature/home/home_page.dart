import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/feature/add_entry/add_entry_page.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/database/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
                        .map((e) => EntryWidget(e, e[0].date == null ? "Others" : dateFormatter.format(e[0].date!)))
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
      ),
    );
  }
}

class EntryWidget extends StatefulWidget {
  final List<Entry> entryList;
  final String name;
  const EntryWidget(this.entryList, this.name, {super.key});

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.orange[100]!),
        ),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.orange[100],
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  widget.entryList[0].hasTime == false ? "" : timeFormatter.format(widget.entryList[0].date!),
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