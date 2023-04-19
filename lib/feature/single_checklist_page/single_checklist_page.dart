import 'package:flutter/material.dart';
import 'package:to_do_list/model/checklist.dart';
import 'package:to_do_list/database/database.dart';

class SingleChecklistPage extends StatefulWidget {
  final void Function() homeCallback;
  final Checklist checklist;
  const SingleChecklistPage(this.homeCallback, this.checklist, {super.key});

  @override
  State<SingleChecklistPage> createState() => _SingleChecklistPageState();
}

class _SingleChecklistPageState extends State<SingleChecklistPage> {
  @override
  Widget build(BuildContext context) {
    final tasks = database.getChecklistData(widget.checklist);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.checklist.title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.checklist.title,
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
                    ...tasks.map(
                      (e) => ShowTask(e, () {
                        widget.homeCallback();
                        setState(() {});
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowTask extends StatefulWidget {
  final ChecklistEntry entry;
  final void Function() callback;
  const ShowTask(this.entry, this.callback, {super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  void changeVisibility() {
    setState(() {
      widget.entry.checked = widget.entry.checked == false ? true : false;
      widget.callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: changeVisibility,
          child: Row(
            children: [
              Checkbox(
                shape: const StadiumBorder(),
                value: widget.entry.checked,
                onChanged: (bool? checkBoxValue) {
                  setState(() {
                    // ignore: prefer_if_null_operators
                    widget.entry.checked = checkBoxValue == null ? false : checkBoxValue;
                    widget.callback();
                  });
                },
                checkColor: Colors.black,
                fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    return Colors.orange;
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.entry.name,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.orange,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
