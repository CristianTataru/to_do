import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/model/entry.dart';

class DatePage extends StatefulWidget {
  final DateTime? date;
  final List<Entry> todayEntries;
  const DatePage(this.date, this.todayEntries, {super.key});

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  static final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');
  String pageTitle = '';
  @override
  Widget build(BuildContext context) {
    if (widget.date == null) {
      pageTitle = "Others";
    } else {
      pageTitle = dateFormatter.format(widget.date!);
    }
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
            ...widget.todayEntries.map((e) => ShowEntry(e))
          ],
        ),
      ),
    );
  }
}

class ShowEntry extends StatefulWidget {
  final Entry entry;
  const ShowEntry(this.entry, {super.key});

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
        Text(
          widget.entry.hasTime
              ? "${timeFormatter.format(widget.entry.date!)} - ${widget.entry.name}"
              : widget.entry.name,
          style: const TextStyle(color: Colors.white, fontSize: 25),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
