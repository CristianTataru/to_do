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
  TimeOfDay? oraAleasa;
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
                    onPressed: dataAleasa == null
                        ? null
                        : () async {
                            Future<TimeOfDay?> selectedTime24Hour = showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 10, minute: 47),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );
                            oraAleasa = await selectedTime24Hour;
                            setState(() {
                              if (oraAleasa == null) {
                                return;
                              }
                              dataAleasa = DateTime(dataAleasa!.year, dataAleasa!.month, dataAleasa!.day,
                                  oraAleasa!.hour, oraAleasa!.minute);
                              DateFormat formatter = DateFormat('HH:mm');
                              formatted2 = formatter.format(dataAleasa!);
                            });
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
