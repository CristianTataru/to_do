import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/add_entry_page.dart';
import 'package:to_do_list/model/entry.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Entry> listWithDate = [
    Entry("Haircut", DateTime.tryParse("2023-04-15 15:45"), true),
    Entry('Buy Gift', DateTime.tryParse("2023-04-17"), false),
    Entry("Change Tires", DateTime.tryParse("2023-05-15 15:45"), false),
  ];
  final List<Entry> listWithoutDate = [
    Entry("Feed cat", null, false),
    Entry('Clean house', null, false),
    Entry("Fix sink", null, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
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
              Column(
                children: listWithDate.map((e) => EntryWidget(e)).toList(),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.orange[100]!),
                        bottom: BorderSide(color: Colors.orange[100]!),
                      ),
                    ),
                    width: double.infinity,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Others",
                            style: TextStyle(
                              color: Colors.orange[100],
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " - ${listWithoutDate[0].name}",
                            style: const TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const AddEntryPage();
                          },
                        ),
                      );
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
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EntryWidget extends StatefulWidget {
  final Entry entry;
  const EntryWidget(this.entry, {super.key});

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.orange[100]!),
        ),
      ),
      width: double.infinity,
      height: 80,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateFormatter.format(widget.entry.date!),
              style: TextStyle(
                color: Colors.orange[100],
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  widget.entry.hasTime == false ? "" : timeFormatter.format(widget.entry.date!),
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
                const Text(
                  " - ",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  widget.entry.name,
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
