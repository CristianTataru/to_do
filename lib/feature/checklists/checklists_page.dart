import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/feature/single_checklist_page/single_checklist_page.dart';
import 'package:to_do_list/model/checklist.dart';

class ChecklistsPage extends StatefulWidget {
  const ChecklistsPage({super.key});

  @override
  State<ChecklistsPage> createState() => _ChecklistsPageState();
}

class _ChecklistsPageState extends State<ChecklistsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "My Checklists",
              style: TextStyle(
                color: Colors.orange[100]!,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ...database.checklists.map(
                      (e) => ChecklistWidget(() {
                        setState(() {});
                      }, e),
                    ),
                    Container(
                      height: 1,
                      color: Colors.orange[100],
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                fixedSize: const Size(150, 50),
              ),
              onPressed: () {},
              child: const Text(
                "New Checklist",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class ChecklistWidget extends StatefulWidget {
  final void Function() homeCallback;
  final Checklist checklist;
  const ChecklistWidget(this.homeCallback, this.checklist, {super.key});

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.orange[100],
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SingleChecklistPage(widget.homeCallback, widget.checklist);
            },
          ),
        );
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.orange[100]!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.checklist.title,
              style: TextStyle(
                color: Colors.orange[100]!,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              database.getChecklistData(widget.checklist).first.name,
              style: const TextStyle(color: Colors.white, fontSize: 25),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
