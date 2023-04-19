class Checklist {
  String title;
  List<ChecklistEntry> content;

  Checklist(this.title, this.content);

  Checklist.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = (json['content'] as List).map((e) => ChecklistEntry.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };
}

class ChecklistEntry {
  String name;
  bool checked;

  ChecklistEntry(this.name, this.checked);

  ChecklistEntry.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        checked = json['checked'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'checked': checked,
      };
}
