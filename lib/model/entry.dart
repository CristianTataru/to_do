import 'package:to_do_list/model/priority.dart';

class Entry {
  String name;
  DateTime? date;
  bool hasTime;
  bool isDone;
  EntryPriority priority;

  Entry(this.name, this.date, this.hasTime, this.isDone, this.priority);

  Entry.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = json['date'] == "null" ? null : DateTime.parse(json['date']),
        hasTime = json['hasTime'],
        isDone = json['isDone'],
        priority = EntryPriority.fromJson(json['priority']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date.toString(),
        "hasTime": hasTime,
        'isDone': isDone,
        'priority': priority.toJson(),
      };
}
