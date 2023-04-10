import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  DateTime? dataAleasa;
  DateTime? oraAleasa;
  String formatted = "";
  String formatted2 = '';

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
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2024, 1, 7), onChanged: (date) {
                        setState(() {
                          dataAleasa = date;
                          DateFormat formatter = DateFormat('dd.MM.yyyy');
                          formatted = formatter.format(dataAleasa!);
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    label: Text(
                      dataAleasa == null ? "Select Date" : formatted,
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
                    onPressed: () {
                      DatePicker.showTimePicker(context, showTitleActions: true, onChanged: (time) {
                        setState(() {
                          oraAleasa = time;
                          DateFormat formatter2 = DateFormat('HH:mm:ss');
                          formatted2 = formatter2.format(oraAleasa!);
                        });
                      }, currentTime: DateTime.now());
                    },
                    label: Text(
                      oraAleasa == null ? "Select Time" : formatted2,
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
