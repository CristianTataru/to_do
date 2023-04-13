import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/model/entry.dart';

class EditDialog extends StatefulWidget {
  final Entry entry;
  const EditDialog(this.entry, {super.key});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  TextEditingController textController = TextEditingController();
  TimeOfDay? oraAleasa;

  @override
  void initState() {
    textController.text = widget.entry.name;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void editHourAndMinutes() async {
    oraAleasa = await showTimePicker(
      context: context,
      initialTime: widget.entry.hasTime
          ? TimeOfDay(hour: widget.entry.date!.hour, minute: widget.entry.date!.minute)
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[100],
      title: const Text("Edit"),
      content: Column(
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
              backgroundColor: widget.entry.date == null ? Colors.grey : Colors.orange,
            ),
            onPressed: widget.entry.date == null ? null : editHourAndMinutes,
            label: Text(
              oraAleasa == null
                  ? (widget.entry.hasTime ? timeFormatter.format(widget.entry.date!) : "Select Hour")
                  : "${oraAleasa!.hour}:${oraAleasa!.minute}",
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(
              () {
                // ignore: prefer_conditional_assignment
                if (oraAleasa == null) {
                  oraAleasa = widget.entry.hasTime
                      ? TimeOfDay(hour: widget.entry.date!.hour, minute: widget.entry.date!.minute)
                      : null;
                } else {
                  widget.entry.hasTime = true;
                  widget.entry.date = DateTime(
                    widget.entry.date!.year,
                    widget.entry.date!.month,
                    widget.entry.date!.day,
                    oraAleasa!.hour,
                    oraAleasa!.minute,
                  );
                }
                widget.entry.name = textController.text;
              },
            );
            Navigator.of(context).pop();
          },
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
    );
  }
}
