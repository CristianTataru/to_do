import 'package:flutter/material.dart';
import 'package:to_do_list/add_entry_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              const Text(
                "To Do List",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              ElevatedButton(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
