import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_do_list/feature/notes/notes_page.dart';
import 'package:to_do_list/feature/to_do/to_do_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<String> appBar = ["To Do", "Notes"];
  final screens = [const ToDoPage(), const NotesPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(appBar[currentIndex]),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const ShapeDecoration(
          color: Colors.orange,
          shape: StadiumBorder(),
        ),
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: GNav(
            backgroundColor: Colors.orange,
            color: Colors.white,
            tabBackgroundColor: Colors.black26,
            gap: 8,
            padding: const EdgeInsets.all(12),
            selectedIndex: currentIndex,
            onTabChange: (index) => setState(
              () {
                currentIndex = index;
              },
            ),
            tabs: const [
              GButton(
                icon: Icons.checklist_rounded,
                text: "To Do",
              ),
              GButton(
                icon: Icons.create,
                text: "Notes",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
