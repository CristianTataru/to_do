import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/model/entry.dart';

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
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void selectHourAndMinutes() async {
    oraAleasa = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
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
    setState(
      () {
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
      },
    );
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Add Entry"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    "Select Date:",
                    style: TextStyle(color: Colors.orange[100], fontSize: 30),
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
                  Text(
                    "Day:",
                    style: TextStyle(color: Colors.orange[100], fontSize: 30),
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
                  Text(
                    "Select Hour:",
                    style: TextStyle(color: Colors.orange[100], fontSize: 30),
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
                      backgroundColor: dataAleasa == null ? Colors.grey : Colors.orange,
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
              TextField(
                controller: textController,
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  label: const Text(
                    "Text",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]!),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  disabledBackgroundColor: Colors.grey,
                  fixedSize: const Size(100, 50),
                ),
                onPressed: textController.text.isEmpty
                    ? null
                    : () {
                        database.addEntry(
                          Entry(
                            textController.text,
                            dataAleasa,
                            oraAleasa != null,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}