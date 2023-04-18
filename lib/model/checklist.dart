class Checklist {
  String title;
  List<ChecklistEntry> content;

  Checklist(this.title, this.content);
}

class ChecklistEntry {
  String name;
  bool checked;

  ChecklistEntry(this.name, this.checked);
}
