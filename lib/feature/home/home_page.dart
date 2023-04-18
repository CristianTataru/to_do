import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_do_list/feature/checklists/checklists_page.dart';
import 'package:to_do_list/feature/notes/notes_page.dart';
import 'package:to_do_list/feature/planner/planner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<String> appBar = ["Planner", "Checklist", "Notes"];
  final screens = [const PlannerPage(), const ChecklistsPage(), const NotesPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(appBar[currentIndex]),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => setState(() {
          currentIndex = value;
        }),
        children: [screens[0], screens[1], screens[2]],
      ),
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
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
            tabs: const [
              GButton(
                icon: Icons.calendar_month_outlined,
                text: "Planner",
              ),
              GButton(
                icon: Icons.checklist_rounded,
                text: "Checklists",
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
