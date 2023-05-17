import 'package:equatable/equatable.dart';
import 'package:to_do_list/model/priority.dart';

class Entry extends Equatable {
  final String name;
  final DateTime? date;
  final bool hasTime;
  final bool isDone;
  final EntryPriority priority;

  const Entry(this.name, this.date, this.hasTime, this.isDone, this.priority);

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

  Entry copyWith({
    String? name,
    DateTime? date,
    bool? hasTime,
    bool? isDone,
    EntryPriority? priority,
  }) {
    return Entry(
      name ?? this.name,
      date ?? this.date,
      hasTime ?? this.hasTime,
      isDone ?? this.isDone,
      priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [name, date, hasTime, isDone, priority];
}
