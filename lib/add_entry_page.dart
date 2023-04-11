import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  static final DateFormat dateFormatter = DateFormat('dd.MM.yyyy');
  static final DateFormat timeFormatter = DateFormat('HH:mm');
  DateTime? dataAleasa;
  TimeOfDay? oraAleasa;
  String formatted = "";
  String formatted2 = '';

  void selectHourAndMinutes() async {
    oraAleasa = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.orange),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      if (oraAleasa == null) {
        return;
      }
      dataAleasa = DateTime(
        dataAleasa!.year,
        dataAleasa!.month,
        dataAleasa!.day,
        oraAleasa!.hour,
        oraAleasa!.minute,
      );
    });
  }

  void selectDate() async {
    dataAleasa = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025, 12, 31),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.orange),
              ),
              child: child!);
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Add Entry"),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const Text(
                    "Select Date:",
                    style: TextStyle(color: Colors.orange, fontSize: 30),
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
                      dataAleasa == null ? "Select Date" : dateFormatter.format(dataAleasa!),
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
                  const Text(
                    "Day",
                    style: TextStyle(color: Colors.orange, fontSize: 30),
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Text(
                    dataAleasa == null ? "" : DateFormat('EEEE').format(dataAleasa!),
                    style: const TextStyle(color: Colors.orange, fontSize: 30),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    "Select Hour:",
                    style: TextStyle(color: Colors.orange, fontSize: 30),
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
                    onPressed: dataAleasa == null ? null : selectHourAndMinutes,
                    label: Text(
                      oraAleasa == null ? "Select Time" : timeFormatter.format(dataAleasa!),
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
              const TextField(
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  label: Text(
                    "Text",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
